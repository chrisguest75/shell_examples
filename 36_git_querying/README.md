# README
Demonstrates some examples of using git queries

TODO:
* Use the github api to query PR https://cli.github.com/manual/gh_api

## Git Extras
Git extras are a set of helpers for git
```sh
# macosx
brew install git-extras
brew install gh

# debian
apt install git-extras
```

## Open repo in code
```sh
# sometimes you might be in a subdirectory in the repo
code $(git root)
```

## Examining repos
```sh
# Files changed since yesterday on current branch.
git effort -- --since='yesterday'
git effort -- --since='1 month ago'
```

## Commit counts for master and PRs
```sh
# install sparklines shell script
brew install spark

# get prs and analyse commits 
./build_commits.sh ./ hours 
./build_commits.sh ./my-repo days

# data generator
./build_commits_histogram_data.sh --action=histogram 
./build_commits_histogram_data.sh --action=histogram --repo=./  

# output sparkline
./build_commits_histogram_data.sh --action=histogram --repo=./ --sparkline | spark
```

## Git repo sync

```sh
# out folder
mkdir -p ./out

./git_sync_status.sh --path=../../../code/my-repo --status   
./git_sync_status.sh --path=../../../code/my-repo --fetch
./git_sync_status.sh --path=../../../code/my-repo --diff 

# get repo status (sort so we can diff)
find ../../../conde -maxdepth 1 -type d -exec ./git_sync_status.sh --path={} --status \; | jq -s '. | sort_by(.reponame)' > ./out/my_repos.json

# show all up to date repos

# show repos on default branch, unmodifiied with unfetched_changes 
jq -r '.[] | select(.on_default_branch == "true" and .modified == "false" and .unfetched_changes == "true")' ./out/my_repos.json

# show repos on default branch, unmodifiied that  are up-to-date 
jq -r '.[] | select(.on_default_branch == "true" and .modified == "false" and .unfetched_changes == "false")' ./out/my_repos.json

# show repos where origin commit for default branch does not match head commit for default branch
jq -r '.[] | select(.commit != .origincommit)' ./out/my_repos.json

# sync repos that can be safely synced






```

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

#### How do I look at the latest commit on each branch?
```sh
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

#### How do I know what changes were in a commit?
```sh
# show last 4 commits on a branch
git log -n 4 --oneline <branch>

# choose a commit and list files
git show <commitid> --name-only --oneline            
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

# Resources

* [git-extras](https://github.com/tj/git-extras/blob/master/Commands.md) are a really good set of useful supplementary commands.    
* [github cli](https://github.com/cli/cli) tool that supports creating PRs directly from the shell  
* [sparklines](https://github.com/holman/spark)  

