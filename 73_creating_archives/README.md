# ARCHIVES

Demonstrate how to create archive files.  

TODO:

* zip
* tar
* gzip
* zlib

## Reason




## Zip

Zip can compress multiple files and even entire directory hierarchies. gzip, on the other hand, compresses only a single file. That's why we typically use it with tar, which packages multiple files/directories into a single archive file

```sh
# look at zip without decompressing
unzip -l ./layer/layer.zip      
```

## Tar

```sh
tar -cvf /scratch/libraries.tar -T /scratch/libs_paths.txt
tar xf /scratch/libraries.tar --directory=/output/libs
```

## Gzip


## Resources

* https://www.baeldung.com/linux/gzip-and-gunzip
* https://www.mysoftkey.com/linux/how-to-do-zip-and-unzip-file-in-ubuntu-linux/
* https://nixcp.com/gzip-vs-zip-differences/
