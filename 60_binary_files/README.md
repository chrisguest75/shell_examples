# README

Demonstrate how to work with binary files.

TODO:

* Take an mp3 decode to wav and look at binary structure
* Cut into 5 second chucks
* Build an audio only HLS stream
* Add a chunk to the end of a HLS.
* Host HLS

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
cat ./output/english_coventrycarol_unknown_rg_64kb_16bit-22khz.wav | xxd 
```

### Stream info

```sh
ffprobe -v error -show_format -show_streams -print_format json ./sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/english_coventrycarol_unknown_rg_64kb.mp3 | jq . 

ffprobe -v error -show_format -show_streams -print_format json ./output/english_coventrycarol_unknown_rg_64kb_16bit-22khz.wav | jq . 
```



## Slice up

```sh
# take a slice from 2 mins in for 1 mins
ffmpeg -i TearsOfSteel_1920x1080p24_h264_6700_ac3.mp4 -ss 00:02:00 -t 00:03:00 -vcodec copy -acodec copy TearsOfSteel_1920x1080p24_h264_6700_ac3.slice.mp4
```

## Resources