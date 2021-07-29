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
    -p --path                  path of repo
    -s --status                get repo status
    -f --fetch                 fetch from origin
    -d --diff                  show diff from default branch to origin
    -m --merge                 merge origin into default branch

Examples:
    # Output this help
    $SCRIPT_NAME --help 

    # Get data for repo
    $SCRIPT_NAME 

    # Iterating over directories
    find ../../ -max-depth 0 -type d -exec $SCRIPT_NAME {} \;

EOF
}

#****************************************************************************
#** Status
#** Get current sync status (readonly)
#****************************************************************************

function git_status() {
    pushd "$1" > /dev/null
    rootpath=$(pwd)
    default_branch=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
    current_branch=$(git branch --show-current)
    headcommit=$(git rev-parse $default_branch)    
    originheadcommit=$(git rev-parse origin/$default_branch)    
    on_default_branch=true
    [[ "$default_branch" == "$current_branch" ]] || on_default_branch=false
    reponame=$(basename $(git rev-parse --show-toplevel)) 
    modified=false
    [[ -z $(git status -s) ]] || modified=true
    # get fetch --dry-run writes everything to stderr
    unfetched_changes=false
    [[ -z $(git fetch --dry-run 2> >(awk '{print "stderr:" $0}') > >(awk '{print "stdout:" $0}')) ]] || unfetched_changes=true
    popd > /dev/null

    #echo "reponame=$reponame"
    #echo "default_branch=$default_branch"
    #echo "current_branch=$current_branch"
    #echo "on_default_branch=$on_default_branch"
    #echo "modified=$modified"
    jq --null-input \
        --arg rootpath "$rootpath" \
        --arg commit "$headcommit" \
        --arg origincommit "$originheadcommit" \
        --arg reponame "$reponame" \
        --arg default_branch "$default_branch" \
        --arg current_branch "$current_branch" \
        --arg on_default_branch "$on_default_branch" \
        --arg modified "$modified" \
        --arg unfetched_changes "$unfetched_changes" \
        '{rootpath: $rootpath, reponame: $reponame, default_branch: $default_branch, commit: $commit, origincommit: $origincommit, current_branch: $current_branch, on_default_branch: $on_default_branch, modified: $modified, unfetched_changes: $unfetched_changes}'
}

#****************************************************************************
#** Fetch
#** Fetch repository from origin
#****************************************************************************

function git_fetch() {
    pushd "$1" > /dev/null
    git fetch 
    popd > /dev/null
}

#****************************************************************************
#** Diff
#** Diff default branch repository from origin
#****************************************************************************

function git_diff() {
    pushd "$1" > /dev/null
    default_branch=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
    git diff ${default_branch}..origin/${default_branch} --compact-summary  
    popd > /dev/null
}

#****************************************************************************
#** Merge
#** Diff default branch repository from origin
#****************************************************************************

function git_merge() {
    pushd "$1" > /dev/null
    default_branch=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
    git merge origin/${default_branch} 
    popd > /dev/null
}

#****************************************************************************

ACTION_STATUS=false
ACTION_FETCH=false
ACTION_DIFF=false
ACTION_MERGE=false

REPOSITORY_PATH=""

for i in "$@"
do
case $i in
    -h|--help)
        help
        exit 0
    ;; 
    -s|--status)
        ACTION_STATUS=true
    ;;     
    -f|--fetch)
        ACTION_FETCH=true
    ;; 
    -d|--diff)
        ACTION_DIFF=true
    ;;   
    -m|--merge)
        ACTION_MERGE=true
    ;;            
    -p=*|--path=*)
        REPOSITORY_PATH="${i#*=}"
        shift # past argument=value
    ;;    
esac
done    

if [[ "$REPOSITORY_PATH"  == "" ]]; then
    >&2 echo "ERROR: path is not specified"
    echo ""
    help
    exit 1
fi

if [[ ! -d $REPOSITORY_PATH ]]; then
    >&2 echo "ERROR: '$REPOSITORY_PATH' is not a directory"
    echo ""
    help
    exit 1
fi
if [[ ! -d $REPOSITORY_PATH/.git ]]; then
    >&2 echo "WARNING: '$REPOSITORY_PATH/.git' does not exist"
    exit 1
fi

PERFORMED_ACTION=false
if [[ $ACTION_STATUS == true ]]; then
    git_status $REPOSITORY_PATH
    PERFORMED_ACTION=true
fi
if [[ $ACTION_FETCH == true ]]; then
    git_fetch $REPOSITORY_PATH
    PERFORMED_ACTION=true
fi
if [[ $ACTION_DIFF == true ]]; then
    git_diff $REPOSITORY_PATH
    PERFORMED_ACTION=true
fi
if [[ $ACTION_MERGE == true ]]; then
    git_merge $REPOSITORY_PATH
    PERFORMED_ACTION=true
fi
if [[ $PERFORMED_ACTION == false ]]; then
    echo "No action is specified"
fi
