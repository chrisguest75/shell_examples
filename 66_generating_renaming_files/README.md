# GENERATING AND RENAMING

Demonstrate techniques for generating and renaming files.  

TODO:  

* Changing file extensions `find . -name "*.js" -exec sh -c 'mv "$1" "${1%.js}.ts"' _ {} \;`

## Examples

Generate a bunch of files with leading zeros.  

```sh
file="file"
extension="txt"
outpath="./out/"
mkdir -p ${outpath}
for index in $(seq 0 10); 
do
    filepath=`printf %s%04d.%s ${outpath} ${index} ${extension}`
    echo "Creating ${filepath}"
    touch $filepath
    sleep 1
done
```

## Resources

* Add Leading Zeros to File Names [here](https://www.baeldung.com/linux/file-names-leading-zeros)  
* Renaming Linux Files in Batches [here](https://www.baeldung.com/linux/renaming-files-in-batches#tools)