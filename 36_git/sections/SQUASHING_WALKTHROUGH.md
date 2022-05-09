# SQUASHING

Quick walkthrough of `squashing` commits to simplify commit history and rebases.  

TODO:

* Continue to edit default branch and then rebase.

## Create repo

```sh
mkdir -p ./git_testing && cd ./git_testing
git init
```

### Add files to default branch

```sh
# add example files to master
echo "testing $(date '+%s')" > ./example.txt
git add .
git commit -m "example change"
git log --oneline

echo "testing $(date '+%s')" >> ./example.txt
git add .
git commit -m "example change2"
git log --oneline

echo "testing $(date '+%s')" >> ./example.txt
git add .
git commit -m "example change3"
git log --oneline
```

### Create feature branch

```sh
# create feature branch
git checkout -b newfeature

# repeat this a few times altering the range
echo "testing $(date '+%s')" >> ./example{2..5}.txt
git add .
git commit -m "example changes $(date '+%s')"
git log --oneline

# get a common ancestor commitid
git merge-base newfeature main
```

### Squashing by reverting

```sh
# squash master (remove all the log entries)
git reset --soft <firstid>
git status

# example txt is now final version 
cat example.txt
git log -n 4

## commit it back
git add .
git commit -m "example change3"
git log --oneline

## diff head 
git diff head~1..head
```

### Squashing using git-extras

```sh
# squash top two commmits
git squash --squash-msg head~2                         

# squash to common ancestor 
git squash --squash-msg $(git merge-base newfeature main)

# show files in top branch commit
git show --name-only head
```
