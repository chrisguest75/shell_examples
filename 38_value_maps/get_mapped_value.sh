#!/usr/bin/env bash
set -ef -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

(return 0 2>/dev/null) && SOURCED=1 || SOURCED=0
if [[ $SOURCED == 1 ]]; then
  #echo "Script is being sourced"
  return 1
  #else
  #echo "Script is a subshell"
fi

STRING_TO_FIND=""
# Using ${1-} means if we don't set $1 it doesn't fail with unbound variable
if [[ -n ${1-} ]]; then
  STRING_TO_FIND=$1
else
  echo "No account provided. '$SCRIPT_NAME <account> <optional mapfile>'"
  exit 1
fi

#MAP_FILE="map.conf"
if [[ -n ${2-} ]]; then
  MAP_FILE=$2
fi
if [[ -z ${MAP_FILE-} ]]; then
  echo "No MAP_FILE envvar provided or '$SCRIPT_NAME <account> <optional mapfile>'"
  exit 1
fi

function trim() {
    : ${1?"${FUNCNAME[0]}(string) - missing string argument"}

    if [[ -z ${1} ]]; then 
        echo ""
        return
    fi
    # remove an 
    local trimmed=${1##*( )}
    echo ${trimmed%%*( )}
}

EXITCODE=1
while IFS=, read -r name account role
do
    name=$(trim "$name")
    role=$(trim "$role")
    account=$(trim "$account")
    if [[ "$name" == "$STRING_TO_FIND" ]]; then
        echo "$role"
        EXITCODE=0
    fi
done < ${MAP_FILE}

exit ${EXITCODE}