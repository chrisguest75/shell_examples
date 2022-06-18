# README

Demonstrates building a hls from individual ammendments of wav files.  

TODO:

* Take an mp3 decode to wav and look at binary structure
* Host HLS
* capture from the phone
* build a website that I can stream audio from 
* encode chunks as mp3 and then decode back to wav and concat chunks

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
ffmpeg -hide_banner -i "$MP3FILE" -ac 1 -ar 22050  "./output/$WAVFILE"
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
    ffmpeg -hide_banner -i "./output/$WAVFILE" -ss $_starttime -t 00:00:10 -vcodec copy -acodec copy ./output/chunked/${WAVFILE_NOEXT}.$index.wav
done

# list chunks
ll ./output/chunked

# inspect a segment 
ffprobe -v error -show_format -show_streams -print_format json ./output/chunked/${WAVFILE_NOEXT}.0010.wav | jq .
```

## Concat chunks

Concats the streams back together to test output 

```sh
# NOTE: Be careful of order of chunked
while IFS=, read -r file1
do
    echo "file './chunked/$file1'"
done < <(ls ./output/chunked) > ./output/chunked_streams.txt

ffmpeg -hide_banner -f concat -safe 0 -i ./output/chunked_streams.txt -c copy ./output/${WAVFILE_NOEXT}.concat.wav
```

## Create a HLS

```sh
rm -rf ./output/singlehls
mkdir -p ./output/singlehls
ffmpeg -hide_banner -y -i "./output/${WAVFILE}" -c:a aac -b:a 128k -muxdelay 0 -f segment -sc_threshold 0 -segment_time 10 -segment_list "./output/singlehls/playlist.m3u8" -segment_format mpegts "./output/singlehls/file%d.ts"

# inspect a segment 
ffprobe -v error -show_format -show_streams -print_format json ./output/singlehls/file5.ts | jq .

# print out start times and durations
while IFS=, read -r _filename
do
    ffprobe -v error -show_format -show_streams -print_format json ./output/singlehls/$_filename | jq --arg filename "${_filename}" -c '{ file: $filename, start_time:.format.start_time, duration:.format.duration, pts: .streams[0].start_pts, time_base: .streams[0].time_base, codec_time_base: .streams[0].codec_time_base}'
done < <(ls ./output/singlehls)
```

## Create a partial HLS

NOTE: It seems to get the last segment to play it needs to have an endlist

```sh
rm -rf ./output/partialhls
mkdir -p ./output/partialhls
# create first segment
ffmpeg -y -hide_banner -i "./output/chunked/${WAVFILE_NOEXT}.0000.wav" -c:a aac -b:a 128k -muxdelay 0 -f segment -segment_time 100 -segment_list "./output/partialhls/playlist.m3u8" -segment_format mpegts "./output/partialhls/file%d.ts"

## NOTE modify pts
ffprobe -v error -show_format -show_streams -print_format json "./output/chunked/${WAVFILE_NOEXT}.0010.wav" | jq '.streams[].codec_time_base'

for CHUNK in $(seq -s " " -f %04g 10 10 $DURATION_SECONDS); 
do
    # sum current duration for new audio pts
    CURRENT_DURATION=$(cat ./output/partialhls/playlist.m3u8 | grep EXTINF | awk -F':' '{gsub(/,/, "", $2);print $2}' | awk '{OFMT = "%9.6f";s+=$1} END {print s}')
    echo "CURRENT_DURATION=$CURRENT_DURATION"
    # add segment
    ffmpeg -y -hide_banner -i "./output/chunked/${WAVFILE_NOEXT}.${CHUNK}.wav" -c:a aac -b:a 128k -muxdelay 0 -filter_complex "[0:a]asetpts=PTS+$(( 22050.0 * $CURRENT_DURATION ))" -hls_playlist_type event -hls_segment_filename "./output/partialhls/file%d.ts" -hls_time 100 -hls_flags append_list "./output/partialhls/playlist.m3u8"
    # remove discontinuity
    cat ./output/partialhls/playlist.m3u8 | grep -v "#EXT-X-DISCONTINUITY" > ./output/partialhls/fixed_playlist.m3u8
done > ./output.txt

# inspect a segment 
ffprobe -v error -show_format -show_streams -print_format json ./output/partialhls/file2.ts | jq .

# frame time codes
ffprobe -v error -print_format json -show_frames ./output/partialhls/file0.ts | jq '.frames[].pkt_pts_time'

# print out start times and durations
while IFS=, read -r _filename
do
    ffprobe -v error -show_format -show_streams -print_format json ./output/partialhls/$_filename | jq --arg filename "${_filename}" -c '{ file: $filename, start_time:.format.start_time, duration:.format.duration, pts: .streams[0].start_pts, time_base: .streams[0].time_base, codec_time_base: .streams[0].codec_time_base}'
done < <(ls ./output/partialhls)
```

## Resources

* convert-seconds-to-hours-minutes-seconds [here](https://stackoverflow.com/questions/12199631/convert-seconds-to-hours-minutes-seconds)  
* how-to-create-a-sequence-with-leading-zeroes-using-brace-expansion [here](https://unix.stackexchange.com/questions/60257/how-to-create-a-sequence-with-leading-zeroes-using-brace-expansion)  
* ffmpeg-append-segments-to-m3u8-file-without-ext-x-discontinuity-tag [here](https://stackoverflow.com/questions/63592822/ffmpeg-append-segments-to-m3u8-file-without-ext-x-discontinuity-tag)  
* practical-ffmpeg-commands-to-manipulate-a-video [here](https://transang.me/practical-ffmpeg-commands-to-manipulate-a-video/)  


https://gist.github.com/samson-sham/7cb3a404a7aaaff62ec0ebbe08fb84e1

https://ffmpeg.org/ffmpeg-formats.html#Options-9



https://stackoverflow.com/questions/450799/shell-command-to-sum-integers-one-per-line
https://stackoverflow.com/questions/16040567/use-awk-to-extract-substring