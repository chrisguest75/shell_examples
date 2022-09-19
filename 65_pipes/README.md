# README

Demonstrate how to work with pipes.  

REF: [46_stdin_stdout_stderr/README.md](../46_stdin_stdout_stderr/README.md)  

## Create

```bash
mkfifo pipetest

echo "hello world" >> pipetest       
```

## Resources


Mkfifo
https://unix.stackexchange.com/questions/497652/how-to-redirect-stdin-using-mkfifo

https://www.baeldung.com/linux/stdout-to-multiple-commands

Named.pipes 
https://stackoverflow.com/questions/11750041/how-to-create-a-named-pipe-in-node-js


https://stackoverflow.com/questions/32584220/how-to-make-ffmpeg-write-its-output-to-a-named-pipe

Need to use a named pipe for input into ffmpeg... 

Named pipes... 
https://www.baeldung.com/linux/anonymous-named-pipes


