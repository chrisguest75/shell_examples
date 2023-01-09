# REBASING

Quick walkthrough of switching `bases` on a branch.  

## Reason

To test a pipeline change with multiple different sources.  You may want to switch the base from master/main to features.  

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
git checkout -b feature1

# repeat this a few times altering the range
echo "testing $(date '+%s')" >> ./example{2..5}.txt
git add .
git commit -m "example changes $(date '+%s')"
git log --oneline

# get a common ancestor commitid
git merge-base feature1 main
```

### Create pipeline branch

```sh
git switch main
# create feature branch
git checkout -b pipeline1

# repeat this a few times altering the range
mkdir -p .pipeline
echo "pipeline $(date '+%s')" >> ./pipeline.yaml
git add .
git commit -m "example pipeline changes $(date '+%s')"
git log --oneline

# get a common ancestor commitid
git merge-base pipeline1 main
```

### Rebase pipeline to the feature

```sh
# rebase on feature
git rebase feature1
git log --oneline

# get a common ancestor commitid
git merge-base pipeline1 main
git merge-base feature1 main
```

### Rebase pipeline back to main

NOTE: You can create a new temporary branch just for this test.  It's probably easier if the brances have lots of commits to remove afterwards.  

Create new branch for the rebasing.  

```sh
git switch pipeline1
git checkout -b feature1_pipeline1

git rebase feature1
git log --oneline

git log pipeline1 --oneline
git log feature1 --oneline
```

Doing it in source branch.  

```sh
# switch rebase back to main - but we're already on main including feature
git rebase main
git log --oneline

# restoring by dropping the rebased branch
git rebase -i $(git merge-base pipeline1 main)
git log --oneline
```

## Resources

* 7.6 Git Tools - Rewriting History [here](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History)  
