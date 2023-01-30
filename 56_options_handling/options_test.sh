#!/usr/bin/env bash
#set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

function help() {
    cat <<- EOF
usage: $SCRIPT_NAME options

OPTIONS:
    -h --help -?               show this help
    -s --show -?               show options that are set

Examples:
    $SCRIPT_NAME --help 

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
    -s|--show)
        echo "**********************************************"
        echo "* ALL"
        echo "**********************************************"
        shopt
        echo "**********************************************"
        echo "* ON"
        echo "**********************************************"
        shopt | grep "on$"
    ;; 
esac
done    


