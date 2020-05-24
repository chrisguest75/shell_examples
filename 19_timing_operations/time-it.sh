#!/usr/bin/env bash
#set -ef -o pipefail

declare -g time_samples=()

# Copy this function and then dot source the time-it sript
: <<'COMMENT'
function under_test() {
    echo "Parameters $*"
    local sleeptime=1
    if [[ -n $1 ]]; then
        sleeptime=$1
    fi
    echo "sleep $sleeptime"
    sleep $sleeptime
}
COMMENT

FUNCTION_TO_TEST="under_test"
if [[ -n $1 ]]; then
    FUNCTION_TO_TEST=$1
    shift
fi

ITERATIONS=1
if [[ -n $1 ]]; then
    ITERATIONS=$1
    shift
fi

#######################################
# time_function
# Arguments:
#   1:  Function name to invoke
#   2+: Parameters to pass to function 
# Outputs:
#   Writes function name to stdout
#######################################
function time_function() {
    #echo "**** $FUNCNAME NumArgs:$# ****"
    local func_ptr=$1
    shift
    # microsecond 1 millionth of second
    start=${EPOCHREALTIME}
    $func_ptr "$@"
    end=${EPOCHREALTIME}
    runtime=$(bc <<< "(${end} - ${start})")
    #echo "${runtime} seconds"
    time_samples+=( $runtime )
}

echo "Testing \"$FUNCTION_TO_TEST\" for $ITERATIONS iterations"
for count in $(seq "$ITERATIONS"); do
    echo "Iteration $count"
    time_function $FUNCTION_TO_TEST "$@"
done

printf '%s\n' "${time_samples[@]}"

