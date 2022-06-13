# README  

Demonstrate some basic `gstreamer` examples  

## Prereqs

```sh
brew install gstreamer
```

## Start

```sh
gst-launch-1.0 --help 

gst-inspect-1.0 --help 
```

## Audio

```sh
SOURCE=./ffmpeg_examples/sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/english_christmas1873_macdonald_mtd_64kb.mp3
OUTPUT=./english_christmas1873_macdonald_mtd_64kb.mp3
gst-launch-1.0 filesrc location=music.wav ! wavparse ! audioconvert ! lame !
filesink location=music.mp3
```

## Resources

* https://gstreamer.freedesktop.org/
* https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c