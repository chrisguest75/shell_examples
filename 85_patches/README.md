# PATCHES

Demonstrate different ways of creating patches.  

REF: [36_git/sections/PATCHING.md](../36_git/sections/PATCHING.md)
REF: [68_difftools/README.md](../68_difftools/README.md)

NOTES:

* Pure patches need to be applied at the same stage of code - otherwise the tooling errors in lots of places.  

## Contents

- [PATCHES](#patches)
  - [Contents](#contents)
  - [Tools](#tools)
  - [Creation](#creation)
    - [Git Staged](#git-staged)
    - [Git Stashes](#git-stashes)
    - [Diff](#diff)
  - [Applying](#applying)
    - [Git](#git)
    - [Patch](#patch)
  - [Scenarios](#scenarios)
    - [Scenario 1](#scenario-1)
    - [Scenario 2](#scenario-2)
  - [Resources](#resources)

TODO:

* I want to be able create patch files of unstaged files.
    * New files and modifications of files 
* listing files in a patch  
* Is it better to just zip up the changed files and decompress them over a directory?
* multibyte characterset documents
* git diff
* git format-patch
* baseless patches
* Create a file with entire contents
* Context and Unified Formats
* Worktree diffs?

## Tools

| Tool | Description |
| --- | --- |
| diff | compare files line by line |
| cmd | compare two files byte by byte |
| diff3 | compare three files line by line |
| git diff | Show changes between commits, commit and working tree, etc |
| git format-patch | Prepare patches for e-mail submission |
| git apply | Apply a patch to files and/or to the index |
| patch | apply a diff file to an original |

## Creation

### Git Staged

Add files to staging then get a diff.  

```sh
git diff --name-only --cached

git diff --cached

# get the patch
git diff --cached --patch > ./patches/move_test.patch
```

### Git Stashes

Create patches from stashes.  

```sh
# list stashes
git stash list

# patch
git stash show -p stash@{0} > my_stash.patch
```

### Diff

```sh
# -N absent files as empty
# -a text files
# -u unified
# -r recursive
diff -Naur ./src-directory ./dest-directory
```

## Applying

Taking patches from a source tree to another.  

### Git

```sh
# Git Apply
git apply --ignore-whitespace patches/move_test.patch

# Git Reverting
git apply -R patches/move_test.patch
```

### Patch

```sh
# you can dry run (it's also a cheap way of listing file in the patch)
patch -p1 --dry-run --force --merge -i patches/fullfile.patch

# applying a patch
patch -p1 -i patches/move_test.patch   

# Patch Revert
patch -p1 -R -i patches/move_test.patch 

patch -p1 --force --merge -i patches/fullfile.patch
```

## Scenarios

### Scenario 1

File is missing in the patch target.  A file that is modified in the source does not exist in the target. 

The patch tool warns that it cannot find the file and it stores a the unapplied patch in a `..rej ` folder.  

### Scenario 2

You want to keep a full file for all new/modified files.  When applying you just want to overwrite the existing files.  

```sh
# First, find the empty tree's hash
EMPTY_TREE=$(git hash-object -t tree /dev/null)
# Then, for each modified file, create a diff against the empty tree
git diff $EMPTY_TREE your_file > your_file.patch
```

## Resources

* Generating patch text with -p [here](https://git-scm.com/docs/diff-generate-patch)  
* Comparing and Merging Files [here](https://www.gnu.org/software/diffutils/manual/html_node/index.html)  
* Git Diff and Patch – Full Handbook for Developers [here](https://www.freecodecamp.org/news/git-diff-and-patch/)
