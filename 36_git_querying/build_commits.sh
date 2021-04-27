#!/usr/bin/env bash 
#Use !/bin/bash -x  for debugging 
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(greadlink -f $(dirname "$SCRIPT_PATH"))

echo $SCRIPT_DIR
pushd "$1" > /dev/null

max=
longest=
pr_branches=()
tabs=$max  
while IFS= read -r line; do
    pr_branches+=( "$line" )
    (( ${#line} > max )) && max=${#line} && longest="$line"
done < <(gh pr list --json headRefName | jq -r ".[].headRefName")

echo "$max, $longest"

REPO=./ 
BRANCH=master
echo -e "${BRANCH}:\t $($SCRIPT_DIR/build_commits_histogram_data.sh --action=histogram --repo=${REPO} --branch=${BRANCH} --sparkline | spark)" 

for BRANCHNAME in "${pr_branches[@]}"
do
    BASEBRANCH=master
    BRANCH=origin/$BRANCHNAME
    echo "$BASEBRANCH -> $BRANCH"
    #echo -e "${BRANCH}:\t $($SCRIPT_DIR/build_commits_histogram_data.sh --action=histogram --repo=${REPO} --basebranch=${BASEBRANCH} --branch=${BRANCH} --sparkline | spark)" 
done


popd > /dev/null

