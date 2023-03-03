# README

A few examples on using shell cmd to find files

TODO:

* Use prune in find to exclude folders

- [README](#readme)
  - [ls](#ls)
  - [Find](#find)
  - [Grep](#grep)
  - [Locate (debian)](#locate-debian)
  - [exa](#exa)
  - [fd](#fd)
  - [ripgrep](#ripgrep)
  - [Resources](#resources)

## ls

ls - list directory contents

```sh
cd 24_finding_files

#find files and folders beginning with 2 (filenames only) 
ls -1d ../2* 
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

# find all vscode workspace folders for shell_examples
find $HOME/Library/Application\ Support/Code/User/workspaceStorage/ -name "*.json" -print -exec jq . {} \; | grep -A 10 -B 10 'shell_examples"'
```

## Grep

grep, egrep, fgrep, rgrep - print lines that match patterns

```sh
# find files containing case-insenitive 'readme'. 
grep -i README ../*

# find all files with a shebang
grep -R "/usr/bin/env" --include="*.sh" ../* 
```

## Locate (debian)

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

## exa

```sh
brew install exa

# find all markdown files
exa -laTR --icons --git | grep ".*\.md"
```

## fd

```sh
brew install fd

# find all files
fd

# find extension md
fd -e md
```

## ripgrep

```sh
brew install ripgrep

# find all files containing README
rg README

# searching in node_modules (including .gitignore) 
rg --no-ignore --hidden "items to be sent"
```


## Resources

* ogham/exa repo [here](https://github.com/ogham/exa)  
* sharkdp/fd repo [here](https://github.com/sharkdp/fd)  
* BurntSushi/ripgrep [here](https://github.com/BurntSushi/ripgrep)  
