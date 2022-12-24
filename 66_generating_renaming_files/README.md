# GENERATING AND RENAMING

Demonstrate techniques for generating and renaming files.  

TODO:  

* Changing file extensions `find . -name "*.js" -exec sh -c 'mv "$1" "${1%.js}.ts"' _ {} \;`

## Examples (generation)

Generate a bunch of files with leading zeros.  

```sh
file="file"
extension="txt"
outpath="./out/"
mkdir -p ${outpath}
for index in $(seq 0 10); 
do
    filepath=`printf %s%s%04d.%s ${outpath} ${file} ${index} ${extension}`
    echo "Creating ${filepath}"
    touch $filepath
    sleep 1
done
```

## Examples (renaming)

Use `fd` Ref: [../24_finding_files/README.md](../24_finding_files/README.md)  

```sh
# show text files (generated above)  
fd -e txt . './out'

# renaming extensions  
fd -e txt . './out' -x mv {} {.}.text
```

## Resources

* Add Leading Zeros to File Names [here](https://www.baeldung.com/linux/file-names-leading-zeros)  
* Renaming Linux Files in Batches [here](https://www.baeldung.com/linux/renaming-files-in-batches#tools)
* sharkdp/fd repo [here](https://github.com/sharkdp/fd)  
