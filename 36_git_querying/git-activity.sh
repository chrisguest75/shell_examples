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

if [[ $(command -v "greadlink") ]]; then
    readonly SCRIPT_DIR=$(greadlink -f $(dirname "$SCRIPT_PATH"))
elif [[ $(command -v "readlink") ]]; then
    readonly SCRIPT_DIR=$(readlink -f $(dirname "$SCRIPT_PATH"))
else
    echo "Cannot find readlink or greadlink"
    exit 1
fi
if [[ ! $(command -v "spark") ]]; then
    echo "Cannot find spark"
    exit 1
fi

function help() {
    cat <<- EOF
usage: $SCRIPT_NAME options

OPTIONS:
    -h --help -?               show this help
    -p --path                  base path of repos

    --json                     output as json
    --days                     aggregate as days
    --hours                    aggregate as hours

    --ignore-errors            ignore errors from 
Examples:
    $SCRIPT_NAME --help 

EOF
}

ACTION_JSON=false
ACTION_HOURS=false
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
    --json)
        ACTION_JSON=true
    ;; 
    --hours)
        ACTION_HOURS=true
    ;;   
    --days)
        ACTION_HOURS=false
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

MODE=--days
if [[ $ACTION_HOURS == true ]]; then
    MODE=--hours    
fi

find $REPOSITORY_PATH -maxdepth 1 -type d -exec ${SCRIPT_DIR}/build_commits.sh --path={} --ignore-errors ${MODE} \;

