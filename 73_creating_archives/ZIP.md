# ZIP

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

## Resources

* How to do zip and unzip file in Ubuntu Linux? [here](https://www.mysoftkey.com/linux/how-to-do-zip-and-unzip-file-in-ubuntu-linux/)
* Gzip vs Zip: difference between the most popular compressing file formats [here](https://nixcp.com/gzip-vs-zip-differences/)  
