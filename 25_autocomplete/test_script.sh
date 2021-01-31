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
    local EXITCODE=0
    local DEBUG=false  
    local AUTOCOMPLETE=false  
    local HELP=false
    local FLAGS=()

    local POSITION=0
    for i in "$@"
    do
    case $i in
        autocomplete)
            if [[ $POSITION = 0 ]]; then
                shift # past argument=value
                local -r AUTOCOMPLETE=true   
                if [ -z "${1-}" ];then
                    exit 0
                fi 
                if [[ $1 = "moreoptions" ]]; then
                    find . -type f -exec basename {} \;
                else
                    find . -type d -exec basename {} \;
                fi
                exit 0
            fi
        ;;  
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
    POSITION=$((POSITION+1))
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
                    local options=""
                    for item in "${!FLAGS[@]}"
                    do
                       options="$options ${FLAGS[${item}]} "
                    done   
                    # shellcheck disable=SC2086                 
                    ps $options
                ;;
                ls)
                    local options=""
                    for item in "${!FLAGS[@]}"
                    do
                       options="$options ${FLAGS[${item}]} "
                    done   
                    # shellcheck disable=SC2086                 
                    ls $options
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
