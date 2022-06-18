# README

Demonstrate how to work with binary files.

TODO:

* Take an mp3 decode to wav and look at binary structure
* Cut into 5 second chucks
* Build an audio only HLS stream
* Add a chunk to the end of a HLS.
* Host HLS

TODO:

* splice it all back together again
* capture from the phone
* build a website that I can stream audio from 

## Prereqs

```sh
# debian
apt install ffmpeg

# linuxbrew and homebrew
brew install ffmpeg
```

## Download some realistic free audiobook content

Goto https://librivox.org/ and download some audio books  

```sh
mkdir -p ./sources/audiobooks/  
curl -vvv -L -o ./sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3.zip http://www.archive.org/download/christmas_short_works_2008_0812/christmas_short_works_2008_0812_64kb_mp3.zip
unzip ./sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3.zip -d ./sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3
```

## Set .env

```sh
. ./.env.template

# or
MP3FILE=./sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/english_thelittlegraylamb_sullivan_csm_64kb.mp3
WAVFILE_NOEXT=$(basename -s .mp3 $MP3FILE)_16bit-22khz
WAVFILE=${WAVFILE_NOEXT}.wav
DURATION_SECONDS=267
```

## Decode to WAV

```sh
mkdir -p ./output
ffmpeg -i "$MP3FILE" -ac 1 -ar 22000  "./output/$WAVFILE"
```

Hexview the file  

```sh
cat "./output/$WAVFILE" | xxd | more
```

### Stream info

```sh
ffprobe -v error -show_format -show_streams -print_format json "$MP3FILE" | jq . 

ffprobe -v error -show_format -show_streams -print_format json "./output/$WAVFILE" | jq . 
```

## Slice up

```sh
mkdir -p ./output/chunked

for index in $(seq -s " " -f %04g 0 10 $DURATION_SECONDS); 
do
    _starttime=$(date -d@$index -u +%H:%M:%S)
    #

    ffmpeg -i "./output/$WAVFILE" -ss $_starttime -t 00:00:10 -vcodec copy -acodec copy ./output/chunked/${WAVFILE_NOEXT}.$index.wav
done

# list chunks
ll ./output/chunked

# inspect a segment 
ffprobe -v error -show_format -show_streams -print_format json ./output/chunked/${WAVFILE_NOEXT}.0010.wav | jq .
```

## Concat chunks

Concats the streams back together to test output 

```sh
while IFS=, read -r file1
do
    echo "file './chunked/$file1'"
done < <(ls ./output/chunked) > ./output/chunked_streams.txt

ffmpeg -f concat -safe 0 -i ./output/chunked_streams.txt -c copy ./output/${WAVFILE_NOEXT}.concat.wav
```

## Create a HLS

```sh
rm -rf ./output/singlehls
mkdir -p ./output/singlehls
ffmpeg -y -i "./output/${WAVFILE}" -c:a aac -b:a 128k -muxdelay 0 -f segment -sc_threshold 0 -segment_time 10 -segment_list "./output/singlehls/playlist.m3u8" -segment_format mpegts "./output/singlehls/file%d.ts"

# inspect a segment 
ffprobe -v error -show_format -show_streams -print_format json ./output/singlehls/file0.ts | jq .
ffprobe -v error -show_format -show_streams -print_format json ./output/singlehls/file1.ts | jq .
```

## Create a partial HLS

NOTE:

* It seems to get the last segment to play it needs to have an endlist


This is broken.  Discontinuities... 


```sh
rm -rf ./output/partialhls
mkdir -p ./output/partialhls
# create first segment
ffmpeg -y -i "./output/chunked/${WAVFILE_NOEXT}.0000.wav" -c:a aac -b:a 128k -muxdelay 0 -f segment -sc_threshold 0 -segment_time 100 -segment_list "./output/partialhls/playlist.m3u8" -segment_format mpegts "./output/partialhls/file%d.ts"

# add next segment
ffmpeg -y -i "./output/chunked/${WAVFILE_NOEXT}.0010.wav" -hls_playlist_type event -hls_segment_filename "./output/partialhls/file%d.ts" -hls_time 100 -hls_flags omit_endlist+append_list "./output/partialhls/playlist.m3u8"

# add endfile
ffmpeg -y -i "./output/chunked/${WAVFILE_NOEXT}.0020.wav" -hls_playlist_type event -hls_segment_filename "./output/partialhls/file%d.ts" -hls_time 100 -hls_flags append_list "./output/partialhls/playlist.m3u8"

ffprobe -v error -show_format -show_streams -print_format json ./output/partialhls/file0.ts | jq .
ffprobe -v error -show_format -show_streams -print_format json ./output/partialhls/file1.ts | jq .
ffprobe -v error -show_format -show_streams -print_format json ./output/partialhls/file2.ts | jq .
```





## Resources

* convert-seconds-to-hours-minutes-seconds [here](https://stackoverflow.com/questions/12199631/convert-seconds-to-hours-minutes-seconds)
* how-to-create-a-sequence-with-leading-zeroes-using-brace-expansion [here](https://unix.stackexchange.com/questions/60257/how-to-create-a-sequence-with-leading-zeroes-using-brace-expansion)

https://stackoverflow.com/questions/63592822/ffmpeg-append-segments-to-m3u8-file-without-ext-x-discontinuity-tag



https://gist.github.com/samson-sham/7cb3a404a7aaaff62ec0ebbe08fb84e1

https://ffmpeg.org/ffmpeg-formats.html#Options-9

