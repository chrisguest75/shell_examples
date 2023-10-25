#!/usr/bin/env bash
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

function help() {
    cat <<- EOF
NAME
    $SCRIPT_NAME - Example of argument parsing

SYNOPSIS 
    $SCRIPT_NAME [options]

OPTIONS
    -h --help                show this help

EXAMPLES
    $SCRIPT_NAME --action=ps 

EOF
}

# if no variables are passed
if [ -z "$@" ]; then
    help
    exit 0
fi 

for i in "$@"
do
case $i in
    -h|--help)
        help
        exit 0
    ;; 
esac
done    

# do work here
ps -a

