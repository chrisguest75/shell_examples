#!/usr/bin/env bash 
set -euf -o pipefail

function ctrlc_script() {
    echo "CTRL+C exiting"
    exit
}

trap ctrlc_script INT

for argument in $(seq 5 3 20); do 
    echo "$argument"; 
    sleep 10
done