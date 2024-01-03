# REBASING

Quick walkthrough of switching `bases` on a branch.  

## Contents

- [REBASING](#rebasing)
  - [Contents](#contents)
  - [Reason](#reason)
    - [Why rebasing?](#why-rebasing)
  - [Create repo](#create-repo)
    - [Add files to default branch](#add-files-to-default-branch)
    - [Create feature branch](#create-feature-branch)
    - [Create pipeline branch](#create-pipeline-branch)
    - [Rebase pipeline to the feature](#rebase-pipeline-to-the-feature)
    - [Rebase pipeline back to main](#rebase-pipeline-back-to-main)
  - [Merging into main and maintaining other branches](#merging-into-main-and-maintaining-other-branches)
  - [Resources](#resources)

## Reason

To test a pipeline change with multiple different sources.  You may want to switch the base from master/main to features.  

### Why rebasing?

You might consider using Git rebase in the following situations:

Cleaner Commit History: Rebasing can be used to clean up your branch history by aggregating related changes into fewer commits and removing unneeded commits. This makes it easier to understand the evolution of your code and reduces clutter in your branch history.

Avoiding Merge Commits: Rebasing can be used to avoid the creation of unnecessary merge commits in your branch history. Instead of merging, you can reapply your branch changes on top of the target branch, resulting in a cleaner, linear history.

Keeping Your Branch Up-to-Date: Rebasing can be used to keep your branch up-to-date with the target branch by reapplying your branch changes on top of the latest changes in the target branch. This makes it easier to merge your branch later on, as there are fewer conflicts to resolve.

Isolation of Changes: Rebasing can be used to isolate your branch changes from the target branch, making it easier to identify and test your changes independently from other changes in the target branch.

Note that rebasing can be a complex operation, and it can also result in conflicts if the target branch has changed since your branch was created. Therefore, it is important to understand the implications of rebasing and to use it with caution, especially in collaboration with other developers. It's a good idea to back up your branch before rebasing, and to communicate with your team before and after the rebase to minimize potential conflicts.

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
echo "testing feature $(date '+%s')" >> ./example{2..5}.txt
git add .
git commit -m "example feature changes $(date '+%s')"
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
echo "pipeline $(date '+%s')" >> ./.pipeline/pipeline.yaml
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

NOTE: You can create a new temporary branch just for this test.  It's probably easier if the branches have lots of commits to remove afterwards.  

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

## Merging into main and maintaining other branches

```sh
git switch main

# simulate work in main
# repeat this a few times altering the range
echo "merged into main $(date '+%s')" >> ./1.txt
git add .
git commit -m "merged into main $(date '+%s')"
git log --oneline

# using git-extras see differences between branches
git switch features
git-missing main feature1
# rebase feature1 branch with merges into main
git rebase main
git-missing main feature1

# rebase the branches off main
git switch feature1_pipeline1
git log --oneline
git rebase feature1
git log --oneline
```

## Resources

* 7.6 Git Tools - Rewriting History [here](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History)  
