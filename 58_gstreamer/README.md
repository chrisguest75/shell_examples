# README  

Demonstrate some basic `gstreamer` examples  

TODO:

* AAC to WAV (does it increase duration?)

## Prereqs (local)

`gstreamer` is split into different installs of the main build and different plugin packs.  

```sh
# install base executables
# installs coreelements, coretracers & staticelements
brew install gstreamer
```

After installing `brew` will echo out.  

```txt
Consider also installing gst-plugins-base and gst-plugins-good.  

The gst-plugins-* packages contain gstreamer-video-1.0, gstreamer-audio-1.0, and other components needed by most gstreamer applications.  

gst-plugins-bad, gst-plugins-base, gst-plugins-good, gst-plugins-rs, gst-plugins-ugly  
```

```sh
# install the other plugins
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
# main pipeline tool
gst-launch-1.0 --help 
```

## Docker Playground

```sh
# Build
docker build -t gstreamer . 

# Run
ASSETS=$(pwd)/../../ffmpeg_examples/sources
# Start container
docker run -v $ASSETS:/assets --rm -it gstreamer 

# switch into zsh
zsh
ls /assets/
```

## Analyse

```sh
# gives an ffprobe style output
gst-discoverer-1.0 -v --gst-debug-level=3 /assets/sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/dutch_kerstfeest_bilderdijk_ezwa_64kb.mp3
```

## Audio

```sh
# NOTE: mp3parse is not working
SOURCE=/assets/sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/english_achristmastree_dickens_rg_64kb.mp3
OUTPUT=./english_achristmastree_dickens_rg_64kb.mp3
gst-launch-1.0 filesrc location=$SOURCE ! mp3parse ! audioconvert ! lame ! filesink location=$OUTPUT

# spliting audio into 1 second chunks.
mkdir -p ./output/testtonechunks
SOURCE=/assets/output/testtone.m4a
gst-launch-1.0 filesrc location="$SOURCE" ! decodebin ! audioconvert ! splitmuxsink location=./output/testtonechunks/file_%03d.wav muxer=wavenc max-size-time=1000000000

# they end up as  Duration: 0:00:00.975238096
gst-discoverer-1.0 -v --gst-debug-level=3 ./output/testtonechunks/file_004.wav
```

## Resources

* GStreamer Website [here](https://gstreamer.freedesktop.org/_
* gst-launch-1.0 docs [here](https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c)
* Gstreamer Repo [here](https://gitlab.freedesktop.org/gstreamer/gstreamer)  
* GStreamer Pipeline Samples [here](https://gist.github.com/hum4n0id/cda96fb07a34300cdb2c0e314c14df0a)
* GStreamer command-line cheat sheet [here](https://github.com/matthew1000/gstreamer-cheat-sheet)
* Installing on Debian reference [here](https://gstreamer.freedesktop.org/documentation/installing/on-linux.html?gi-language=c)  
