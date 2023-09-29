# GPU

NOTES:

* OpenCL on mac is deprecated [here](https://support.apple.com/en-gb/101525)
* Vulkan MoltenVK [here](https://github.com/KhronosGroup/MoltenVK)

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
> videotoolbox decoder: vt cvpx chroma: 420v
```

## Resources

* How to Use GPU Acceleration for Video Processing with FFmpeg [here](https://saturncloud.io/blog/how-to-use-gpu-acceleration-for-video-processing-with-ffmpeg/)
* NVIDIA CUDA Toolkit - Developer Tools for macOS - CUDA Toolkit 11.7 [here(https://developer.nvidia.com/nvidia-cuda-toolkit-11_7_0-developer-tools-mac-hosts)
* How to Install CUDA on Ubuntu 20.04 LTS [here](https://linuxhint.com/install-cuda-ubuntu-2004/)
* Officially official: NVIDIA drops CUDA support for macOS [here](https://www.provideocoalition.com/officially-official-nvidia-drops-cuda-support-for-macos/)
* ffmpeg HWAccelIntro [here](https://trac.ffmpeg.org/wiki/HWAccelIntro)  
* Video Toolbox Work directly with hardware-accelerated video encoding and decoding capabilities. [here](https://developer.apple.com/documentation/videotoolbox)
* Following a Vulkan Tutorial on Your MacBook [here](https://medium.com/@onlyashley04/following-a-vulkan-tutorial-on-your-macbook-27122d47caae)
* Accelerated PyTorch training on Mac [here](https://developer.apple.com/metal/pytorch/)
* Get started with tensorflow-metal [here](https://developer.apple.com/metal/tensorflow-plugin/)