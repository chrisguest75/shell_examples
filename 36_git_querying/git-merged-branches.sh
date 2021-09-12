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

    --ignore-errors            ignore errors from 
Examples:
    $SCRIPT_NAME --help 

EOF
}

IGNORE_ERRORS=false
REPOSITORY_PATH=""

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
    --ignore-errors)
        IGNORE_ERRORS=true
    ;;       
esac
done   

if [[ "$REPOSITORY_PATH"  == "" ]]; then
    if [[ $IGNORE_ERRORS == false ]]; then
        >&2 echo ""
        >&2 echo "ERROR: path is not specified"
        >&2 echo ""
    fi
    exit 1
fi

if [[ ! -d $REPOSITORY_PATH ]]; then
    if [[ $IGNORE_ERRORS == false ]]; then
        >&2 echo ""
        >&2 echo "ERROR: '$REPOSITORY_PATH' is not a directory"
        >&2 echo ""
    fi
    exit 1
fi

pushd "$REPOSITORY_PATH" > /dev/null 
echo "Merged"
echo "------"
while IFS=, read -r __branch __commitid __relative
do
    __remote="${__branch/origin\//}" 
    if [[ $__remote != "HEAD" ]] && [[ $__remote != "master" ]] && [[ $__remote != "develop" ]]; then
        __log=$(git log --oneline --grep="Merge branch [']$__remote['] into")
        if [[ "$__log" != "" ]]; then
            echo "$__branch"
            #echo "[Merged] $__remote $__commitid $__relative"
            #echo "$__log"
            #echo ""

        #else 
            #echo "[Unmerged] $__remote"

        fi 
    fi
done < <(git for-each-ref --sort=committerdate refs/remotes/origin --format='%(refname:short), %(objectname:short), %(committerdate:relative)')


popd > /dev/null