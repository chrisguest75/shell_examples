# Squashing commmits on master
Quick walkthrough of squashing some commits.
## Create repo
```sh
mkdir -p ./git_testing && cd ./git_testing
git init
```

### Add files 
```sh
# add example files to squash
echo "testing" > ./example.txt
git add .
git commit -m "example change"
git log --oneline

echo "testing" >> ./example.txt
git add .
git commit -m "example change2"
git log --oneline

echo "testing" >> ./example.txt
git add .
git commit -m "example change3"
git log --oneline
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
```