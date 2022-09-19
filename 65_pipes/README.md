# README

Demonstrate how to work with pipes.  

REF: [46_stdin_stdout_stderr/README.md](../46_stdin_stdout_stderr/README.md)  

## Create

NOTE: If you have two processes tailing the pipe it will be first come first serve  
It will block inputting to the pipe until something is connected to it.  

```bash
# create a pipe
mkfifo pipetest

# pipes are designated 'p'
ls -la        

# tail the pipe
tail -f pipetest 

# send data to it
echo "hello world" >> pipetest    
```

## ffmpeg

```bash
# pipe a file in through stdin
mkdir -p ./out
export AUDIO_FILE=./sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/english_achristmastree_dickens_rg_64kb.mp3
cat ${AUDIO_FILE} | ffmpeg -i pipe:0 ./out/english_achristmastree_dickens_rg_64kb.wav

# pipe a file in through a named pipe
mkfifo audiopipe
cat ${AUDIO_FILE} > audiopipe
ffmpeg -i pipe:0 ./out/english_achristmastree_dickens_rg_64kb.wav < audiopipe
```

## Resources

* Send stdout to Multiple Commands [here](https://www.baeldung.com/linux/stdout-to-multiple-commands)
* How to make ffmpeg write its output to a named pipe [here](https://stackoverflow.com/questions/32584220/how-to-make-ffmpeg-write-its-output-to-a-named-pipe)
* Anonymous and Named Pipes in Linux [here](https://www.baeldung.com/linux/anonymous-named-pipes)
