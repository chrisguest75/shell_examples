#!/usr/bin/env bash

function filter() {
    if [[ -n $1 ]];then
        git log --oneline | grep "$1"
    else
        echo "Usage: script_to_test.sh <filter>"
        exit 1
    fi
}
filter "$1"
exit 0