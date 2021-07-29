# README
Demonstrates techniques for using awk to process files.

## Examples 
This example was created for creating for breaking multi container pod images listed on a single line of output into multiple lines. 
```sh
# lines of 2 and 3 items 
cat example1.txt | awk '{print $1,$2}'
cat example1.txt | awk '{print $1,$2,$3}'

# if a line of three items split onto 2 lines.
cat example1.txt | awk '{if(!$3) {print $1,$2} else {print $1,$3;print $1,$2}}'
```

```sh
# prepending text to output
cat example1.txt | awk '{print "stdout:" $0;}'
```

# Resources
* `cheatsheet awk`


