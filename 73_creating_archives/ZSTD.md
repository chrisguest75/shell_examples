# ZSTD

Zstandard (often abbreviated as zstd) is a real-time compression algorithm developed by Yann Collet at Facebook. It offers very good compression ratios and decompression speeds, often outperforming other algorithms like zlib (used in gzip) for many tasks.  

`zstd` is a fast lossless compression algorithm and data compression tool,with command line syntax similar to gzip(1) and xz(1). It is based on the LZ77 family, with further FSE & huff0 entropy stages. zstd offers highly configurable compression speed, from fast modes at > 200 MB/s per core, to strong modes with excellent compression ratios. It also features a very fast decoder, with speeds > 500 MB/s per core.  

zstd offers dictionary compression, which greatly improves efficiency on small files and messages. It´s possible to train zstd with a set of samples, the result of which is saved into a file called a dictionary. Then, during compression and decompression, reference the same dictionary, using command -D dictionaryFileName. Compression of small files similar to the sample set will be greatly improved.  

NOTES:

* `zstd` will concatenate multiple files into one, if you want multiple files use TAR with --zstd switch.  

## Compress

```sh
cat >./in/files.txt <<EOF
README.md
../README.md
EOF

zstd --filelist ./in/files.txt -o ./out/files.zst  
```

## Decompress

Check that the multiple files are concatenated.  

```sh
zstd -d ./out/files.zst  
```

## Resources

* List of archive formats [here](https://en.wikipedia.org/wiki/List_of_archive_formats)  
* zstd wikipedia [here](https://en.wikipedia.org/wiki/Zstd)  
