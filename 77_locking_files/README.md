# LOCKING FILES

Demonstrate locking and detection of locked files

TODO:

* look at the locks that are taken on writing out a stream
* lsof
* /proc

## Install

```sh
brew install flock

man flock
```

## Process (single file input)

https://github.com/chrisguest75/hls_examples/blob/master/05_stdin_to_hls/README.md

```bash
# terminal 1 & 2
export PIPENAME=audio.pipe
export OUT_FOLDER=./out/singlefilehls
export AUDIO_FILE=./out/english_thelittlegraylamb_sullivan_csm_64kb.pcm 

# terminal 1
mkfifo ${PIPENAME}
# file descriptors are unique to a process (this is what keeps the pipe open).
exec 7<>${PIPENAME}

cat ${AUDIO_FILE} > ${PIPENAME}
cat ${AUDIO_FILE} | head -c 400000 > ${PIPENAME}
cat ${AUDIO_FILE} | tail -c+400001 | head -c 400000  > ${PIPENAME}
cat ${AUDIO_FILE} | tail -c+800001 | head -c 400000  > ${PIPENAME}

# terminal 2
#rm -rf ${OUT_FOLDER}
mkdir -p ${OUT_FOLDER}
ffmpeg -hide_banner -y -f f32le -ar 16000 -channels 1 -i pipe:0 -c:a aac -b:a 128k -muxdelay 0 -f hls -hls_time 10 -hls_segment_type mpegts -hls_segment_filename "${OUT_FOLDER}/file%d.ts" "${OUT_FOLDER}/playlist.m3u8" < ${PIPENAME}

# cleanup
exec 7>&-   
rm ${PIPENAME}
 
vlc "${OUT_FOLDER}/playlist.m3u8"
```


```bash
ps aux | grep ffmpeg 
lsof -p 1024 
echo $$   

# list open files in shell
lsof -p $$

# list file locks
sudo lsof -p 1024 -r 5  

./flock_a_file.sh -x

pgrep bash    
lsof -p 17682 

# cannot lock the file twice
./flock_a_file.sh -x

# shared locks
./flock_a_file.sh -s
./flock_a_file.sh -s
```

## Filesystem Locks

https://github.com/chrisguest75/cpp_examples/blob/main/01_helloworld_cmake/README.md


```sh

```



## Resources

* Flock repo [here](https://github.com/discoteq/flock)  

* https://www.oreilly.com/library/view/python-cookbook/0596001673/ch04s25.html



