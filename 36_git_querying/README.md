# README
Demonstrates some examples of using git queries

TODO:
* Use the github api to query PR https://cli.github.com/manual/gh_api
* Iterate over PRs to get the data
* Walkthrough GH commands - commit PR through the cmdline only. 

## Git Extras
Git extras are a set of helpers for git
```sh
# macosx
brew install git-extras

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

# data generator
./build_commits_histogram_data.sh --action=histogram 
./build_commits_histogram_data.sh --action=histogram --repo=./  
./build_commits_histogram_data.sh --action=histogram --repo=./ --sparkline 
```







# Resources

[git-extras](https://github.com/tj/git-extras/blob/master/Commands.md)

