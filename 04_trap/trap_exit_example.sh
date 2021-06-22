#!/usr/bin/env bash 
set -euf -o pipefail

function exit_script() {
    echo "TRAPPED: exit_script"
    # you can overwrite the exit code.
    #exit 0
}

echo "** Demonstrates trap handler on exit **"
trap exit_script EXIT

for argument in $(seq 5 3 20); do 
    echo "$argument"; 
done