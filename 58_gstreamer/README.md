# README  

Demonstrate some basic `gstreamer` examples  

## Prereqs (local)

```sh
brew install gstreamer
```

## Docker Playground

```sh
# Build
docker build -t gstreamer . 

# Run
ASSETS=$(pwd)/../../ffmpeg_examples/sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3
# Start container
docker run -v $ASSETS:/assets --rm -it gstreamer 
```

## Start

```sh
ls /assets/

```

## Tools with gstreamer

```sh
gst-discoverer-1.0 --help 

gst-launch-1.0 --help 

gst-inspect-1.0 --help 

gst-typefind-1.0 --help-all 

gst-stats-1.0 --help-all    
```

## Audio

```sh
# NOTE: mp3parse is not working
SOURCE=/assets/english_christmas1873_macdonald_mtd_64kb.mp3
OUTPUT=./english_christmas1873_macdonald_mtd_64kb.mp3
gst-launch-1.0 filesrc location=$SOURCE ! mp3parse ! audioconvert ! lame ! filesink location=$OUTPUT
```

## Resources

* GStreamer Website [here](https://gstreamer.freedesktop.org/_
* gst-launch-1.0 docs [here](https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c)
* GStreamer Pipeline Samples [here](https://gist.github.com/hum4n0id/cda96fb07a34300cdb2c0e314c14df0a)
* GStreamer command-line cheat sheet [here](https://github.com/matthew1000/gstreamer-cheat-sheet)
* Installing on Debian reference [here](https://gstreamer.freedesktop.org/documentation/installing/on-linux.html?gi-language=c)  
