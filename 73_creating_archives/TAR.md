# TAR

A tar file is not a compressed file; it's a collection or concatenation of files within a single file without any compression. It simply appends each file end-to-end without any additional metadata except for file names and file sizes.  

## Archive

Generate an example archive from local files.  

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
```

## List

```sh
# list files in an archive
tar -tf ././out/test.tar
```

## Unarchive

```sh
mkdir -p ./out/test/test

# strip 
tar --strip-components=1 --directory=./out/ -xzvf ./out/test.tar

# change directory
tar xf ./out/test.tar --directory=./out/out/test/test
```

## Extract direct to S3

If you're dealing with huge archives S3 is much better than a filesystem.  

```sh
export AWS_PROFILE=myprofile
export AWS_REGION=eu-west-1
BUCKET_NAME=mybucket
aws s3 mb s3://${BUCKET_NAME}

# echo names
tar -xf ./out/test.tar --to-command="echo \$TAR_REALNAME" 

# extract files
tar -xf ./out/test.tar --to-command="aws s3 cp - s3://${BUCKET_NAME}/test/\$TAR_REALNAME" 

# list files
aws s3 ls s3://${BUCKET_NAME}
```

## Resources

* untar tar file using --strip-components=1 [here](https://stackoverflow.com/questions/41243174/untar-tar-file-using-strip-components-1)
* tar (computing) wikipedia [here](https://en.wikipedia.org/wiki/Tar_(computing))  
* AWS CLI S3 [33_awscli/S3.md](../33_awscli/S3.md)  
