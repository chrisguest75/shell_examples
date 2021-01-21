# README.md
A few examples on using shell to find files

## LS
Find files and folders beginning with 2
```sh
ls -ld ../2* 
```

## Find

```sh
#case match
find ../ -name "*.txt" 
#case-insensitive
find ../ -iname "*.txt"

# created in last 3 days
stat ../05_strings/README.md  
find ../ -iname "*.md" -ctime +3
```

## Locate

```sh
sudo apt-get install locate
sudo updatedb
locate updatedb
locate  "/etc/*.conf"
```

## Grep

```sh
grep README ../*
```

