# README

Demonstrate how to use ffmpeg to perform different types of encodings

TODO:

* Get the duration of the asset
* Get the bitrate etc.  
* Codec.  
* Audio bitrate.  
* Print out metrics
* https://trac.ffmpeg.org/wiki/Capture/ALSA `arecord -l`

## Sections

* How to do [RECORDING.md](./RECORDING.md)  

## Prereqs

```sh
brew install youtube-dl
brew install ffmpeg
```

## Download an asset

```sh
youtube-dl --write-info-json --output asset_download https://www.youtube.com/watch\?v\=wbU9P2DcKFs
```

## Probe

```sh
ffprobe -v error -show_format -show_streams -print_format json asset_download.mkv
```

## Codecs

```sh
ffmpeg -encoders    
ffmpeg -decoders    
ffmpeg -formats  
```

## Strip audio from video

```sh
# take audio only
ffmpeg -i asset_download.mkv -acodec libmp3lame -ab 320k asset_download_audio.mp3

# apply a filter
ffmpeg -i asset_download_audio.mp3 -af "highpass=f=200, lowpass=f=3000" asset_download_filter.mp3
```

## Truncate

```sh
# take first 30 mins
ffmpeg -i asset_download.mkv -acodec libmp3lame -ab 320k -t 00:30:00 asset_download_audio_30.mp3

# take a slice from 30 mins in
ffmpeg -i asset_download.mkv -ss 00:30:00 -t 00:10:00 -vcodec copy -acodec copy asset_download_slice.mkv
```

## Testcards

```sh
# testcard without audio
ffmpeg -f lavfi -i testsrc=size=1920x800 -t 20 -pix_fmt yuv420p -vf "drawtext=fontfile=/windows/fonts/arial.ttf:text='Testcard':fontcolor=white:fontsize=100" ./testcard_1080p.mp4

# testcard with audio tone
ffmpeg -f lavfi -i testsrc=size=960x720 -filter_complex aevalsrc="sin(440*2*PI*t)" -t 20 -r 30 -pix_fmt yuv420p -acodec libmp3lame -ab 320k  -vf "drawtext=fontfile=/windows/fonts/arial.ttf:text='Progressive 30FPS':fontcolor=white:fontsize=100" -force_key_frames 00:00:00.000 -b_strategy 0 -sc_threshold 0 testcard_960_720p_30fps.mp4
```

## To images

```sh
# write out frames
mkdir -p ./out
ffmpeg -i ./testcard_1080p.mp4 -r 1/1 ./out/testcard_1080p_%03d.png

# create from images
ffmpeg -r 1 -f image2 -s 320x200 -i ./out/testcard_1080p_%03d.png -vcodec libx264 -crf 15 -vpre normal ./320x200.mp4
```

## Transcode

```sh
# convert audio to another form 
ffmpeg -i ./bj1-1a.ra bj1-1a.ra.mp3

# loop through all assets
for i in *.r*; do ffmpeg -i "$i" "${i%.*}.mp3"; done
for i in *.r*; do echo "${i%.*}.mp3"; done
```

## Record from devices (macosx)

```sh
# list available devices
mkdir -p ./recordings
ffmpeg -f avfoundation -list_devices true -i "" 

# record video and audio
ffmpeg -f avfoundation -framerate 30 -i "0:0" ./recordings/output.mp4

# record segments
ffmpeg -f avfoundation -framerate 30 -video_size 640x480 -i "0:0" -flags +global_header -f segment -segment_time 60 -segment_format_options movflags=+faststart -reset_timestamps 1 ./recordings/test%d.mp4

# NOT WORKING (host a stream for VLC)
ffmpeg -f avfoundation -framerate 30 -video_size 640x480 -i "0:0" -vcodec libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv422p -f mpegts udp://0.0.0.0:12345
```

## host a stream (push a stream to server)

```sh
# ALSO NOT WORKING (host a stream for delivery)
ffmpeg -f avfoundation -framerate 30 -video_size 640x480 -i "0" -vcodec libx264 -preset ultrafast -tune zerolatency -f flv
rtmps://stream.trint.com/live/cc0f38b9-52f8-4cc1-981f-000000000000
```
