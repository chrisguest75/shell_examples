# README
Demonstrates techniques for using awk to process files.

## Examples 
```sh
# lines of 2 and 3 items 
cat example1.txt | awk '{print $1,$2}'
cat example1.txt | awk '{print $1,$2,$3}'

# if a line of three items split onto 2 lines.
cat example1.txt | awk '{if(!$3) {print $1,$2} else {print $1,$3;print $1,$2}}'
```

# Resources
* `cheatsheet awk`


