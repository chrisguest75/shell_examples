#!/usr/bin/env bash
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

if [[ $(command -v greadlink) ]]; then 
    # mac requires 'brew install coreutils'
    readonly SCRIPT_FULL_PATH="$(dirname "$(greadlink -f "$0")")/${SCRIPT_NAME}"
else
    readonly SCRIPT_FULL_PATH="$(dirname "$(readlink -f "$0")")/${SCRIPT_NAME}"
fi

readonly SCRIPT_FULL_DIR=$(dirname "$SCRIPT_FULL_PATH")

function help() {
    cat <<- EOF
NAME
    $SCRIPT_NAME - Example of error handling options

SYNOPSIS 
    $SCRIPT_NAME [options]

OPTIONS
    -h --help -?               show this help
    -s --show -?               show options that are set
    --error                    forced error
    --skip_error               forced error but swallow it
    --debug                    debug this script

DESCRIPTION
    This script shows how to handle errors and debug a script. The options are processed in the order they are passed allowing you to disable and enable flags in the script.  

EXAMPLES
    $SCRIPT_NAME --help 
        Show this help

    $SCRIPT_NAME --show --debug --show  
        Show options tha are set, enable the debug flag and show options again for comparison

    $SCRIPT_NAME --error --show 
        Force an error and try to show options that are set. The options will not be shown as the script will exit before that.

    $SCRIPT_NAME --skip_error --show 
        Force an error but set options internally to swallow the error. The options will be shown as the script will not exit. 

    $SCRIPT_NAME --skip_error --error --succeed 
        Skip an error then force an error. It should exit before printing success. 

EOF
}

# if no variables are passed
if [[ -z "$@" ]]; then
    help
    exit 0
fi 

function test_error() {
    this_should_fail "test_error"
    echo "exitcode: $?"
    echo "**This should not be printed**"
}

function test_skip_error() {
    # boilerplate saving and restoring options
    local saveOptions=$-
    local original_state=$(set +o | sort)
    echo "**********************************************"
    echo "* test_skip_error"
    echo "**********************************************"
    printf "$saveOptions\n"
    printf "$original_state\n"

    # override flag on and off
    set +e
    set -x
    this_should_fail "test_error"
    echo "exitcode: $?"

    # eestore the original shell options
    eval "$original_state"
    set -$saveOptions

    echo "Should be back to original state no xtracing"
    echo "**********************************************"

}

DEBUG=false  

for i in "$@"
do
case $i in
    -h|--help)
        help
        exit 0
    ;; 
    --debug)
        set -x
        # shellcheck disable=SC2034
        DEBUG=true   
    ;;     
    --error)
        test_error
    ;;     
    --skip_error)
        test_skip_error
    ;;
    --succeed)
        echo "succeed"
    ;;
    -s|--show)
        echo $- 
        #echo "**********************************************"
        #echo "* OFF"
        #echo "**********************************************"
        #shopt | grep "off$" | sort
        #echo "**********************************************"
        #echo "* ON"
        #echo "**********************************************"
        #shopt | grep "on$" | sort
        echo "**********************************************"
        echo "* Options"
        echo "**********************************************"
        echo "Options: $- "
        set +o | sort
    ;; 
esac
done    
