#!/usr/bin/env bash 
#Use !/bin/bash -x  for debugging 
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034

if [ -n "${DEBUG_ENVIRONMENT-}" ];then 
    # if DEBUG_ENVIRONMENT is set
    env
    export
fi

if [[ $(command -v "greadlink") ]]; then
    readonly SCRIPT_DIR=$(greadlink -f $(dirname "$SCRIPT_PATH"))
elif [[ $(command -v "readlink") ]]; then
    readonly SCRIPT_DIR=$(readlink -f $(dirname "$SCRIPT_PATH"))
else
    echo "Cannot find readlink or greadlink"
    exit 1
fi
if [[ ! $(command -v "spark") ]]; then
    echo "Cannot find spark"
    exit 1
fi

echo $SCRIPT_DIR
pushd "$1" > /dev/null
MODE=
if [[ "$2" == "hours" ]]; then
    MODE=--hours    
fi

max=
longest=
pr_branches=()
while IFS= read -r line; do
    if [[ $line == renovate* ]]; then
        # skip renovate
        # pr_branches+=( "$line" )
        skip=true
    else
        pr_branches+=( "origin/$line" )
    fi
    (( ${#line} > max )) && max=${#line} && longest="$line"
done < <(gh pr list --json headRefName | jq -r ".[].headRefName")

#echo "$max, $longest"

REPO=./ 
BRANCH=master
LINE=$(echo -e "${BRANCH}:\t $($SCRIPT_DIR/build_commits_histogram_data.sh --action=histogram ${MODE} --repo=${REPO} --branch=${BRANCH} --sparkline | spark)") 
echo "$LINE" | expand -t $((max + 10)),100 

for BRANCHNAME in "${pr_branches[@]}"
do
    BASEBRANCH=master
    BRANCH=$BRANCHNAME
    #echo "$BASEBRANCH -> $BRANCH"
    LINE=$(echo -e "${BRANCH}:\t $($SCRIPT_DIR/build_commits_histogram_data.sh --action=histogram ${MODE} --repo=${REPO} --basebranch=${BASEBRANCH} --branch=${BRANCH} --sparkline | spark)") 
    echo "$LINE" | expand -t $((max + 10)),100 
done


popd > /dev/null

