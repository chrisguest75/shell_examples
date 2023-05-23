# ARCHIVES

Demonstrate how to create archive files.  

TODO:

* zip
* tar
* gzip
* zlib

- [ARCHIVES](#archives)
  - [Reason](#reason)
  - [ZIP](#zip)
  - [GZIP](#gzip)
  - [TAR](#tar)
  - [Resources](#resources)

## Reason

It's useful to be able to quickly create and restore archives.  

## ZIP

Zip can compress multiple files and even entire directory hierarchies. gzip, on the other hand, compresses only a single file. That's why we typically use it with tar, which packages multiple files/directories into a single archive file.  

```sh
# create a zip with a base path
mkdir -p ./out
zip -b ../73_creating_archives -r ./out/test.zip ./in/*

# look at zip without decompressing
unzip -l ./out/test.zip

# unzip into a folder
unzip -d ./out/unzipped ./out/test.zip
```

## GZIP

gzip is designed to compress single files. If you want to compress multiple files or directories, you usually need to first combine them into a single file (often using tar on Unix-like systems), and then compress that file with gzip.  

```sh
# compress
gzip -S .gzip file

# decompress
gunzip -S .gzip ./file.gzip  
```

## TAR

A tar file is not a compressed file; it's a collection or concatenation of files within a single file without any compression. It simply appends each file end-to-end without any additional metadata except for file names and file sizes.  

```sh
man tar 

mkdir -p ./in ./out

# dereference is following symbolic links
tar -cvf ./out/test.tar  --dereference 

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

* Using gzip and gunzip in Linux [here](https://www.baeldung.com/linux/gzip-and-gunzip)
* How to do zip and unzip file in Ubuntu Linux? [here](https://www.mysoftkey.com/linux/how-to-do-zip-and-unzip-file-in-ubuntu-linux/)
* Gzip vs Zip: difference between the most popular compressing file formats [here](https://nixcp.com/gzip-vs-zip-differences/)
* untar tar file using --strip-components=1 [here](https://stackoverflow.com/questions/41243174/untar-tar-file-using-strip-components-1)

