#!/usr/bin/env bash 
set -euf -o pipefail

function exit_script() {
    echo "exit_script"
    # you can overwrite the exit code.
    #exit 0
}

trap exit_script EXIT

for argument in $(seq 5 3 20); do 
    echo "$argument"; 
done