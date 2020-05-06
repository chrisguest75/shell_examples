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
    -a --action              [build|package]
    -p --package=<path>      Package source for building or folder when building package list
    -o --out=<path>          Output
    --debug                  
    -h --help                show this help

Examples:
    $SCRIPT_NAME --action=build -p=hello-world -o=./packages/

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
    local ACTION=      
    local PACKAGE=  
    local OUT=
    for i in "$@"
    do
    case $i in
        -a=*|--action=*)
            local -r ACTION="${i#*=}"
            shift # past argument=value
        ;;
        -p=*|--package=*)
            local -r PACKAGE="${i#*=}"
            shift # past argument=value
        ;;                    
        -o=*|--out=*)
            local -r OUT="${i#*=}"
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

    if [[ "${HELP}" == true ]] ; then
        EXITCODE=1
        help
    else
        if [ "${ACTION}" ]; then
            case "${ACTION}" in
                help)
                    help
                ;;
                build)
                    if [[ -n ${PACKAGE} ]]; then
                        dpkg-deb --build ${PACKAGE} ${OUT}
                    else
                        echo "*Package not specified*"
                        echo ""
                        help
                        exit 1
                    fi
                ;;
                package)
                    if [[ -n ${PACKAGE} ]]; then
                        if [[ ${DEBUG} == true ]]; then
                            dpkg-scanpackages ${PACKAGE}
                        fi
                        dpkg-scanpackages ${PACKAGE} | gzip -c9  > ./Packages.gz
                    else
                        echo "*Packages folder not specified*"
                        echo ""
                        help
                        exit 1
                    fi                        
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
            echo "No action specified use --action=<action> or --help"
        fi
    fi
    return ${EXITCODE}
}

#echo "Start"
main "$@"
exit $?
