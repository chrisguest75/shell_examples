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
    local EXITCODE=0
    local DEBUG=false  
    local HELP=false

    for i in "$@"
    do
    case $i in
        -a=*|--action=*)
            local -r ACTION="${i#*=}"
            shift # past argument=value
        ;;           
        --debug)
            set -x
            # shellcheck disable=SC2034
            local -r DEBUG=true   
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
                ps)
                    ps -a
                ;;
                jobs)
                    jobs
                ;;
                ls)
                    ls -la
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
