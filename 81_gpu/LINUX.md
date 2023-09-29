# Linux GPU

## FFMPEG

```sh
ffmpeg -hwaccels
ffmpeg -codecs 

# if you run this you'll see the gpu being used.
mkdir -p ./output
ffmpeg -f lavfi -i testsrc=size=1920x1080 -t 00:02:00 -pix_fmt yuv420p ./output/test_gpu.mp4 -y
```

## CUDA

### Install

NVidia CUDA downloads [here](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_network)  

```sh
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda
sudo reboot
```

### Status

```sh
nvidia-smi
```

## NVTOP

```sh
sudo apt install nvtop

nvtop
```

## Compile

```sh
/usr/local/cuda/bin/nvcc --version

cat <<- EOF > hello-world.cu
#include <stdio.h>
__global__
void hello(int n, int y)
{
    printf("Helloworld from Cuda\n");
}

int main(void)
{
    printf("Helloworld from CPU\n");

    hello<<<1, 1>>>(1, 1);
    cudaDeviceSynchronize();

    printf("Goodbye from CPU\n");
}
EOF

/usr/local/cuda/bin/nvcc hello-world.cu -o hello-world
./hello-world

cat <<- EOF > test.cu
#include <stdio.h>

__global__
void saxpy(int n, float a, float *x, float *y)
{
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if (i < n) y[i] = a*x[i] + y[i];
}

int main(void)
{
  int N = 1<<20;
  float *x, *y, *d_x, *d_y;
  x = (float*)malloc(N*sizeof(float));
  y = (float*)malloc(N*sizeof(float));

  cudaMalloc(&d_x, N*sizeof(float)); 
  cudaMalloc(&d_y, N*sizeof(float));

  for (int i = 0; i < N; i++) {
    x[i] = 1.0f;
    y[i] = 2.0f;
  }

  cudaMemcpy(d_x, x, N*sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_y, y, N*sizeof(float), cudaMemcpyHostToDevice);

  // Perform SAXPY on 1M elements
  saxpy<<<(N+255)/256, 256>>>(N, 2.0f, d_x, d_y);

  cudaMemcpy(y, d_y, N*sizeof(float), cudaMemcpyDeviceToHost);

  float maxError = 0.0f;
  for (int i = 0; i < N; i++)
    maxError = max(maxError, abs(y[i]-4.0f));
  printf("Max error: %f\n", maxError);

  cudaFree(d_x);
  cudaFree(d_y);
  free(x);
  free(y);
}
EOF

/usr/local/cuda/bin/nvcc test.cu -o test
./test
```

## Resources

* ffmpeg HWAccelIntro [here](https://trac.ffmpeg.org/wiki/HWAccelIntro)  
* How to Install CUDA on Ubuntu 20.04 LTS [here](https://linuxhint.com/install-cuda-ubuntu-2004/)
* How to install CUDA on Ubuntu 20.04 Focal Fossa Linux [here](https://linuxconfig.org/how-to-install-cuda-on-ubuntu-20-04-focal-fossa-linux)
* nvtop – Awesome Linux task monitor for NVIDIA, AMD & Intel GPUs [here](https://www.cyberciti.biz/hardware/nvtop-command-in-linux-to-monitor-nvidia-amd-intel-gpus/)
* Syllo/nvtop repo [here](https://github.com/Syllo/nvtop)
* How to Use GPU Acceleration for Video Processing with FFmpeg [here](https://saturncloud.io/blog/how-to-use-gpu-acceleration-for-video-processing-with-ffmpeg/)
* All Things GPU: Part 2 [here](https://medium.com/hashicorp-engineering/all-things-gpu-part-2-4ac1c30a20ed)