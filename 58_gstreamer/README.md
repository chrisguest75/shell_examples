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
docker run -v $ASSETS:/assets --rm -it gstreamer 
```

## Start

```sh
ls /assets/

gst-discoverer-1.0 --help 
```


```sh
gst-launch-1.0 --help 

gst-inspect-1.0 --help 

gst-typefind-1.0 --help-all 
gst-stats-1.0 --help-all    
```

## Audio

```sh
SOURCE=/assets/english_christmas1873_macdonald_mtd_64kb.mp3
OUTPUT=./english_christmas1873_macdonald_mtd_64kb.mp3
gst-launch-1.0 filesrc location=$SOURCE ! mp3parse ! audioconvert ! lame ! filesink location=$OUTPUT
```

## Resources

* https://gstreamer.freedesktop.org/
* https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c
https://gist.github.com/hum4n0id/cda96fb07a34300cdb2c0e314c14df0a
https://github.com/matthew1000/gstreamer-cheat-sheet
Debian reference [here](https://gstreamer.freedesktop.org/documentation/installing/on-linux.html?gi-language=c)  
