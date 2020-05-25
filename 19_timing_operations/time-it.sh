#!/usr/bin/env bash
# Can't really use pipefail on a dotsourced script.
#set -ef -o pipefail

declare -g time_samples=()

# Example function to test
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
. ./time-it.sh under_test 10 2  
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
    # Using BC as epoch realtime is too big and also it is floating point
    runtime=$(bc <<< "(${end} - ${start})")
    #echo "${runtime} seconds"
    time_samples+=( "$runtime" )
}

echo "Testing \"$FUNCTION_TO_TEST\" for $ITERATIONS iterations"
for count in $(seq "$ITERATIONS"); do
    echo "$(date +'%H%M%S-%m_%d_%Y') iteration:$count"
    time_function "$FUNCTION_TO_TEST" "$@"
    timetaken=${time_samples[-1]}
    echo "$(date +'%H%M%S-%m_%d_%Y') iteration:$count timetaken:$timetaken"
    #time_samples+=( "$RANDOM.$RANDOM" )
done

#printf '%s\n' "${time_samples[@]}"

IFS=$'\n' sorted=($(sort -g <<<"${time_samples[*]}")); unset IFS
printf "%s\n" "${sorted[@]}"

 awk '
  BEGIN {
    c = 0;
    sum = 0;
  }
  $1 ~ /^(\-)?[0-9]*(\.[0-9]*)?$/ {
    a[c++] = $1;
    sum += $1;
  }
  END {
    ave = sum / c;
    if( (c % 2) == 1 ) {
      median = a[ int(c/2) ];
    } else {
      median = ( a[c/2] + a[c/2-1] ) / 2;
    }
    OFS="";
    print "SUM:",sum, " COUNT:", c, " AVG:", ave, " MEDIAN:", median, " MIN:", a[0], " MAX:",a[c-1];
  }
' <(printf "%s\n" "${sorted[@]}")
