# TAR

A tar file is not a compressed file; it's a collection or concatenation of files within a single file without any compression. It simply appends each file end-to-end without any additional metadata except for file names and file sizes.  

## Contents

- [TAR](#tar)
  - [Contents](#contents)
  - [Archive](#archive)
  - [List](#list)
  - [Unarchive](#unarchive)
  - [Extract direct to S3](#extract-direct-to-s3)
  - [Huge Archives](#huge-archives)
    - [Common Voice Archives](#common-voice-archives)
    - [(Pixz (pronounced pixie) is a parallel, indexing version of xz)](#pixz-pronounced-pixie-is-a-parallel-indexing-version-of-xz)
  - [Resources](#resources)

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
# auto compress with extension tgz (creates tar.gz)
tar -a -cvf ./out/test.tgz -T ./in/files.txt
# works as well
tar -a -cvf ./out/test.tar.gz -T ./in/files.txt
```

## List

```sh
# list files in an archive
tar -tf ././out/test.tar
```

## Unarchive

```sh
mkdir -p ./out/test/test

# strip first directory level 
tar --strip-components=1 --directory=./out/ -xzvf ./out/test.tar

# change directory
tar xf ./out/test.tar --directory=./out/out/test/test

# extract tgz.
tar -xvzf ./out/test.tgz
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

# extract files to directly to s3
tar -xf ./out/test.tar --to-command="aws s3 cp - s3://${BUCKET_NAME}/test/\$TAR_REALNAME" 

# list files
aws s3 ls s3://${BUCKET_NAME}
```

## Huge Archives

One of the challenges with TAR files is that they are designed for sequential access. Extraction of a single file can take a long time.  

If you're writing a process to extract single files it's important to test the user experience.  

NOTE: Using WSL and storing these huge archives on the Windows System Partitions will cause significant performance loss. Even more than you might sensibly expect  

### Common Voice Archives

```sh
mkdir -p ./out/fr/tar ./out/fr/gz
mkdir -p ./out/wsl/fr/tar 

# french corpus is 28GB.
TARFILEPATH=./in/cv-corpus-16.1-2023-12-06-fr.tar
TARFILEPATH=./cv-corpus-16.1-2023-12-06-fr.tar

# standard tar "WSL NTFS - time: 3:32.97 total"
time tar --directory=./out/fr/tar -xvf ${TARFILEPATH} cv-corpus-16.1-2023-12-06/fr/validated.tsv

# gzipped tar (tar file gzipped) "WSL NTFS - time: 5:13.47 total"
time tar --directory=./out/fr/gz -xvf ${TARFILEPATH}.gz  cv-corpus-16.1-2023-12-06/fr/validated.tsv

# if copied to the wsl filesystem "WSL LINUXFS - time: 30.313 total"
# make sure the file is copied under your ~/ and not on /mnt/c
TARFILEPATH=~/Code/oss/corpus/cv-corpus-16.1-2023-12-06-fr.tar
time tar --directory=./out/wsl/fr/tar -xvf ${TARFILEPATH} cv-corpus-16.1-2023-12-06/fr/validated.tsv

# write files list
time tar -tf cv-corpus-16.1-2023-12-06-fr.tar > cv-corpus-16.1-2023-12-06-fr.tar.files.txt
```

### (Pixz (pronounced pixie) is a parallel, indexing version of xz)

[vasi/pixz](https://github.com/vasi/pixz)

```sh
brew search pixz
brew info pixz
brew install pixz

TARFILEPATH=./cv-corpus-16.1-2023-12-06-fr.tar

# convert to indexed xz (time: 24:54.79 total) for 28GB on a dedicated linux box
time pixz ${TARFILEPATH} ./out/cv-corpus-16.1-2023-12-06-fr.tpxz

# extraction is very quick (1.721 total)
mkdir -p ./out/fr/pixz
time pixz -x cv-corpus-16.1-2023-12-06/fr/validated.tsv < ./out/cv-corpus-16.1-2023-12-06-fr.tpxz > ./out/fr/pixz/validated.tsv
```

## Resources

* untar tar file using --strip-components=1 [here](https://stackoverflow.com/questions/41243174/untar-tar-file-using-strip-components-1)
* tar (computing) wikipedia [here](https://en.wikipedia.org/wiki/Tar_(computing))  
* AWS CLI S3 [33_awscli/S3.md](../33_awscli/S3.md)  
