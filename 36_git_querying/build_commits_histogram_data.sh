#!/usr/bin/env bash 
#Use !/bin/bash -x  for debugging 
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

#****************************************************************************
#** Print out usage
#****************************************************************************

function help() {
    local EXITCODE=0

    cat <<- EOF
usage: $SCRIPT_NAME options

OPTIONS:
    -a --action              [ps|jobs|ls]
    --debug                  
    -h --help                show this help

Examples:
    $SCRIPT_NAME --action=ps 

EOF

    return ${EXITCODE}
}

#****************************************************************************
#** Main script 
#****************************************************************************

function main() {
    local ACTION= 
    local REPOPATH="./" 
    local BASEBRANCH="" 
    local BRANCH="master" 
    local EXITCODE=0
    local DEBUG=false 
    local SPARKLINE=false      
    local HELP=false
    local FLAGS=()

    for i in "$@"
    do
    case $i in
        -a=*|--action=*)
            local -r ACTION="${i#*=}"
            shift # past argument=value
        ;;           
        -r=*|--repo=*)
            local -r REPOPATH="${i#*=}"
            shift # past argument=value
        ;; 
        -b=*|--branch=*)
            local -r BRANCH="${i#*=}"
            shift # past argument=value
        ;; 
        --basebranch=*)
            local -r BASEBRANCH="${i#*=}"
            shift # past argument=value
        ;;                           
        --debug)
            set -x
            # shellcheck disable=SC2034
            local -r DEBUG=true   
            shift # past argument=value
        ;; 
        --sparkline)
            # shellcheck disable=SC2034
            local -r SPARKLINE=true   
            shift # past argument=value
        ;;         
        -f=*|--flag=*)
            local flag="${i#*=}"
            FLAGS+=("$flag")
            shift # past argument=value
        ;;             
        -h|--help)
            local -r HELP=true            
            shift # past argument=value
        ;;
        *)
            echo "Unrecognised ${i}"
        ;;
    esac
    done    

    if [ "${HELP}" = true ] ; then
        EXITCODE=1
        help
    else
        if [ "${ACTION}" ]; then
            case "${ACTION}" in
                help)
                    help
                ;;
                histogram)
                    pushd "${REPOPATH}" > /dev/null
                    # one day in seconds
                    TIME_GAP=$((60*60*24))
                    NOW=$(date +%s)
                    CURRENT=$NOW
                    # 3 months
                    ITERATIONS_BACK=$((30*3))

                    while [[ $ITERATIONS_BACK -gt 0 ]]; do 
                        PREVIOUS_HOUR=$((CURRENT - TIME_GAP))
                        #echo "CURRENT:$CURRENT - PREVIOUS_HOUR:$PREVIOUS_HOUR"
                        if [[ -z $BASEBRANCH ]]; then
                            DAY_COUNT=$(git log ${BRANCH} --after=$PREVIOUS_HOUR --before=$CURRENT --oneline --format="%h %ct %aD '%s'" | wc -l)
                        else
                            DAY_COUNT=$(git log "${BASEBRANCH}..${BRANCH}" --after=$PREVIOUS_HOUR --before=$CURRENT --oneline --format="%h %ct %aD '%s'" | wc -l)
                        fi
                        DAY_COUNT=$((DAY_COUNT))
                        CURRENT=$PREVIOUS_HOUR
                        
                        if $SPARKLINE; then
                            echo -n "$DAY_COUNT "
                        else
                            #if [[ $DAY_COUNT -ne 0 ]]; then
                            echo "DAY_COUNT:$DAY_COUNT - CURRENT:$(gdate -d @$CURRENT) - PREVIOUS_HOUR:$(gdate -d @$PREVIOUS_HOUR)"
                            #fi
                        fi
                        ITERATIONS_BACK=$((ITERATIONS_BACK - 1))

                    done
                    popd > /dev/null
                ;;                
                *)
                    echo "Unrecognised ${ACTION}"; 
                ;;
            esac
        else
            EXITCODE=1
            echo "No action specified use --action=<action>"
        fi
    fi
    return ${EXITCODE}
}

#echo "Start"
main "$@"
exit $?
