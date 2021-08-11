# README

TODO:
* Get the duration of the asset
* Get the bitrate etc.  
* Codec.  
* Audio bitrate.  
* Print out metrics

## Probe
```sh
ffprobe -v error -show_format -show_streams ~/Desktop/bluejam/bj1-1a.ra            
ffprobe -v error -show_format -show_streams ~/Desktop/bluejam/bj1-1a.mp3

# json
ffprobe -v error -show_format -print_format json -show_streams ~/Desktop/bluejam/bj1-1a.mp3                  
```


ffmpeg -i ~/Desktop/bluejam/bj1-1a.ra bj1-1a.ra.mp3

for i in ~/Desktop/bluejam/*.r*; do ffmpeg -i "$i" "${i%.*}.mp3"; done
for i in ~/Desktop/bluejam/*.r*; do echo "${i%.*}.mp3"; done


https://askubuntu.com/questions/248811/how-can-i-fix-incorrect-mp3-duration


https://superuser.com/questions/733061/reduce-background-noise-and-optimize-the-speech-from-an-audio-clip-using-ffmpeg

