# GPU

OpenCL on mac seems deprecated - https://support.apple.com/en-gb/101525
Metal
CUDA
Vulkan - https://github.com/KhronosGroup/MoltenVK
https://medium.com/@onlyashley04/following-a-vulkan-tutorial-on-your-macbook-27122d47caae

https://developer.apple.com/metal/pytorch/
https://developer.apple.com/metal/tensorflow-plugin/

## FFMPEG

```sh
ffmpeg -hwaccels  
ffmpeg -codecs | grep videotoolbox

# if you run this you'll see the gpu being used.
mkdir -p ./output
ffmpeg -f lavfi -i testsrc=size=1920x1080 -t 00:02:00 -c:v h264_videotoolbox -pix_fmt yuv420p ./output/test_gpu.mp4 -y
```

## MacOS

cmd+4 in activity monitor

```sh
powermetrics -h
sudo powermetrics --samplers gpu_power -i500 -n1

vlc ./output/test_gpu.mp4    
videotoolbox decoder: vt cvpx chroma: 420v
```

## Resources



https://saturncloud.io/blog/how-to-use-gpu-acceleration-for-video-processing-with-ffmpeg/

https://developer.nvidia.com/nvidia-cuda-toolkit-11_7_0-developer-tools-mac-hosts

https://linuxhint.com/install-cuda-ubuntu-2004/

https://www.provideocoalition.com/officially-official-nvidia-drops-cuda-support-for-macos/

https://trac.ffmpeg.org/wiki/HWAccelIntro


https://developer.apple.com/documentation/videotoolbox

