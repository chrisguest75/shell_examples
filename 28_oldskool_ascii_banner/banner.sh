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

ord() {
  LC_CTYPE=C printf '%d' "'$1"
}

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
    local BASEA=false 
    local ACTION="render" 
    local FONT="./carebear.jpg" 
    local BANNER="BANNER" 
    local EXITCODE=0
    local FONTWIDTH=26
    local FONTHEIGHT=26
    local DEBUG=false  
    local RENDER=false  
    local HELP=false
    local FLAGS=()

    for i in "$@"
    do
    case $i in
        -a=*|--action=*)
            local -r ACTION="${i#*=}"
            shift # past argument=value
        ;;           
        -f=*|--font=*)
            local -r FONT="${i#*=}"
            shift # past argument=value
        ;;
        -b=*|--banner=*)
            local -r BANNER="${i#*=}"
            shift # past argument=value
        ;;             
        -w=*|--width=*)
            local -r FONTWIDTH="${i#*=}"
            shift # past argument=value
        ;;                   
        -h=*|--height=*)
            local -r FONTHEIGHT="${i#*=}"
            shift # past argument=value
        ;;                   
        --basea)
            # shellcheck disable=SC2034
            local -r BASEA=true   
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
                render)
                    OUT=./letters
                    rm -rf "${OUT}" && /bin/true
                    mkdir "${OUT}" &> /dev/null && /bin/true

                    fontwidth=${FONTWIDTH}
                    fontheight=${FONTHEIGHT}
                    if [ "${BASEA}" = false ]; then
                        chars_per_row=12
                        number_of_rows=5
                        letter=32
                    else
                        chars_per_row=10
                        number_of_rows=5
                        letter=65
                    fi
                    for row in $(seq 0 ${fontheight} $(( fontheight * (number_of_rows - 1) )) ); 
                    do
                        for column in $(seq 0 ${fontwidth} $(( fontwidth * (chars_per_row - 1) ))); 
                        do
                            convert ${FONT} -crop ${fontwidth}x${fontheight}+${column}+${row} ${OUT}/${letter}.jpg
                            letter=$(( letter + 1 ))
                        done
                    done

                    text=${BANNER}
                    textlen=${#text}
                    filelist=""
                    for index in $(seq 0 $(( textlen - 1)) ); 
                    do 
                        letter=${text:$index:1}
                        #echo $letter
                        #echo $(ord $letter)
                        if [ -f "${OUT}/$(ord $letter).jpg" ]; then
                            filelist="$filelist ${OUT}/$(ord $letter).jpg"
                        else
                            echo "${OUT}/$(ord $letter).jpg - not found"
                        fi
                    done
                    #echo $filelist

                    BANNERFILE=./banner.jpg
                    rm ${BANNERFILE} && /bin/true
                    convert $filelist +append ${BANNERFILE}

                    if [[ $(( textlen * ${fontwidth} )) -gt ${COLUMNS} ]]; then
                        jp2a --term-width --colors --color-depth=24 --fill ${BANNERFILE}
                    else
                        jp2a --width=$(( textlen * ${fontwidth} )) --colors --color-depth=24 --fill ${BANNERFILE}
                    fi

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
