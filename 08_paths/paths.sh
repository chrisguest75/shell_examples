#!/usr/bin/env bash
set -euf -o pipefail

function add_trailing_slash() {
    : ${1?"${FUNCNAME[0]}(path) - missing path argument"}

    if [[ -z ${1} ]]; then 
        #echo "${FUNCNAME[0]}(path) - path is empty" && exit 1
        echo ""
        return
    fi
    # remove an existing slash and add new one.
    echo "${1%/}/"
}

readonly WORKING_PATH=$(pwd)
readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
readonly HOME_DIR=~
if [[ $(command -v greadlink) ]]; then 
    # mac requires 'brew install coreutils'
    readonly SCRIPT_FULL_PATH="$(dirname "$(greadlink -f "$0")")/${SCRIPT_NAME}"
else
    readonly SCRIPT_FULL_PATH="$(dirname "$(readlink -f "$0")")/${SCRIPT_NAME}"
fi 

echo "WORKING_PATH=${WORKING_PATH}"
echo "SCRIPT_NAME=${SCRIPT_NAME}"
echo "SCRIPT_PATH=${SCRIPT_PATH}"
echo "SCRIPT_DIR=${SCRIPT_DIR}"
echo "HOME_DIR=${HOME_DIR}"
echo "SCRIPT_FULL_PATH=${SCRIPT_FULL_PATH}"

readonly PARAMETER1=${1-}
echo "PARAMETER1=${PARAMETER1} LENGTH=${#PARAMETER1}"

echo "add_trailing_slash(\"this/is/my/path\") returns \"$(add_trailing_slash "this/is/my/path")\""
echo "add_trailing_slash(\"this/is/my/path/\") returns \"$(add_trailing_slash "this/is/my/path/")\""
echo "add_trailing_slash(\"\") returns \"$(add_trailing_slash "")\""

echo "End of script"

