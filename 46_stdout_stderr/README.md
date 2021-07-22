# README
Demonstrate and work through some stdout and stderr redirection 

## 
```sh
# show what tty my stdin, stdout and stderr are connected to.
lsof +f g -ap $$ -d 0,1,2     
```

```sh
 mkdir ./out

./generate.sh   
./generate.sh > ./out/stdout.txt   
./generate.sh 2> ./out/stderr.txt    
```

# Resources 

* redirection_tutorial [here](https://wiki.bash-hackers.org/howto/redirection_tutorial)