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

##  Examining repos
```sh
# Files changed since yesterday on current branch.
git effort -- --since='yesterday'
```

##  Commit counts for master and PRs
```sh
# install sparklines shell script
brew install spark

# get prs and analyse commits 
./build_commits.sh ./ hours 
./build_commits.sh ./my-repo days

# data generator
./build_commits_histogram_data.sh --action=histogram 
./build_commits_histogram_data.sh --action=histogram --repo=./  
./build_commits_histogram_data.sh --action=histogram --repo=./ --sparkline 
```



# FAQ
How do I work with PRs on a repo from cli?
```sh
# turn off pager 
PAGER= 
# list PRs using github cli
gh pr list
# look at changes in PR. 
gh pr diff <id>
# you can edit the title of the pr
gh pr edit <id>
# merge to master
gh pr commit <id>
```

How do I look at the latest commit on each branch?
```sh
# latest commit on each branch.  
git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
```


# Resources

[git-extras](https://github.com/tj/git-extras/blob/master/Commands.md)  
[github cli](https://github.com/cli/cli)  
[sparklines](https://github.com/holman/spark)  

