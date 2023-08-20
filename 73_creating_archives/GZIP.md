# GZIP

gzip is designed to compress single files. If you want to compress multiple files or directories, you usually need to first combine them into a single file (often using tar on Unix-like systems), and then compress that file with gzip.  

```sh
# compress
gzip -S .gzip file

# decompress
gunzip -S .gzip ./file.gzip  
```

## Resources

* Using gzip and gunzip in Linux [here](https://www.baeldung.com/linux/gzip-and-gunzip)
