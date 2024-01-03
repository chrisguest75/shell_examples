# SEARCHING

Demonstrate some examples of searching for commits.  

## Contents

- [SEARCHING](#searching)
  - [Contents](#contents)
  - [Authors](#authors)
  - [Finding strings](#finding-strings)
  - [Find commits](#find-commits)
  - [Dates](#dates)
  - [Finding files](#finding-files)
  - [Iterate revision history](#iterate-revision-history)

## Authors

```sh
# find all the authors
git authors --list | sort
```

## Finding strings

```sh
git grep 'searching'
```

## Find commits

```sh
# search for author
git log --author "Chris Guest" 

# find mentions of configuration (-p prints the diff and grep shows the lines of code) 
git log -S "configuration" -p | grep configuration

# find mentions of cheatsheet by author
git log --author "Chris Guest" -S "cheatsheet" -p
```

## Dates

```sh
# find commits between certain dates.
git log --after="2023-10-11" --before="2023-10-15"
```

## Finding files

```sh
# find files called SEARCHING.md
git log --all --full-history --name-status -- '**/SEARCHING.md' 

# find files containing log 
git log --all --full-history --name-status -S "searching"

# show file contents for a revision
git show f45e60a25e667cf836fc4d8b763c4d9603a4f5d5:36_git/sections/SEARCHING.md

# show history from a revision
git log 7cc62a0083ae153044e1bfe880cde81ef2e42e1e -- 36_git/sections/SEARCHING.md
```

## Iterate revision history

```sh
git rev-list --all | (
    while read revision; do
        git grep -l 'searching' $revision
    done
)
```
