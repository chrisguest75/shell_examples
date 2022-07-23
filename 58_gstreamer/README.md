# README  

Demonstrate some basic `gstreamer` examples  

## Prereqs (local)

`gstreamer` is split into different installs of the main build and different plugin packs.  

```sh
# install base executables
# installs coreelements, coretracers & staticelements
brew install gstreamer
```

After installing `brew` will echo out.  

Consider also installing gst-plugins-base and gst-plugins-good.  

The gst-plugins-* packages contain gstreamer-video-1.0, gstreamer-audio-1.0, and other components needed by most gstreamer applications.  

gst-plugins-bad, gst-plugins-base, gst-plugins-good, gst-plugins-rs, gst-plugins-ugly  

```sh
brew install gst-plugins-base
brew install gst-plugins-good
```

## Tools with gstreamer

### gst-inspect-1.0

Inspect the installed plugins  

```sh
# list installed plugins
gst-inspect-1.0 --help 
# inspect a specific plugin
gst-inspect-1.0 --plugin coreelements
# list blacklisted plugins
gst-inspect-1.0 -b
```

### gst-typefind-1.0

Identify the mime type of a file.  

```sh
gst-typefind-1.0 --help-all 

gst-typefind-1.0 ./output/file.wav

gst-typefind-1.0 --gst-debug-level=9 ./file.m4a
```

### Other tools

```sh
gst-stats-1.0 --help-all    
gst-discoverer-1.0 --help 
```


```sh
gst-launch-1.0 --help 
```

## Docker Playground

```sh
# Build
docker build -t gstreamer . 

# Run
ASSETS=$(pwd)/../../ffmpeg_examples/sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3
# Start container
docker run -v $ASSETS:/assets --rm -it gstreamer 

ls /assets/
```

## Analyse

```sh
# 
gst-discoverer-1.0 -v --gst-debug-level=3 /assets/sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/dutch_kerstfeest_bilderdijk_ezwa_64kb.mp3



gst-discoverer-1.0 -v --gst-debug-level=3 /assets/output/7jul_partialhlsaac_matchdurations_hls/file0.ts

gst-discoverer-1.0 -v --gst-debug-level=3 /assets/sources/7jul-ios-5seconds-30min/0000001.mp4 

```

## Audio

```sh
# NOTE: mp3parse is not working
SOURCE=/assets/english_christmas1873_macdonald_mtd_64kb.mp3
OUTPUT=./english_christmas1873_macdonald_mtd_64kb.mp3
gst-launch-1.0 filesrc location=$SOURCE ! mp3parse ! audioconvert ! lame ! filesink location=$OUTPUT

# spliting audio into 1 second chunks.
mkdir -p ./output/testtonechunks
gst-launch-1.0 filesrc location="./output/testtone.wav" ! decodebin ! audioconvert ! splitmuxsink location=./output/testtonechunks/file_%03d.wav muxer=wavenc max-size-time=1000000000
```




## Resources

* GStreamer Website [here](https://gstreamer.freedesktop.org/_
* gst-launch-1.0 docs [here](https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c)
* Gstreamer Repo [here](https://gitlab.freedesktop.org/gstreamer/gstreamer)  
* GStreamer Pipeline Samples [here](https://gist.github.com/hum4n0id/cda96fb07a34300cdb2c0e314c14df0a)
* GStreamer command-line cheat sheet [here](https://github.com/matthew1000/gstreamer-cheat-sheet)
* Installing on Debian reference [here](https://gstreamer.freedesktop.org/documentation/installing/on-linux.html?gi-language=c)  
