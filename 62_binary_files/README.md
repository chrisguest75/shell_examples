# README

Working with binary files in shell.

[HEXEDITORS.md](./HEXEDITORS.md) for some examples of GUI based hex editors.  

TODO:

* hexdump, hexfiend, fq

## VSCode

```sh
#hex editor in vscode
code --install-extension ms-vscode.hexeditor                       
```

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

## Create binary files

```sh
file ./file.bin
sudo dd if=/dev/zero of=file.bin bs=1M count=1
xxd ./file.bin
```

## Showing utf8 text as binary

```sh
echo $emoji > ./emoji.txt 
file ./emoji.txt
xxd ./emoji.txt
```

## fq

fq is jq for media files  

```sh
# install fq
brew install wader/tap/fq

# decode
fq d ./test.mp3
```

## diffing

`cmp` for byte by byte diffs  

```sh
cmp -l ./file1.wav ./file2.wav
```

`diff` using xxd line diffs  

```sh
diff -u <(xxd ./file1.wav) <(xxd ./file2.wav) | head -n 25
```

`dhex` for TUI diffing.  

```sh
# install 
brew info dhex     

# requires setting up keybindings (quit is f10)
dhex ./file1.wav ./file2.wav
```

## Poke

```sh
# build the image
docker build --no-cache --progress=plain -f Dockerfile.poke -t poke . 
# run a command 
docker run --rm -it -v$(realpath ./):/share --entrypoint /bin/bash poke 

poke

.help
.exit
```

## Resources

* The *Binary Tools Summit 2022* is an informal, technical, online event
oriented to authors, users and enthusiasts of FLOSS programs that deal
with binary data. [here](https://binary-tools.net/summit)  
* fq repo [here](https://github.com/wader/fq)  
* dhex — hex editor with a diff mode [here](https://manpages.ubuntu.com/manpages/bionic/man1/dhex.1.html)  
* Welcome to Pokology [here](https://pokology.org/)
* GNU poke Manual [here](http://jemarch.net/poke-2.4-manual/poke.html)
