#!/usr/bin/env bash 
#Use !/bin/bash -x  for debugging 
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034

if [ -n "${DEBUG_ENVIRONMENT-}" ];then 
    # if DEBUG_ENVIRONMENT is set
    env
    export
fi

function help() {
    cat <<- EOF
usage: $SCRIPT_NAME options

OPTIONS:
    -h --help -?               show this help
    -p --path                  base path of repos

    --include-commits          include the commit messages 

Examples:
    $SCRIPT_NAME --help 

EOF
}

REPOSITORY_PATH=""
INCLUDE_COMMITS=false
for i in "$@"
do
case $i in
    -h|--help)
        help
        exit 0
    ;; 
    -p=*|--path=*)
        REPOSITORY_PATH="${i#*=}"
        shift # past argument=value
    ;; 
    --include-commits)
        INCLUDE_COMMITS=true
    ;;      
esac
done   

if [[ "$REPOSITORY_PATH"  == "" ]]; then
    >&2 echo ""
    >&2 echo "ERROR: path is not specified"
    >&2 echo ""
    exit 1
fi

if [[ ! -d $REPOSITORY_PATH ]]; then
    >&2 echo ""
    >&2 echo "ERROR: '$REPOSITORY_PATH' is not a directory"
    >&2 echo ""
    exit 1
fi

pushd "$REPOSITORY_PATH" > /dev/null 
echo "Merged"
echo "------"
# loop over each branch
while IFS=, read -r __branch __commitid __relative
do
    # remove origin from front of branch
    __remote="${__branch/origin\//}" 
    if [[ $__remote != "HEAD" ]] && [[ $__remote != "master" ]] && [[ $__remote != "develop" ]]; then
        # find merge commits for branch 
        __log=$(git log --pretty=format:"%h %cr '%s'" --grep="Merge branch [']$__remote['] into")
        if [[ "$__log" != "" ]]; then
            echo "$__branch"
            #echo "[Merged] $__remote $__commitid $__relative"
            if [[ $INCLUDE_COMMITS == true ]]; then
                echo "[BRANCH HEAD]"
                echo $(git log --pretty=format:"%h %cr '%s'" -n 1 $__branch)
                echo ""
                echo "[MASTER LOG]"
                echo "$__log"
                echo ""
            fi

        #else 
            #echo "[Unmerged] $__remote"

        fi 
    fi
done < <(git for-each-ref --sort=committerdate refs/remotes/origin --format='%(refname:short), %(objectname:short), %(committerdate:relative)')


popd > /dev/null