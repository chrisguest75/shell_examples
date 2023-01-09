# README

Example helper scripts.

TODO:

* All these need testing again and also the brew example.  

## Command for brew example

Brew example [here](../../49_brew/README.md)

```sh
# hides the find command in a script.
./helpers/git-activity.sh --path="$(git root)/../"
```

## Detect merged branches

If you use github web to squash and merge.  It seems to make it difficult to determine if the branch was merged or not using `--merged`.  

```sh
# uses git log to try and determine if branch was merged at some point
./helpers/git-merged-branches.sh --path="$(git root)"

# or give option to delete merged branches (git-extras)
./helpers/git-merged-branches.sh --path="$(git root)" --include-commits --delete-branches
```

## Commit counts for master and PRs

```sh
# install sparklines shell script
brew install spark

# get prs and analyse commits 
./helpers/build_commits.sh --path="$(git root)" --hours 
./helpers/build_commits.sh --path="$(git root)" --days --json

# iterate over repositories
find ../../../code -maxdepth 1 -type d -exec ./build_commits.sh --path={} --ignore-errors --days \;

find ../../../code -maxdepth 1 -type d -exec ./build_commits.sh --path={} --days --json \;
find ../../../code -maxdepth 1 -type d -exec ./build_commits.sh --path={} --days --json \; | jq -s . > ./out/branch_activity.json  

# data generator
./helpers/build_commits_histogram_data.sh --action=histogram 
./helpers/build_commits_histogram_data.sh --action=histogram --repo="$(git root)"

# output sparkline
./helpers/build_commits_histogram_data.sh --action=histogram --repo=./ --sparkline | spark
```

## Git repo sync

Split into two parts the first is the all up run it and update all repos that can be merged without conflict.

```sh
# will only merge repos that have no local edits.
./helpers/git_refresh_all_repos.sh -p="$(git root)/../" --merge 
```

This is how it works step-by-step.

```sh
# out folder
mkdir -p ./out

./helpers/git_sync_status.sh --path="$(git root)" --status   
./helpers/git_sync_status.sh --path="$(git root)" --fetch
./helpers/git_sync_status.sh --path="$(git root)" --diff 
./helpers/git_sync_status.sh --path="$(git root)" --merge

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

## Resources

* [sparklines](https://github.com/holman/spark)  
