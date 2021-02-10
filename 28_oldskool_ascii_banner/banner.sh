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
    -a --action=[render]
    -f --font=[jpg bitmap font path]    
    -w --width=[font width]    
    -h --height=[font height]    
    -c --chars_per_row=[characters]     characters per row on bitmap 
    -r --rows=[rows]                    numbers of rows of characters on bitmap
    --basea                             if the first character on the bitmap is A (default is false assumes space)                                              
    --debug                  
    -h --help                           show this help

Examples:
    $SCRIPT_NAME --action=render

EOF

    return ${EXITCODE}
}

#****************************************************************************
#** Main script 
#****************************************************************************

function main() {
    local BASEA=false 
    local ACTION="render" 
    local FONT="./fonts/carebear.jpg" 
    local BANNER="BANNER" 
    local EXITCODE=0
    local FONTWIDTH=26
    local FONTHEIGHT=26
    local FONT_CHARS_PER_ROW=12
    local FONT_ROWS=5
    local DEBUG=false  
    local HELP=false

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
        -r=*|--rows=*)
            local -r FONT_ROWS="${i#*=}"
            shift # past argument=value
        ;;                   
        -c=*|--chars_per_row=*)
            local -r FONT_CHARS_PER_ROW="${i#*=}"
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
                    rm -rf "${OUT}" && true
                    mkdir "${OUT}" &> /dev/null && true

                    fontwidth=${FONTWIDTH}
                    fontheight=${FONTHEIGHT}
                    chars_per_row=${FONT_CHARS_PER_ROW}
                    number_of_rows=${FONT_ROWS}
                    if [ "${BASEA}" = false ]; then
                        letter=32
                    else
                        letter=65
                    fi
                    for row in $(seq 0 "${fontheight}" $(( fontheight * (number_of_rows - 1) )) ); 
                    do
                        for column in $(seq 0 "${fontwidth}" $(( fontwidth * (chars_per_row - 1) ))); 
                        do
                            convert "${FONT}" -crop "${fontwidth}x${fontheight}+${column}+${row}" "${OUT}/${letter}.jpg"
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
                        if [ -f "${OUT}/$(ord "$letter").jpg" ]; then
                            # shellcheck disable=SC2086
                            filelist="$filelist ${OUT}/$(ord $letter).jpg"
                        else
                            echo "${OUT}/$(ord "$letter").jpg - not found"
                        fi
                    done
                    #echo $filelist
                    OSNAME="$(uname -s)"
                    case "${OSNAME}" in
                        Linux*)     readonly OSTYPE=LINUX;;
                        Darwin*)    readonly OSTYPE=MAC;;
                        CYGWIN*)    readonly OSTYPE=CYGWIN;;
                        MINGW*)     readonly OSTYPE=MINGW;;
                        *)          readonly OSTYPE="UNKNOWN:${OSNAME}"
                    esac

                    case "${OSTYPE}" in
                        LINUX)     
                            COLOUR_DEPTH="--color-depth=24"
                        ;;
                        MAC)    
                            COLOUR_DEPTH=
                        ;;   
                    esac                 

                    BANNERFILE=./banner.jpg
                    rm "${BANNERFILE}" &> /dev/null && true
                    # shellcheck disable=SC2086
                    convert $filelist +append "${BANNERFILE}"

                    # shellcheck disable=SC2004
                    if [[ $(( textlen * ${fontwidth} )) -gt ${COLUMNS} ]]; then
                        #echo "term width"
                        # shellcheck disable=SC2086    
                        jp2a --term-width --colors ${COLOUR_DEPTH} --fill "${BANNERFILE}"
                    else
                        # shellcheck disable=SC2086
                        jp2a --width=$(( textlen * ${fontwidth} )) --colors ${COLOUR_DEPTH} --fill "${BANNERFILE}"
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
