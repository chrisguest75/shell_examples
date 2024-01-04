# COMMITS

## Contents

- [COMMITS](#commits)
  - [Contents](#contents)
  - [Commits](#commits-1)
  - [How do I know what changes were in a commit?](#how-do-i-know-what-changes-were-in-a-commit)
  - [Rollback the last commit](#rollback-the-last-commit)
  - [Diff between two commits](#diff-between-two-commits)
  - [Get the top commitid](#get-the-top-commitid)
  - [Show the staged diff](#show-the-staged-diff)
    - [Show missing commits between branches](#show-missing-commits-between-branches)
  - [Show commits for current directory](#show-commits-for-current-directory)

## Commits

```sh
git show head --name-only
git show master~4 --name-only
git show master^1 --name-only

# try this in a local git init repo vs a cloned repo.  
# it fails in a cloned repo.
git log origin/HEAD..HEAD -n 1 

```

## How do I know what changes were in a commit?

```sh
# show last 4 commits on a branch
git log -n 4 --oneline <branch>

# choose a commit and list files
git show <commitid> --name-only --oneline            
```

## Rollback the last commit

Rollback in the current local branch  

```sh
# pop the last commit off and move the changed files into staging
git reset head~1    
```

Rollback on default branch.  

```sh
# create a new branch
git checkout -b reverting

# revert commit 
git revert head|commitid

# push and create an MR
git push 

# or switch to main and merge the commit in
git switch main
git merge reverting
```

## Diff between two commits

```sh
# diff changes on current branch
git diff head..head~1   

# diff across a branch for a specific file
git diff master brew -- ./FAQS.md 

# get the diff of a branch from the base where it was created
function branch-diff() {
    local ORIGIN=$1
    local BRANCH=$2
    local BRANCH_COMMIT=$(git log --pretty=format:"%H" -n 1 $ORIGIN$BRANCH) 
    local BRANCH_BASE_COMMIT=$(git merge-base $ORIGIN$BRANCH $ORIGIN$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5))
    #git diff $BRANCH_BASE_COMMIT..$BRANCH_COMMIT 
    git difftool --tool=vscode $BRANCH_BASE_COMMIT..$BRANCH_COMMIT 
}
branch-diff origin/ awsvpcs
branch-diff "" gitactivity
```

## Get the top commitid

```sh
# head on current branch
git rev-parse HEAD     

# head on current branch
git rev-parse $(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
```

## Show the staged diff

```sh
# diff head against staged
git diff --staged   
```

### Show missing commits between branches

```sh
# show commits missing between branches
git-missing master feat/testing  
```

## Show commits for current directory

```sh
# show commits containing entries for current directory
git log .
```
