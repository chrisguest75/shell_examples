# README  

Demonstrate some basic `gstreamer` examples  

TODO:

* AAC to WAV (does it increase duration?)
* Piping - https://stackoverflow.com/questions/23353007/piping-stdout-to-gstreamer

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
brew install gst-plugins-bad
brew install gst-plugins-ugly
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
# or
ASSETS=$(pwd)/out
mkdir -p ${ASSETS}

# Start container
docker run -v $ASSETS:/assets --rm -it gstreamer 

# switch into zsh
ls /assets/

# NOTE: if we want to use 
cd /assets
```

### RSS Feed download

```sh
mkdir -p ./out
# get rss feed
curl -s -o ./out/lnlrss.xml https://latenightlinux.com/feed/mp3
# get first url
FEED_URL=$(xmllint --xpath 'string(//rss/channel/item[1]/enclosure/@url)' --format --pretty 2 ./out/lnlrss.xml)
# get the file
PODCASTFILE=$(basename $FEED_URL)
curl -s -L -o ./out/${PODCASTFILE} $FEED_URL
```

## Analyse

```sh
# gives an ffprobe style output
gst-discoverer-1.0 -v --gst-debug-level=3 ./out/${PODCASTFILE}
```

## Audio

```sh
# reencoding
SOURCE=./out/${PODCASTFILE}
OUTPUT=./out/new.mp3
gst-launch-1.0 -vvv -m -e filesrc location=$SOURCE ! mpegaudioparse ! mpg123audiodec ! audioconvert ! lamemp3enc ! filesink location=$OUTPUT

# spliting audio into 5 second chunks.
mkdir -p ./out/testchunks
SOURCE=./out/${PODCASTFILE}
gst-launch-1.0 filesrc location="$SOURCE" ! decodebin ! audioconvert ! splitmuxsink location=./out/testchunks/file_%05d.wav muxer=wavenc max-size-time=5000000000

ls -la ./out/testchunks

# they end up as  Duration: 0:00:04.975238096
gst-discoverer-1.0 -v --gst-debug-level=3 ./out/testchunks/file_00004.wav

# decode
fq d ./out/testchunks/file_00005.wav 
# size should be 441000?  
fq '.chunks[1].size' ./out/testchunks/file_00005.wav 

# generated audio ticks
gst-launch-1.0 audiotestsrc wave=ticks apply-tick-ramp=true tick-interval=100000000 freq=10000 volume=0.4 marker-tick-period=10 sine-periods-per-tick=20 ! audioconvert ! lamemp3enc ! filesink location=./out/testaudio.mp3
```

## Video

```sh
mkdir -p ./out
gst-launch-1.0 -vvv -m -e videotestsrc num-buffers=1000 pattern=snow ! x264enc qp-min=18 ! mp4mux ! filesink location=./out/test.mp4 

vlc ./out/test.mp4

fq d ./out/test.mp4
```

## Messages (levels)

Processes streams and prints out messages.  

```sh
# extract waveform data.  
# -v verbose, -t tags, -c chapters and editions, -m messages, -e End of stream on shutdown
gst-launch-1.0 -vvv -t -c -m -e --gst-plugin-spew --gst-debug-level=3 uridecodebin uri=file://$(pwd)/out/LNL209.mp3 ! audioconvert ! level name=levels interval=100000000 post-messages=true ! fakesink qos=false name=outsink > ./out/levels.log
```

## Muxing

```sh
gst-launch-1.0 -v -e videotestsrc ! x264enc ! mp4mux name=mux ! filesink location="./out/testmux.mp4" audiotestsrc ! lamemp3enc ! mux.
```

## Resources

* GStreamer Website [here](https://gstreamer.freedesktop.org/)
* gst-launch-1.0 docs [here](https://gstreamer.freedesktop.org/documentation/tools/gst-launch.html?gi-language=c)
* Gstreamer Repo [here](https://gitlab.freedesktop.org/gstreamer/gstreamer)  
* GStreamer Pipeline Samples [here](https://gist.github.com/hum4n0id/cda96fb07a34300cdb2c0e314c14df0a)
* GStreamer command-line cheat sheet [here](https://github.com/matthew1000/gstreamer-cheat-sheet)
* Installing on Debian reference [here](https://gstreamer.freedesktop.org/documentation/installing/on-linux.html?gi-language=c)  
* hum4n0id/gstreamer_pipeline_samples.md repo [here](https://gist.github.com/hum4n0id/cda96fb07a34300cdb2c0e314c14df0a#record-to-file)  
