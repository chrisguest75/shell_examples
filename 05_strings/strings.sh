#!/usr/bin/env bash
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
readonly HOME_DIR=~
if [[ $(command -v greadlink) ]]; then 
    # mac requires 'brew install coreutils'
    readonly SCRIPT_FULL_PATH="$(dirname "$(greadlink -f "$0")")"
else
    readonly SCRIPT_FULL_PATH="$(dirname "$(readlink -f "$0")")"
fi 

echo "SCRIPT_NAME=${SCRIPT_NAME}"
echo "SCRIPT_PATH=${SCRIPT_PATH}"
echo "SCRIPT_DIR=${SCRIPT_DIR}"
echo "HOME_DIR=${HOME_DIR}"
echo "SCRIPT_FULL_PATH=${SCRIPT_FULL_PATH}"

# **********************************************
# default if not set ${name-default}
# **********************************************
readonly PARAMETER1=${1-default1}
echo "PARAMETER1=${PARAMETER1} LENGTH=${#PARAMETER1}"

readonly PARAMETER2=${2-default2}
echo "PARAMETER2=${PARAMETER2} LENGTH=${#PARAMETER2}"

# **********************************************
# substring matching
# **********************************************

if [[ ${PARAMETER1} == hello* ]];then
    echo "PARAMETER1 starts with 'hello'"    
else
    echo "PARAMETER1 does not start with 'hello'"    
fi

# **********************************************
# padding 
# **********************************************

PAD_SIZE=60
printf -v EMPTY_PAD %${PAD_SIZE}s
OUT=$PARAMETER1${EMPTY_PAD}
OUT=${OUT:0:$PAD_SIZE}
echo "*$OUT*"