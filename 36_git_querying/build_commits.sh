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
LINE=$(echo -e "${BRANCH}:\t $($SCRIPT_DIR/build_commits_histogram_data.sh --action=histogram --repo=${REPO} --branch=${BRANCH} --sparkline | spark)") 
echo "$LINE" | expand -t $((max + 10)),100 

for BRANCHNAME in "${pr_branches[@]}"
do
    BASEBRANCH=master
    BRANCH=$BRANCHNAME
    #echo "$BASEBRANCH -> $BRANCH"
    LINE=$(echo -e "${BRANCH}:\t $($SCRIPT_DIR/build_commits_histogram_data.sh --action=histogram --repo=${REPO} --basebranch=${BASEBRANCH} --branch=${BRANCH} --sparkline | spark)") 
    echo "$LINE" | expand -t $((max + 10)),100 
done


popd > /dev/null

