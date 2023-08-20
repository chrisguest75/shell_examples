# TAR

A tar file is not a compressed file; it's a collection or concatenation of files within a single file without any compression. It simply appends each file end-to-end without any additional metadata except for file names and file sizes.  

```sh
man tar 

mkdir -p ./in ./out

# dereference is following symbolic links
tar -cvf ./out/test.tar  --dereference .

cat >./in/files.txt <<EOF
README.md
../README.md
EOF

# create a tar from a list of files
tar -cvf ./out/test.tar -T ./in/files.txt

mkdir -p ./out/test/test

tar --strip-components=1 --directory=./out/ -xzvf ./out/test.tar

# change directory
tar xf ./out/test.tar --directory=./out/out/test/test
```

## Resources

* untar tar file using --strip-components=1 [here](https://stackoverflow.com/questions/41243174/untar-tar-file-using-strip-components-1)
* tar (computing) wikipedia [here](https://en.wikipedia.org/wiki/Tar_(computing))  
