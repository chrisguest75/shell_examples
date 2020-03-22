#!/usr/bin/env bash 
set -euf -o pipefail

function error_exit() {
    echo "Error exitcode"
    # you can overwrite the exit code.
    #exit 0
}

trap error_exit ERR

#echo $COUNT
ls /directory_does_not_exist
