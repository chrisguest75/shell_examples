#!/usr/bin/env bash
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

function help() {
    cat <<- EOF
NAME
    $SCRIPT_NAME - Script reads a three column csv file and converts it to json

SYNOPSIS 
    $SCRIPT_NAME [options]

OPTIONS
    -h --help                show this help

EXAMPLES
    cat file.csv | $SCRIPT_NAME 

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

# slurp the documents 1 by 1.
while IFS=, read -r name account role
do
    if [[ -z "$name" ]]; then
        break
    fi
    jq --null-input --arg name "$name" --arg account "$account" --arg role "$role" 'def trim($value): $value | match("([ ]*)(.*)").captures[1].string | match("([^ ]*)([ ]*)").captures[0].string;. + {name: $name | trim(.), account:  $account | trim(.), role: $role | trim(.)}' 

done | jq -s . 

