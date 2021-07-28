# README
Demonstrate and work through some stdout and stderr redirection 

TODO:
* find out if people use a 3rd FD for warnings and trace.. 
## File Descriptors
```sh
# show what tty my stdin, stdout and stderr are connected to.
lsof +f g -ap $$ -d 0,1,2     
```

## Redirecting
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

# Resources 

* redirection_tutorial [here](https://wiki.bash-hackers.org/howto/redirection_tutorial)  
* redirection on bash hackers [here](https://wiki.bash-hackers.org/syntax/redirection)  