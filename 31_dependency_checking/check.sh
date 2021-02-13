#!/usr/bin/env bash 
#Use !/bin/bash -x  for debugging 
#set -euf -o pipefail
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(realpath $(dirname "$SCRIPT_PATH"))

if [ -n "${DEBUG_ENVIRONMENT-}" ];then 
    # if DEBUG_ENVIRONMENT is set
    env
    export
fi

function check_prerequisites() {
    local dependency=$1

    # check code exists
    if [[ ! $(command -v "$dependency") ]]; then
        echo "$dependency is not-installed"
        exit 0
    fi
}

# pass in a list here.
# checking versions?
check_prerequisites "whiptail"