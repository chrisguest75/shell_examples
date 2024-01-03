# BRANCHES

NOTES:

* Merging in Git creates a special commit that has two unique parents. A commit with two parents essentially means "I want to include all the work from this parent over here and this one over here, and the set of all their parents."

## How do I look at the latest commit on each branch?

```sh
# latest commit on each branch.  
git branch -vvv -a

# latest commit on each branch 'refs/heads/'.  
git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'

# latest commit on remote branches 'refs/remotes/origin'.
git for-each-ref --sort=committerdate refs/remotes/origin --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
```

## How do I clean up my local branches?

```sh
git fetch --prune

# using git-extras 
git show-unmerged-branches   
git show-merged-branches     
git delete-merged-branches  

# show merged branches (gets confused if squash commits have been done on web).
git branch -r -vvv --merged origin/master   
# and unmerged
git branch -r -vvv --no-merged origin/master   

# delete a local and a remote branch (git-extras)
git delete-branch <branch>
```

## Keeping branches up-to-date

```sh
# have a look at the differences
git log -n 10 --graph --oneline master
git log -n 10 --graph --oneline <branch>
git diff master..<branch> --name-only

# rebase the branch
git rebase master
```

## Find common ancestor between branches

```sh
# get a common ancestor commitid
git merge-base mybranch master
```

## Show changes in staged

```sh
git diff --cached 
```

## Changes to a branch since creation

```sh
# files changed from master in the current branch
git diff $(git merge-base $(git branch --show-current) master)..head --name-only
```

## View a file from another branch

```sh
# show a file in a branch
git show origin/branchname:path/README.md  
```

## Checkout a file from another branch

Use to undo single file changes in a branch.

```sh
# Get the version of the file from origin/master
git checkout origin/master filename 

# revert directory back to state of common ancestor
git checkout $(git merge-base $(git branch --show-current) master) -- <directory>

# get a file from another branch (cherry-pick a single file)
git restore --source brew -- FAQS.md 
# or 
git checkout -m <branchname> ./package-lock.json
```

### Cherry pick a commit into staged "Reverting a revert"  

This might need to be done if you made a change that was reverted and you want to recall and work with it again.  

```sh
# create new branch
git checkout -b retry-broken-code

# take the commit of the original changes. 
git cherry-pick --no-commit abcde29877733c861aad625f567b7455838 -m 1       
```

## Origins

### Git switch origin

This is useful after syncing a repo with `https` rather than `ssh`

```sh
git remote show origin
# add a new origin
git remote add originssh git@github.com:chrisguest75/default_dotfiles.git
# push local changes up to it to test it is configured correctly
git push originssh
git remote
# remove old origin
git remote remove origin
git remote rename originssh origin
git remote
git remote show origin
```
