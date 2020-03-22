# README
Demonstrates how read from stdin stream and process it. 

## Example
It will sum up the list of items.
```
cat input.txt | ./pipe_filter.sh 
```

This will filter items from the summary. 
```
cat input.txt | ./pipe_filter.sh pears
```

It also supports glob matching to remove avacados and apples
```
cat input.txt | ./pipe_filter.sh "a*"
```

