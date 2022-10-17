#!/usr/bin/env bash
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

if [ -n "${DEBUG_ENVIRONMENT-}" ];then 
    # if DEBUG_ENVIRONMENT is set
    env
    export
fi

function check_prerequisites() {
    for i in "$@"
    do
        local dependency=$i

        if [[ ! $(command -v "$dependency") ]]; then
            >&2 echo "$dependency is not-installed"
            exit 1
        fi
    done
}

function help() {
    cat <<- EOF
usage: $SCRIPT_NAME options

OPTIONS:
    -h --help -?               show this help

    -w|--workspace=<name>      workspace regex              

    --list                     list worksapces
    --enable                   enable extension
    --disable                  disable extension
    --status                   current extension status
    --start                    start workspace
    --backup                   backup workspace db

Examples:
    $SCRIPT_NAME --help 

    list all the workspaces
    $SCRIPT_NAME --list

    list a set of workspaces
    $SCRIPT_NAME --list --workspace=\/shell_examples

    status of copilot for workspace
    $SCRIPT_NAME --status --workspace=shell_examples

    disable copilot for workspace
    $SCRIPT_NAME --disable --workspace=shell_examples

    enable copilot for workspace
    $SCRIPT_NAME --enable --workspace=shell_examples

    start vscode in folder
    $SCRIPT_NAME --start --workspace=shell_examples
EOF
}

LIST=false
ENABLE=false
DISABLE=false
STATUS=false
START=false
WORKSPACE=

for i in "$@"
do
case $i in
    -h|--help)
        help
        exit 0
    ;; 
    --list)
        LIST=true
    ;;     
    --enable)
        ENABLE=true
    ;;     
    --disable)
        DISABLE=true
    ;;     
    --status)
        STATUS=true
    ;;     
    --start)
        START=true
    ;;     
    --backup)
        BACKUP=true
    ;;     
    -w=*|--workspace=*)
        WORKSPACE="${i#*=}"
        shift # past argument=value
    ;;     
esac
done    

OSNAME="$(uname -s)"
case "${OSNAME}" in
    Linux*)     readonly OSTYPE=LINUX;;
    Darwin*)    readonly OSTYPE=MAC;;
    CYGWIN*)    readonly OSTYPE=CYGWIN;;
    MINGW*)     readonly OSTYPE=MINGW;;
    *)          readonly OSTYPE="UNKNOWN:${OSNAME}"
esac

_supported=false
case "${OSTYPE}" in
    MAC)    
        _supported=true
        WORKSPACE_BASE_PATH="$HOME/Library/Application Support/Code/User/workspaceStorage"
    ;;
    LINUX)     
    ;;
    CYGWIN)
    ;;
    MINGW)
    ;;
    *)
    ;;
esac

if [[ $_supported == false ]]; then
    >&2 echo "${OSTYPE} is not-supported"
    exit 1
fi

check_prerequisites sqlite3 jq

if [[ $LIST == true ]]; then
    PROJECT="${WORKSPACE}$"
    find "${WORKSPACE_BASE_PATH}" -iname "workspace.json" -exec jq --arg filename {} -c '. | {"folder": .folder, "filename": $filename}' {} \; | jq -s '.' | jq --arg project "${PROJECT}" '.[] | select(.folder != null) | select(.folder | test(".*\( $project )"))' | jq -s .
