# README

Demonstrates how read from stdin stream and process it.  

## Reason

Show how to use piped data inside scripts.  This is useful when writing scripts that need to operate on piped data.  
  
"It is the unix way"  
  
## Examples

It will sum up the list of items in the [input.txt](./input.txt) file.

```sh
# 
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
