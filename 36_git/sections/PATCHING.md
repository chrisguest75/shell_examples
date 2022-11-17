# README

Quick walkthrough of how to use git patching.  

TODO:

* Be careful with binary files
* Patching single files or a selection of files

## Creating a patch from diff

Creating patch files.  

```sh
# create a patch for the difference
git format-patch HEAD~1     

# calculate single patch for branch (without -1 each commit is a patch)
git format-patch -1 $(git merge-base --fork-point master)..mybranch
```

## Creating a patch with unstaged changes

Create a patch of unstaged files.  

```sh
git config --global alias.make-patch '!bash -c "cd ${GIT_PREFIX};git add .;git commit -m ''uncommited''; git format-patch HEAD~1; git reset HEAD~1"'

git make-patch

git diff HEAD > file_name.patch
```

## Applying patches

```sh
# applying a patch
patch -p1 -i patches/image-js+0.33.1.patch    

# git apply only works for files in index.
git apply --ignore-whitespace patches/image-js+0.33.1.patch  
```

## Resources

* Send A Patch To Someone Using `git format-patch` [here](https://thoughtbot.com/blog/send-a-patch-to-someone-using-git-format-patch)
* Example of generating patches for node_modules [here](https://github.com/chrisguest75/typescript_examples/blob/c7f44fbe0ce10e708ad9ac8035f459156e12b410/15_demoscene_banner/README.md#patching-image-js)
