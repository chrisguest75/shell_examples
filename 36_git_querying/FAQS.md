# FAQ
A set of example uses of git.  

## Git Clis
Github and Gitlab both have cli tooling for working with PR/MR and issues, etc.  

#### How do I work with PRs on a repo from cli?
Using the github cli command.  

```sh
# turn off pager 
PAGER= 

# list PRs using github cli
gh pr list

# create a draft pr
gh pr create --draft

# look at changes in PR. 
gh pr diff <id>

# you can edit the title of the pr
gh pr edit <id>

# promote a draft pr to ready
gh pr ready <id>

# merge to master
gh pr commit <id>
gh pr merge <id>
```

## Branches

#### How do I look at the latest commit on each branch?

```sh
# latest commit on each branch.  
git branch -vvv -a

# latest commit on each branch 'refs/heads/'.  
git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'

# latest commit on remote branches 'refs/remotes/origin'.
git for-each-ref --sort=committerdate refs/remotes/origin --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
```

#### How do I clean up my local branches?
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

#### Keeping branches up-to-date
```sh
# have a look at the differences
git log -n 10 --graph --oneline master
git log -n 10 --graph --oneline <branch>
git diff master..<branch> --name-only

# rebase the branch
git rebase master
```

#### Find common ancestor between branches
```sh
# get a common ancestor commitid
git merge-base mybranch master
```

#### Changes to a branch since creation
```sh
# files changed from master in the current branch
git diff $(git merge-base $(git branch --show-current) master)..head --name-only
```

#### Checkout a file from another branch 
Can be used to undo file changes in a branch.
```sh
# Get the version of the file from origin/master
git checkout origin/master filename 

# revert directory back to state of common ancestor
git checkout $(git merge-base $(git branch --show-current) master) -- <directory>

# get a file from another branch
git restore --source brew -- FAQS.md 
``` 


## Commits 

```sh
git show head --name-only
git show master~4 --name-only
git show master^1 --name-only
```

#### How do I know what changes were in a commit?
```sh
# show last 4 commits on a branch
git log -n 4 --oneline <branch>

# choose a commit and list files
git show <commitid> --name-only --oneline            
```

#### Rollback the last commit
```sh
# pop the last commit off and move the changed files into staging
git reset head~1         
```

#### Diff between two commits
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

#### Get the top commitid
```sh
# head on current branch
git rev-parse HEAD     

# head on current branch
git rev-parse $(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
```

#### Show the staged diff
```sh
# diff head against staged
git diff --staged   
```

#### Show missing commits between branches
```sh
# show commits missing between branches
git-missing master feat/testing  
```

## Origins
#### Git switch origin
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
