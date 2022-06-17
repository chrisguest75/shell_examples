# README

Demonstrate how to work with binary files.

TODO:

* Take an mp3 decode to wav and look at binary structure
* Cut into 5 second chucks
* Build an audio only HLS stream
* Add a chunk to the end of a HLS.
* Host HLS

TODO:

* slice up whole file
* splice it all back together again
* build a HLS chunk by chunk
* try with raw
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

## Decode to WAV

```sh
mkdir -p ./output
ffmpeg -i ./sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/english_coventrycarol_unknown_rg_64kb.mp3 ./output/english_coventrycarol_unknown_rg_64kb.wav

ffmpeg -i ./sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/english_coventrycarol_unknown_rg_64kb.mp3 -ac 1 -ar 22000 ./output/english_coventrycarol_unknown_rg_64kb_16bit-22khz.wav
```

```sh
cat ./output/english_coventrycarol_unknown_rg_64kb_16bit-22khz.wav | xxd | more
```

### Stream info

```sh
ffprobe -v error -show_format -show_streams -print_format json ./sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/english_coventrycarol_unknown_rg_64kb.mp3 | jq . 

ffprobe -v error -show_format -show_streams -print_format json ./output/english_coventrycarol_unknown_rg_64kb_16bit-22khz.wav | jq . 
```



## Slice up

```sh
mkdir -p ./output/chunked

for index in $(seq -s " " -f %04g 0 10 160); 
do
    _starttime=$(date -d@$index -u +%H:%M:%S)
    #

    ffmpeg -i ./output/english_coventrycarol_unknown_rg_64kb_16bit-22khz.wav -ss $_starttime -t 00:00:10 -vcodec copy -acodec copy ./output/chunked/english_coventrycarol_unknown_rg_64kb_16bit-22khz.$index.wav
done

# inspect a segment 
ffprobe -v error -show_format -show_streams -print_format json ./output/chunked/english_coventrycarol_unknown_rg_64kb_16bit-22khz.0010.wav | jq .
```

## Create a HLS

```sh
rm -rf ./output/singlehls
mkdir -p ./output/singlehls
ffmpeg -y -i "./output/english_coventrycarol_unknown_rg_64kb_16bit-22khz.wav" -c:a aac -b:a 128k -muxdelay 0 -f segment -sc_threshold 0 -segment_time 10 -segment_list "./output/singlehls/playlist.m3u8" -segment_format mpegts "./output/singlehls/file%d.ts"


# inspect a segment 
ffprobe -v error -show_format -show_streams -print_format json ./output/singlehls/file0.ts | jq .
ffprobe -v error -show_format -show_streams -print_format json ./output/singlehls/file1.ts | jq .

```

## Create a partial HLS

```sh
rm -rf ./output/partialhls
mkdir -p ./output/partialhls
# create first segment
ffmpeg -y -i "./output/chunked/english_coventrycarol_unknown_rg_64kb_16bit-22khz.0000.wav" -c:a aac -b:a 128k -muxdelay 0 -f segment -sc_threshold 0 -segment_time 100 -segment_list "./output/partialhls/playlist.m3u8" -segment_format mpegts "./output/partialhls/file%d.ts"

# NOTE: This is broken.  Discontinuities... I think it must have endlist
# add next segment
ffmpeg -y -i "./output/chunked/english_coventrycarol_unknown_rg_64kb_16bit-22khz.0010.wav" -hls_time 10  -hls_playlist_type event -hls_segment_filename "./output/partialhls/file%d.ts" -hls_time 100 -hls_flags omit_endlist+append_list "./output/partialhls/playlist.m3u8"


ffprobe -v error -show_format -show_streams -print_format json ./output/partialhls/file0.ts | jq .
ffprobe -v error -show_format -show_streams -print_format json ./output/partialhls/file1.ts | jq .


```





## Resources

https://stackoverflow.com/questions/12199631/convert-seconds-to-hours-minutes-seconds

https://unix.stackexchange.com/questions/60257/how-to-create-a-sequence-with-leading-zeroes-using-brace-expansion

https://stackoverflow.com/questions/63592822/ffmpeg-append-segments-to-m3u8-file-without-ext-x-discontinuity-tag



https://gist.github.com/samson-sham/7cb3a404a7aaaff62ec0ebbe08fb84e1

https://ffmpeg.org/ffmpeg-formats.html#Options-9

<!-- # create the playlist
ffmpeg -y -i <chunk.flac> -hls_playlist_type event -hls_base_url http://localhost:9000/ -hls_segment_filename <segment> -hls_time 2 -hls_flags omit_endlist playlist.m3u8 

# append to playlist
ffmpeg -y -i <chunk.flac> -hls_playlist_type event -hls_base_url http://localhost:9000/ -hls_segment_filename <segment> -hls_time 2 -hls_flags omit_endlist+append_list playlist.m3u8

# finish the playlist
ffmpeg -y -i <chunk.flac> -hls_playlist_type event -hls_base_url http://localhost:9000/ -hls_segment_filename <segment> -hls_time 2 -hls_flags append_list playlist.m3u8 -->