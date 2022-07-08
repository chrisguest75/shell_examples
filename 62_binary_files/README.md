# README

Working with binary files in shell.

## Files

```sh
# identify a file type
file ./output/chunked/dracula_27_stoker_64kb_16bit-22khz.0030.wav

# file attributes 
stat ./output/chunked/dracula_27_stoker_64kb_16bit-22khz.0030.wav

# size of file in bytes
gstat --printf="%s"  ./output/chunked/dracula_27_stoker_64kb_16bit-22khz.0030.wav
```

## XXD (hex)

```sh
# print out header of wav file
cat ./output/chunked/dracula_27_stoker_64kb_16bit-22khz.0030.wav | xxd | head
```

## Chopping and truncation

```sh
# use truncate to the chop a file
truncate --size=30MB ./output/pcmformats/pcm_s24le_stereo_48khz.wav 
```
