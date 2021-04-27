# README
Demonstrates some examples of using git queries

TODO:
* Use the github api to query PR https://cli.github.com/manual/gh_api
* Iterate over PRs to get the data

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


./build_commits_histogram_data.sh --action=histogram 
./build_commits_histogram_data.sh --action=histogram --repo=./  
./build_commits_histogram_data.sh --action=histogram --repo=./ --sparkline 
```







# Resources

[git-extras](https://github.com/tj/git-extras/blob/master/Commands.md)

