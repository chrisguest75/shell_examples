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

## CSV

```sh
awk -F "," '{print $1}'
```

## Prepending text

```sh
# prepending text to output
cat example1.txt | awk '{print "stdout:" $0;}'
```

## Trimming

```sh
# white space

# replace a character
```

## Processing LDD output

```sh
# extracting a specific field
mkdir -p ./out
cat ./jq_libs.txt | awk 'NF == 4 { {print $3} }' > ./out/jq_libs_extracted.txt

# get unique paths
cat ./out/jq_libs_extracted.txt | awk -F/ -vOFS=/ '{ print $1,$2,$3,$4; }' | sort -u
```

## Resources

* `cheatsheet awk`
