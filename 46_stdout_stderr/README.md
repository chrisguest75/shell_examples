# README
Demonstrate and work through some stdout and stderr redirection 

TODO:
* find out if people use a 3rd FD for warnings and trace.. 
* piping just stderr to stdin `git fetch --dry-run 2>| tee`
* prefixing name of pipe to each line....  

## File Descriptors
```sh
# show what tty my stdin, stdout and stderr are connected to.
lsof +f g -ap $$ -d 0,1,2     
```

## Redirecting to files
```sh
mkdir ./out

# generates stdout and stderr
./generate.sh   

# filter off stdout 
./generate.sh > ./out/stdout.txt   

# filter off stderr
./generate.sh 2> ./out/stderr.txt    

#filter both 
./generate.sh > ./out/stdout2.txt 2> ./out/stderr2.txt  
```
## Redirecting to processes
```sh
# prepend each stream with tag
./generate.sh 2> >(awk '{print "stderr:" $0}') > >(awk '{print "stdout:" $0}')
```

## Merging pipes (works in both bash and zsh)
```sh
# merge stderr into stdout
./generate.sh &> ./out/stdout_combined.txt 

# merge stderr into stdout
./generate.sh &> >(awk '{print "stdout:" $0}')
```
# Resources 


* redirection_tutorial [here](https://wiki.bash-hackers.org/howto/redirection_tutorial)  
* redirection on bash hackers [here](https://wiki.bash-hackers.org/syntax/redirection)  