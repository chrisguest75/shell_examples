#!/usr/bin/env bash 
set -euf -o pipefail

function error_exit() {
    echo "TRAPPED: Error exitcode"
    # you can overwrite the exit code.
    #exit 0
}

echo "** Demonstrates handling an error in a trap handler **"
trap error_exit ERR

#echo $COUNT
ls /directory_does_not_exist
