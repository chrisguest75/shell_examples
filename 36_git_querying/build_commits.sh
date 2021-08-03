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

ACTION_JSON=false
ACTION_HOURS=false
IGNORE_ERRORS=false
REPOSITORY_PATH=""

for i in "$@"
do
case $i in
    -h|--help)
        help
        exit 0
    ;; 
    -p=*|--path=*)
        REPOSITORY_PATH="${i#*=}"
        shift # past argument=value
    ;; 
    --json)
        ACTION_JSON=true
    ;; 
    --hours)
        ACTION_HOURS=true
    ;;   
    --days)
        ACTION_HOURS=false
    ;;                  
    --ignore-errors)
        IGNORE_ERRORS=true
    ;;       
esac
done   

if [[ "$REPOSITORY_PATH"  == "" ]]; then
    if [[ $IGNORE_ERRORS == false ]]; then
        >&2 echo ""
        >&2 echo "ERROR: path is not specified"
        >&2 echo ""
    fi
    exit 1
fi

if [[ ! -d $REPOSITORY_PATH ]]; then
    if [[ $IGNORE_ERRORS == false ]]; then
        >&2 echo ""
        >&2 echo "ERROR: '$REPOSITORY_PATH' is not a directory"
        >&2 echo ""
    fi
    exit 1
fi
if [[ ! -d $REPOSITORY_PATH/.git ]]; then
    if [[ $IGNORE_ERRORS == false ]]; then
        >&2 echo ""
        #>&2 print u"\u001b[33m Warning: '$REPOSITORY_PATH/.git' does not exist \u001b[0m"
        >&2 echo "Warning: '$REPOSITORY_PATH/.git' does not exist"
    fi
    exit 1
fi

pushd "$REPOSITORY_PATH" > /dev/null
MODE=
if [[ $ACTION_HOURS == true ]]; then
    MODE=--hours    
fi

reponame=$(basename $(git rev-parse --show-toplevel)) 

max=
longest=
pr_branches=()
while IFS= read -r line; do
    if [[ $line == renovate* ]]; then
        # skip renovate
        # pr_branches+=( "$line" )
        skip=true
    else
        if [[ $(git rev-parse --verify "origin/$line" 2> /dev/null) ]]; then
            pr_branches+=( "origin/$line" )
        else
            >&2 echo "origin/$line not found"
        fi
    fi
    (( ${#line} > max )) && max=${#line} && longest="$line"
done < <(gh pr list --json headRefName | jq -r ".[].headRefName")

#echo "$max, $longest"
if [ -z "${COLUMNS-}" ];then 
    #LINES=$(tput lines)
    COLUMNS=$(tput cols)
fi


PAD_SIZE=60
ITERATIONS=$((COLUMNS - PAD_SIZE - 1))     
#ITERATIONS=134                  
#echo "ITERATIONS=${ITERATIONS}"
printf -v EMPTY_PAD %${PAD_SIZE}s

#echo "Lines: " $LINES
#echo "Columns: " $COLUMNS

if [[ $ACTION_JSON == false ]]; then
    echo
    if [[ $ACTION_HOURS == true ]]; then
        echo "Repository: $reponame (last $ITERATIONS hours)"
    else
        echo "Repository: $reponame (last $ITERATIONS days)"
    fi
fi

REPO=./ 
BRANCH=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
BASEBRANCH=${BRANCH}

PADDED_BRANCH="${BRANCH}:${EMPTY_PAD}"
PADDED_BRANCH="${PADDED_BRANCH:0:$PAD_SIZE}"
SPARK=$($SCRIPT_DIR/build_commits_histogram_data.sh --action=histogram ${MODE} --repo=${REPO} --branch=${BRANCH} --iterations=${ITERATIONS} --sparkline)
RENDERED=$(echo "${SPARK}" | spark)
if [[ $ACTION_JSON == true ]]; then
        jq --null-input --arg reponame "$reponame" --arg branch "$BRANCH" --arg spark "${SPARK}" --arg rendered "${RENDERED}" '. + {reponame: $reponame, branch: $branch, spark: $spark, rendered: $rendered}'
else
    echo "${PADDED_BRANCH} ${RENDERED}"
fi

for BRANCHNAME in "${pr_branches[@]}"
do
    BRANCH=$BRANCHNAME
    PADDED_BRANCH="${BRANCH}:${EMPTY_PAD}"
    PADDED_BRANCH="${PADDED_BRANCH:0:$PAD_SIZE}"

    #echo "$BASEBRANCH -> $BRANCH"
    SPARK=$($SCRIPT_DIR/build_commits_histogram_data.sh --action=histogram ${MODE} --repo=${REPO} --basebranch=${BASEBRANCH} --branch=${BRANCH} --iterations=${ITERATIONS} --sparkline)
    RENDERED=$(echo "${SPARK}" | spark)

    if [[ $ACTION_JSON == true ]]; then
        jq --null-input --arg reponame "$reponame" --arg branch "$BRANCH" --arg spark "${SPARK}" --arg rendered "${RENDERED}" '. + {reponame: $reponame, branch: $branch, spark: $spark, rendered: $rendered}'
    else
        echo "${PADDED_BRANCH} ${RENDERED}"
    fi
done

popd > /dev/null

