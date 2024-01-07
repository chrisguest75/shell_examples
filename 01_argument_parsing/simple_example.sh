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
    -a --action              [anything]

EXAMPLES
    $SCRIPT_NAME --action=ps

EOF
}

# if no variables are passed
if [ -z "$@" ]; then
    help
    exit 0
fi

ACTION=""
for i in "$@"
do
case $i in
    -h|--help)
        help
        exit 0
    ;;
    -a=*|--action=*)
      ACTION="${i#*=}"
      shift # past argument=value
    ;;
esac
done

if [[ -z ${ACTION} ]]; then
    echo "Action is empty" && exit 1
else
  echo "Action is ${ACTION}"
  # do work here
  ps -a
fi

