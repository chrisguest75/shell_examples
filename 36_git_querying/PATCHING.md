# README
Quick walkthrough of how to use git patching.  

TODO:
* Be careful with binary files
* 

```sh
# create a patch for the difference
git format-patch HEAD~1       

```

git config --global alias.make-patch '!bash -c "cd ${GIT_PREFIX};git add .;git commit -m ''uncommited''; git format-patch HEAD~1; git reset HEAD~1"'

git make-patch

git diff HEAD > file_name.patch


