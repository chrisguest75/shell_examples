# README

Demonstrates techniques for globbing and operating on sets of files  

TODO:

1. shopts and controlling behaviour
2. path expansion

## Looping

```sh
# enter shell
bash 

# enable globbing
set +f 

# loop
counter=1
for file in *; do
    echo "$file -> ${counter}"
    counter=$((counter + 1))  
done
```

## Oneliners

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

## Zsh

```zsh
# zsh
setopt extendedglob
ls ^d*.txt
unsetopt extendedglob
```

## Resources
