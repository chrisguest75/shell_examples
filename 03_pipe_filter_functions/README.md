# README
Demonstrates how read from stdin stream and process it. 

NOTE: Why does the declare not stop the unbound variable check from triggering. 

## Example
It will sum up the list of items in the [input.txt](./input.txt) file.
```sh
cat input.txt | ./pipe_filter.sh 
```

This will filter items from the summary. 
```sh
cat input.txt | ./pipe_filter.sh pears
```

It also supports glob matching to remove avacados and apples
```sh
cat input.txt | ./pipe_filter.sh "a*"
```


