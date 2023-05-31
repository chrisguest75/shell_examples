# LOCKING FILES

Demonstrate locking and detection of locked files.

TODO:

* look at the locks that are taken on writing out a stream
* lsof
* /proc

## Install

```sh
brew install flock

man flock
```

## Show open files with locks

```bash
# get pid of shell
echo $$

# list open files in shell
lsof -p $$

# list file locks (repeat)
sudo lsof -p $$ -r 5  

./flock_a_file.sh -x

# show locks from pid in another terminal
pgrep bash    
lsof -p 17682 

# cannot lock the file twice (exits early)
./flock_a_file.sh -x

# shared locks (allow two locks)
./flock_a_file.sh -s
# terminal 2
./flock_a_file.sh -s
```

## Filesystem Locks

locksTool [README.md](./locksTool/README.md)  

```sh
```


## Create linux environment

```sh
# build
docker build --progress=plain -f Dockerfile -t locks .

# run (pops straight into a shell)
docker run --rm -it -v ./:/scratch locks


lslocks
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

ps aux | grep ffmpeg 
lsof -p 1024 

```


## Resources

* Flock repo [here](https://github.com/discoteq/flock)  

* https://www.oreilly.com/library/view/python-cookbook/0596001673/ch04s25.html



