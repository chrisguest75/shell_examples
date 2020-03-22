#!/usr/bin/env bash 
set -euf -o pipefail

ctrlc_counter=0
function ctrlc_script() {
    if [[ $ctrlc_counter == 0 ]]; then
        (( ctrlc_counter++ ))
        echo "CTRL+C $ctrlc_counter"
    elif [[ $ctrlc_counter == 1 ]]; then
        (( ctrlc_counter++ ))
        echo "CTRL+C $ctrlc_counter"
    else
        echo "CTRL+C exiting - $ctrlc_counter"
        exit
    fi
}

trap ctrlc_script INT

for argument in $(seq 5 3 20); do 
    echo "$argument"; 
    sleep 10
done