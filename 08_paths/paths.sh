#!/usr/bin/env bash
set -euf -o pipefail

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