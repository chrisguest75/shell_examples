# FAQ

#### How do I work with PRs on a repo from cli?
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

# latest commit on each branch.  
git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
```

#### How do I clean up my local branches?
```sh
git fetch --prune

# using git-extras 
git show-unmerged-branches   
git show-merged-branches     
git delete-merged-branches          
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

#### Checkout a file from another branch 
Can be used to undo file changes in a branch.
```sh
# Get the version of the file from origin/master
git checkout origin/master filename 
``` 


## Commits 

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
# diff changes 
git diff head..head~1         
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
# diff head agasint staged
git diff --staged   
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
