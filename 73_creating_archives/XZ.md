# XZ

xz is a general-purpose data compression tool with command line syntax similar to gzip(1) and bzip2(1).  The native file format is the .xz format, but the legacy .lzma format used by LZMA Utils and raw compressed streams with no container format headers are also supported.  In addition, decompression of the .lz format used by lzip is supported.  

## Compress

```sh
mkdir -p ./out

xz --compress ./README.md
```

## Decompress

```sh
xz --decompress ./README.md.xz
```


## Resources

* Using xz Compression in Linux [here](https://www.baeldung.com/linux/xz-compression)  
