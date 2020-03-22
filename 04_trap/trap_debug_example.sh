#!/usr/bin/env bash 
set -eufx -o pipefail

function debug_script {
    set +x && echo "debug_script" && set -x
    # you can overwrite the exit code.
    #exit 0
}

trap debug_script DEBUG

for argument in $(seq 5 3 20); do
    echo "$argument"; 
done