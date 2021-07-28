#!/usr/bin/env bash
set -ef -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

function help() {
    cat <<- EOF
usage: $SCRIPT_NAME <git repo path> options

OPTIONS:
    -h --help -?               show this help
    -s --sync -?               sync

Examples:
    # Output this help
    $SCRIPT_NAME --help 

    # Get data for repo
    $SCRIPT_NAME ./myrepo

    # Iterating over directories
    find ../../ -max-depth 0 -type d -exec $SCRIPT_NAME {} \;

EOF
}

for i in "$@"
do
case $i in
    -h|--help)
        help
        exit 0
    ;; 
esac
done    

if [[ ! -d $1 ]]; then
    >&2 echo "ERROR: '$1' is not a directory"
    help
    exit 1
fi
if [[ ! -d $1/.git ]]; then
    >&2 echo "WARNING: '$1/.git' does not exist"
    exit 1
fi

pushd "$1" > /dev/null
rootpath=$(pwd)
default_branch=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
current_branch=$(git branch --show-current)
on_default_branch=true
[[ "$default_branch" == "$current_branch" ]] || on_default_branch=false
reponame=$(basename $(git rev-parse --show-toplevel)) 
modified=false
[[ -z $(git status -s) ]] || modified=true
unfetched_changes=false
#[[ -z $(git fetch --dry-run) ]] || unfetched_changes=true
popd > /dev/null

#echo "reponame=$reponame"
#echo "default_branch=$default_branch"
#echo "current_branch=$current_branch"
#echo "on_default_branch=$on_default_branch"
#echo "modified=$modified"
jq --null-input \
    --arg rootpath "$rootpath" \
    --arg reponame "$reponame" \
    --arg default_branch "$default_branch" \
    --arg current_branch "$current_branch" \
    --arg on_default_branch "$on_default_branch" \
    --arg modified "$modified" \
    --arg unfetched_changes "$unfetched_changes" \
    '{rootpath: $rootpath, reponame: $reponame, default_branch: $default_branch, current_branch: $current_branch, on_default_branch: $on_default_branch, modified: $modified, unfetched_changes: $unfetched_changes}'

