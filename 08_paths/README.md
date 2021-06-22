# README
Demonstrates ways of manipulating paths 

Demonstrates techniques for discovering paths 
```sh
# output a set of paths relative and absolute to the script and current directory 
./paths.sh
```

Now copy the value of SCRIPT_FULL_PATH from output into paste buffer.
This will run the script from the root folder. 
```sh
cd /
$(pbpaste)
popd
```


