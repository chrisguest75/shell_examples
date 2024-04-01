# RECORDING

Demonstrate how to record using `ffmpeg`  

## Record from devices (linux)

```sh
sudo apt install pulseaudio-utils

pactl list short sources | grep input
pactl set-source-volume alsa_input.pci-0000_00_1b.0.analog-stereo 60%

mkdir -p ./out
ffmpeg -f pulse -i alsa_input.pci-0000_00_1b.0.analog-stereo -ac 1 -ar 22050 -segment_time 00:00:10 -f segment ./out/recording%03d.wav
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

## Resources

* https://trac.ffmpeg.org/wiki/Capture/PulseAudio
* https://unix.stackexchange.com/questions/1670/how-can-i-use-ffmpeg-to-split-mpeg-video-into-10-minute-chunks