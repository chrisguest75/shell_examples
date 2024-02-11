# ARCHIVES

Demonstrate how to create archive files.  

TODO:

* zlib, pigz (parallel gzip)
* provide timings and performance on large fake data generated files
* xz --long-help
* checksums for recovery?

- [ARCHIVES](#archives)
  - [Reason](#reason)
  - [Tricks](#tricks)
  - [ZIP](#zip)
  - [GZIP](#gzip)
  - [ZSTD](#zstd)
  - [TAR](#tar)
  - [XZ](#xz)
  - [Resources](#resources)

## Reason

It's useful to be able to quickly create and restore archives.  

## Tricks

```sh
# use file to identify the types of compression
file ./file.zip
> Zip archive data, at least v2.0 to extract, compression method=deflate

file ./file.gz
> gzip compressed data, from Unix, original size modulo 2^32 231151

file ./file.tar
> ./file.tar: POSIX tar archive
```

## ZIP

Zip examples [ZIP.md](./ZIP.md)  

## GZIP

GZIP examples [GZIP.md](./GZIP.md)  

## ZSTD

ZSTD examples [ZSTD.md](./ZSTD.md)  

## TAR

TAR examples [TAR.md](./TAR.md)  

## XZ

XZ examples [XZ.md](./XZ.md)  

## Resources

* List of archive formats [here](https://en.wikipedia.org/wiki/List_of_archive_formats)  
* Silesia compression corpus [here](https://sun.aei.polsl.pl/~sdeor/index.php?page=silesia)
