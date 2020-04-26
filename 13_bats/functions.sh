#!/usr/bin/env bash

function add_trailing_slash() {
    : "${1?\"${FUNCNAME[0]}(path) - missing path argument\"}"

    if [[ -z ${1} ]]; then 
        #echo "${FUNCNAME[0]}(path) - path is empty" && exit 1
        echo ""
        return
    fi
    # remove an existing slash and add new one.
    echo "${1%/}/"
}

function trim() {
    : "${1?\"${FUNCNAME[0]}(string) - missing string argument\"}"

    if [[ -z ${1} ]]; then 
        echo ""
        return
    fi
    # remove an 
    #cat $1 | xargs
    trimmed=${1##*( )}
    # shellcheck disable=SC2086
    echo ${trimmed%%*( )}
}

