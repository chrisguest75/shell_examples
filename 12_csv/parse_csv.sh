#!/usr/bin/env bash
set -euf -o pipefail

function trim() {
    : ${1?"${FUNCNAME[0]}(string) - missing string argument"}

    if [[ -z ${1} ]]; then 
        echo ""
        return
    fi
    # remove an 
    trimmed=${1##*( )}
    echo ${trimmed%%*( )}
}

trim "  hello  "
trim "hello   "
trim "   hello"
trim " "
trim "  hello world  "
trim ""

while IFS=, read -r rev1 rev2 version
do
    echo "$(trim $version) is between $(trim $rev1) and $(trim $rev2)"
done < ranges.csv

