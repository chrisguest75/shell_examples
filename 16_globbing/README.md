# README.md
Demonstrates techniques for globbing and operating on sets of files 

## TODO
1. Use globbing from shell
1. Using globbing in scripts
1. shopts and controlling behaviour
1. path expansion

```bash
# For each directory name create an empty file in the out directory with the filename the same as the directory 
mkdir ./out
echo ../* | xargs -n1 | sed 's/..\//.\/out\//g' | xargs -I % touch % 
```

```bash
# For each directory echo out the name
find .. -name "[0-9][0-9]_*" -exec echo {} \; 
```

```bash
# Find all shell scripts with shebang.
grep -R "/usr/bin/env" --include="*.sh" ../* 
```

```zsh
# zsh
setopt extendedglob
ls ^d*.txt
unsetopt extendedglob
```