else

    if [ $ENABLE == false ] && [ $DISABLE == false ] && [ $STATUS == false ] && [ $START == false ] && [ $BACKUP == false ]; then
        help
        exit 0
    else
        if [[ -z ${WORKSPACE} ]]; then 
            >&2 echo "--workspace is not set"
            exit 1
        fi

        # react_examples (end with '$' means we only want parent directory)
        PROJECT="${WORKSPACE}$"
        
        # get workspace directory
        if [[ $ENABLE == true ]]; then
            echo "Searching..."
            OUTFILE=$(mktemp)
            echo "PROJECT='${PROJECT}'"
            DBPATH=$(dirname "$(find "${WORKSPACE_BASE_PATH}" -iname "workspace.json" -exec jq --arg filename {} -c '. | {"folder": .folder, "filename": $filename}' {} \; | jq -s '.' | jq --arg project "${PROJECT}" '.[] | select(.folder != null) | select(.folder | test(".*\( $project )"))' | jq -s -r '.[].filename' | head -n 1)")
            DBFILE="${DBPATH}/state.vscdb"
        
            echo "DBPATH='${DBPATH}'"
            echo "DBFILE='${DBFILE}'"
            echo "OUTFILE='${OUTFILE}'"
            # create the extensionsIdentifiers/disabled value that will disable copilot.  
            # we filter out existing disabled copilot.  Mix of sql and jq to add to modify json document.  
            sqlite3 "${DBFILE}" 'SELECT IFNULL(b.value, "[]") FROM (SELECT "extensionsIdentifiers/disabled" as keyname) as A LEFT OUTER JOIN ItemTable as B ON a.keyname=b.key;' | jq --arg id "github.copilot" --arg guid "23c4aeee-f844-43cd-b53e-1113e483f1a6" '[.[] | del(select(.id==$id)) | select(. != null)]' > ${OUTFILE}
            cat "${OUTFILE}"
            # replace existing disabled extenstions json doc
            sqlite3 "${DBFILE}" "REPLACE INTO ItemTable (key, value) VALUES(\"extensionsIdentifiers/disabled\", readfile(\"${OUTFILE}\"));"
            # show new list of disabled extensions
            sqlite3 "${DBFILE}" 'SELECT value FROM ItemTable WHERE "key" = "extensionsIdentifiers/disabled";' | jq .
        fi

        if [[ $DISABLE == true ]]; then
            echo "Searching..."
            OUTFILE=$(mktemp)
            echo "PROJECT='${PROJECT}'"
            DBPATH=$(dirname "$(find "${WORKSPACE_BASE_PATH}" -iname "workspace.json" -exec jq --arg filename {} -c '. | {"folder": .folder, "filename": $filename}' {} \; | jq -s '.' | jq --arg project "${PROJECT}" '.[] | select(.folder != null) | select(.folder | test(".*\( $project )"))' | jq -s -r '.[].filename' | head -n 1)")
            DBFILE="${DBPATH}/state.vscdb"

            echo "DBPATH='${DBPATH}'"
            echo "DBFILE='${DBFILE}'"
            echo "OUTFILE='${OUTFILE}'"

            # create the extensionsIdentifiers/disabled value that will disable copilot.  
            # we filter out existing disabled copilot and re-add it to list.  Mix of sql and jq to add to modify json document.  
            sqlite3 "${DBFILE}" 'SELECT IFNULL(b.value, "[]") FROM (SELECT "extensionsIdentifiers/disabled" as keyname) as A LEFT OUTER JOIN ItemTable as B ON a.keyname=b.key;' | jq --arg id "github.copilot" --arg guid "23c4aeee-f844-43cd-b53e-1113e483f1a6" '[.[] | del(select(.id==$id)) | select(. != null)] | . += [{"id": $id, "uuid": $guid}]' > ${OUTFILE}
            cat "${OUTFILE}"
            # replace existing disabled extenstions json doc
            sqlite3 "${DBFILE}" "REPLACE INTO ItemTable (key, value) VALUES(\"extensionsIdentifiers/disabled\", readfile(\"${OUTFILE}\"));"
            # show new list of disabled extensions
            sqlite3 "${DBFILE}" 'SELECT value FROM ItemTable WHERE "key" = "extensionsIdentifiers/disabled";' | jq .
        fi

        if [[ $STATUS == true ]]; then
            echo "Searching..."
            echo "PROJECT='${PROJECT}'"
            DBPATH=$(dirname "$(find "${WORKSPACE_BASE_PATH}" -iname "workspace.json" -exec jq --arg filename {} -c '. | {"folder": .folder, "filename": $filename}' {} \; | jq -s '.' | jq --arg project "${PROJECT}" '.[] | select(.folder != null) | select(.folder | test(".*\( $project )"))' | jq -s -r '.[].filename' | head -n 1)")
            DBFILE="${DBPATH}/state.vscdb"

            echo "DBPATH='${DBPATH}'"
            echo "DBFILE='${DBFILE}'"

            # show new list of disabled extensions
            sqlite3 "${DBFILE}" 'SELECT value FROM ItemTable WHERE "key" = "extensionsIdentifiers/disabled";' | jq .
        fi

        if [[ $START == true ]]; then
            echo "Searching..."
            echo "PROJECT='${PROJECT}'"
            WORKSPACEPATH=$(find "${WORKSPACE_BASE_PATH}" -iname "workspace.json" -exec jq --arg filename {} -c '. | {"folder": .folder, "filename": $filename}' {} \; | jq -s '.' | jq --arg project "${PROJECT}" '.[] | select(.folder != null) | select(.folder | test(".*\( $project )"))' | jq -s -r '.[].folder' | head -n 1)

            echo "WORKSPACEPATH='${WORKSPACEPATH}'"
            REALWORKSPACEPATH="${WORKSPACEPATH//file:\/\//}" 
            echo "REALWORKSPACEPATH='${REALWORKSPACEPATH}'"

            code "${REALWORKSPACEPATH}"
        fi

        if [[ $BACKUP == true ]]; then
            # TODO: Compare backup db to one with extension disabled. 
            echo "Searching..."
            echo "PROJECT='${PROJECT}'"
            # use @tsv but then awk has to process tabs
            WORKSPACEPATHS=$(find "${WORKSPACE_BASE_PATH}" -iname "workspace.json" -exec jq --arg filename {} -c '. | {"folder": .folder, "filename": $filename}' {} \; | jq -s -c '.' | jq -c --arg project "${PROJECT}" '.[] | select(.folder != null) | select(.folder | test(".*\( $project )"))' | jq -s -r -c '.[0] | [.filename, .folder] | @csv')
            echo "WORKSPACEPATHS=${WORKSPACEPATHS}"
            WORKSPACEJSON=$(echo ${WORKSPACEPATHS} | awk -F "," '{print $1}')
            WORKSPACEFOLDER=$(echo ${WORKSPACEPATHS} | awk -F "," '{print $2}')

            DBFILE=$(dirname "$WORKSPACEJSON")/state.vscdb
            WORKSPACENAME=$(basename $WORKSPACEFOLDER)
        
            echo "DBFILE=${DBFILE}"
            echo "WORKSPACEFOLDER=${WORKSPACEFOLDER}"
            echo "WORKSPACENAME=${WORKSPACENAME}"

            #echo "${DBFILE} ./backups/db"
            #mkdir -p ./backups/db
            #cp "${DBFILE}" ./backups/db 
        fi

    fi
fi
