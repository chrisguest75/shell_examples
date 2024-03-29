#!/usr/bin/env bash
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

function help() {
    cat <<- EOF
usage: $SCRIPT_NAME options

OPTIONS:
    -h --help -?               show this help
    -p --path                  path of repo
    -m --merge                 merge origin into default branch

Examples:
    $SCRIPT_NAME --help 

EOF
}

ACTION_MERGE=false

PARENT_PATH=""

for i in "$@"
do
case $i in
    -h|--help)
        help
        exit 0
    ;; 
    -p=*|--path=*)
        PARENT_PATH="${i#*=}"
        shift # past argument=value
    ;; 
    -m|--merge)
        ACTION_MERGE=true
    ;;          
esac
done    

if [[ "$PARENT_PATH"  == "" ]]; then
    >&2 echo "ERROR: path is not specified"
    echo ""
    help
    exit 1
fi

if [[ ! -d $PARENT_PATH ]]; then
    >&2 echo "ERROR: '$PARENT_PATH' is not a directory"
    echo ""
    help
    exit 1
fi

TMP_OUT=./out/my_repos.json

echo "Get status for all repos"
find ${PARENT_PATH} -maxdepth 1 -type d -exec ${SCRIPT_DIR}//git_sync_status.sh --path={} --status \; | jq -s '. | sort_by(.reponame)' > ${TMP_OUT}

echo "Iterate over the repos on_default_branch and not modified"
while IFS=" ", read -r rootpath reponame default_branch commit origincommit current_branch on_default_branch modified unfetched_changes
do
    echo "reponame=$reponame, unfetched_changes=$unfetched_changes, on_default_branch=$on_default_branch, modified=$modified"
    ${SCRIPT_DIR}/git_sync_status.sh --path=${rootpath} --status
    ${SCRIPT_DIR}//git_sync_status.sh --path=${rootpath} --fetch
    ${SCRIPT_DIR}//git_sync_status.sh --path=${rootpath} --diff 
    ${SCRIPT_DIR}//git_sync_status.sh --path=${rootpath} --status
    # merge if triggered
    if [[ $ACTION_MERGE == true ]]; then
        ${SCRIPT_DIR}//git_sync_status.sh --path=${rootpath} --merge    
        ${SCRIPT_DIR}//git_sync_status.sh --path=${rootpath} --status
    fi
done < <(jq -c -r '.[] | select(.on_default_branch == "true" and .modified == "false") | "\(.rootpath) \(.reponame) \(.default_branch) \(.commit) \(.origincommit) \(.current_branch) \(.on_default_branch) \(.modified) \(.unfetched_changes)"' ${TMP_OUT})

echo "Repos not on default"
jq -r '.[] | select(.on_default_branch == "false" or .modified == "true") | "\(.rootpath)"' ./out/my_repos.json
