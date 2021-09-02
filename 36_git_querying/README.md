# README
Demonstrates some examples of using git queries

TODO:
* Gitlab cli [glab](https://glab.readthedocs.io/en/latest/) [glab source](https://github.com/profclems/glab)

## Files
* FAQS - [here](./FAQS.md)  
* Squashing Walkthrough - [here](./SQUASHING_WALKTHROUGHS.md)  


## Git Extras
Git extras are a set of helpers for git.

MacOS  
```sh
# macosx extras and gh cli
brew install git-extras

# github cli
brew install gh

# gitlab cli
brew install glab  
```

Linux  
[brew.sh](https://docs.brew.sh) required for gh on ubuntu/debian [linuxbrew](https://docs.brew.sh/Homebrew-on-Linux)   
```sh
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
## Command for brew example
Brew example [here](../49_brew/README.md)
```sh
# hides the find command in a script.
./git-activity.sh --path=../../../../Code/scratch
```

## Commit counts for master and PRs
```sh
# install sparklines shell script
brew install spark

# get prs and analyse commits 
./build_commits.sh --path=./ --hours 
./build_commits.sh --path=./my-repo --days --json

# iterate over repositories
find ../../../code -maxdepth 1 -type d -exec ./build_commits.sh --path={} --ignore-errors --days \;

find ../../../code -maxdepth 1 -type d -exec ./build_commits.sh --path={} --days --json \;                                                
find ../../../code -maxdepth 1 -type d -exec ./build_commits.sh --path={} --days --json \; | jq -s . > ./out/branch_activity.json  

# data generator
./build_commits_histogram_data.sh --action=histogram 
./build_commits_histogram_data.sh --action=histogram --repo=./  

# output sparkline
./build_commits_histogram_data.sh --action=histogram --repo=./ --sparkline | spark
```

## Git repo sync
Split into two parts the first is the all up run it and update all repos that can be merged without conflict.

```sh
# will only merge repos that have no local edits.
./git_refresh_all_repos.sh -p=../../../code --merge 
```

This is how it works step-by-step.
```sh
# out folder
mkdir -p ./out

./git_sync_status.sh --path=../../../code/my-repo --status   
./git_sync_status.sh --path=../../../code/my-repo --fetch
./git_sync_status.sh --path=../../../code/my-repo --diff 
./git_sync_status.sh --path=../../../code/my-repo --merge

# get repo status (sort so we can diff)
find ../../../code -maxdepth 1 -type d -exec ./git_sync_status.sh --path={} --status \; | jq -s '. | sort_by(.reponame)' > ./out/my_repos.json

# show repos on default branch, unmodifiied with unfetched_changes 
jq -r '.[] | select(.on_default_branch == "true" and .modified == "false" and .unfetched_changes == "true")' ./out/my_repos.json

# show repos on default branch, unmodifiied that are up-to-date 
jq -r '.[] | select(.on_default_branch == "true" and .modified == "false" and .unfetched_changes == "false" and .commit == .origincommit)' ./out/my_repos.json

# show repos not on default branch
jq -r '.[] | select(.on_default_branch == "false")' ./out/my_repos.json

# show repos where origin commit for default branch does not match head commit for default branch
jq -r '.[] | select(.commit != .origincommit)' ./out/my_repos.json

# sync repos that can be safely synced (note: ./out/my_repos.json needs to be  up-to-date)
# output fields as env vars
while IFS=" ", read -r rootpath reponame default_branch commit origincommit current_branch on_default_branch modified unfetched_changes
do
    echo "reponame=$reponame, unfetched_changes=$unfetched_changes, on_default_branch=$on_default_branch, modified=$modified"
    ./git_sync_status.sh --path=${rootpath} --status
    ./git_sync_status.sh --path=${rootpath} --fetch
    ./git_sync_status.sh --path=${rootpath} --diff 
    ./git_sync_status.sh --path=${rootpath} --status
done < <(jq -c -r '.[] | select(.on_default_branch == "true" and .modified == "false" and .unfetched_changes == "true") | "\(.rootpath) \(.reponame) \(.default_branch) \(.commit) \(.origincommit) \(.current_branch) \(.on_default_branch) \(.modified) \(.unfetched_changes)"' ./out/my_repos.json)

# merge the changes on default branch with no changes
while IFS=" ", read -r rootpath reponame default_branch commit origincommit current_branch on_default_branch modified unfetched_changes
do
    echo "reponame=$reponame, unfetched_changes=$unfetched_changes, on_default_branch=$on_default_branch, modified=$modified, commit=$commit, origincommit=$origincommit"
    ./git_sync_status.sh --path=${rootpath} --status
    ./git_sync_status.sh --path=${rootpath} --merge
    ./git_sync_status.sh --path=${rootpath} --status
done < <(jq -c -r '.[] | select(.on_default_branch == "true" and .modified == "false" and .unfetched_changes == "false" and .commit != .origincommit) | "\(.rootpath) \(.reponame) \(.default_branch) \(.commit) \(.origincommit) \(.current_branch) \(.on_default_branch) \(.modified) \(.unfetched_changes)"' ./out/my_repos.json)

```
#### Check tag format
```sh
git check-ref-format "tags/0.0.1-a39f8a821fc9" 
```

# Resources

* [git-extras](https://github.com/tj/git-extras/blob/master/Commands.md) are a really good set of useful supplementary commands.    
* [github cli](https://github.com/cli/cli) tool that supports creating PRs directly from the shell  
* [sparklines](https://github.com/holman/spark)  

