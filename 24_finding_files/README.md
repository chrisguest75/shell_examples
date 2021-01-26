# README.md
A few examples on using shell to find files

## ls 
ls - list directory contents

```sh
cd 24_finding_files

#find files and folders beginning with 2
ls -ld ../2* 
```

## Find
find - search for files in a directory hierarchy

```sh
#case match
find ../ -name "*.txt" 
#case-insensitive
find ../ -iname "*.txt"

# created in last 3 days
stat ../05_strings/README.md  
find ../ -iname "*.md" -ctime +3
```

## Grep
grep, egrep, fgrep, rgrep - print lines that match patterns

```sh
# find files containing readme. 
grep README ../*
```
## Locate
locate - list files in databases that match a pattern

```sh
# install locate
sudo apt-get install locate

# if locate returns nothing you need to run updatedb.
locate --statistics  
sudo updatedb

# locate should return modification date
locate --statistics  

# find files
locate updatedb
locate  "/etc/*.conf"
```


