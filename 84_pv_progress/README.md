# PV

pv - monitor the progress of data through a pipe

## Contents

- [PV](#pv)
  - [Contents](#contents)
  - [Install](#install)
  - [Examples](#examples)
    - [Measure the time taken to read a large file](#measure-the-time-taken-to-read-a-large-file)
    - [Measure the time taken to compress a large file to GZIP](#measure-the-time-taken-to-compress-a-large-file-to-gzip)
  - [Resources](#resources)

## Install

```sh
brew info pv  

brew install pv
```

## Examples

```sh
FILEPATH=./cv-corpus-16.1-2023-12-06-fr.tar
```

### Measure the time taken to read a large file

```sh
# pipe with filesize
cat ${FILEPATH} | pv -s $(stat -c %s ${FILEPATH}) > /dev/null
```

### Measure the time taken to compress a large file to GZIP

```sh
pv -s $(stat -c %s ${FILEPATH}) ${FILEPATH} | gzip > ${FILEPATH}.gz
```

## Resources

- pv - Pipe Viewer - is a terminal-based tool for monitoring the progress of data through a pipeline. [here](https://www.ivarch.com/programs/pv.shtml)  
