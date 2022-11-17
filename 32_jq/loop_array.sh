#!/usr/bin/env bash

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

readarray images < <(jq -r '.images[]' ./images.json)
echo "${images[1]}"

for image in "${images[@]}"; 
do
    image=$(trim $image)
    echo "image=$image|"
done

