# README

Quick walkthrough of how to use git patching.  

TODO:

* Be careful with binary files

## Creating a patch from diff

```sh
# create a patch for the difference
git format-patch HEAD~1       
```

## Creating a patch with unstaged changes

```sh
git config --global alias.make-patch '!bash -c "cd ${GIT_PREFIX};git add .;git commit -m ''uncommited''; git format-patch HEAD~1; git reset HEAD~1"'

git make-patch

git diff HEAD > file_name.patch
```

## Resources

* Send A Patch To Someone Using `git format-patch` [here](https://thoughtbot.com/blog/send-a-patch-to-someone-using-git-format-patch)
