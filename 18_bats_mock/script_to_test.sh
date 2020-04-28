#!/usr/bin/env bash

function filter() {
    if [[ -n $1 ]];then
        #git log --oneline | grep "$1"
        git log --oneline 
    else
        echo "Usage: script_to_test.sh <filter>"
        exit 1
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
    filter "$1"
    exit 0
else
    echo "Script is being sourced"
fi

