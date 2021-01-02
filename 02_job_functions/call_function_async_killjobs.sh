#!/usr/bin/env bash
set -ef -o pipefail

function do_work {
    local name=$1
    local count=$2
    local wait=$3
    # fake work
    echo "(do_work) $count $name $wait $$"   
    sleep "$wait" 
}

function loop_test {
    local name=$1
    local iterations=$2
    local wait=$3

    echo "Starting $name iterations=$iterations wait=$wait"
    for count in $(seq "$iterations"); do
        do_work "$name" "$count" "$wait" &
        sleep "$wait" 
    done

    echo "Finished $name"
}

function main() {
    local iterations1=$1
    local iterations2=$2
    local sleep1=$3
    local sleep2=$4

    # start background jobs 
    loop_test "work-1" "${iterations1}" "${sleep1}" &
    loop_test "work-2" "${iterations2}" "${sleep2}" &

    # calculate timeout value
    local timeout
    timeout=$(echo "(${iterations1} - 1)" | bc)
    local timeout2
    timeout2=$(echo "(${iterations2} - 1)" | bc)
    if (( "$timeout2" > "$timeout" )); then
        timeout=$timeout2
    fi
    local sleepvalue=${sleep1}
    if (( "$sleepvalue" > "$sleep2" )); then
        sleepvalue=$sleep2
    fi

    # print out the status of the jobs
    echo "timeout=${timeout}"
    echo "sleepvalue=${sleepvalue}"
    local count
    for count in $(seq "$timeout"); do
        jobs -l
        sleep "$sleepvalue"
    done

    # kill remaining jobs
    echo "Killing Jobs $(jobs -p)"
    # shellcheck disable=SC2046
    kill $(jobs -p)
    echo "Remaining Jobs"
    jobs -l
    sleep 1
    echo "And again"    
    jobs -l
}

# entrypoint
main "${1:-10}" "${2:-20}" "${3:-3}" "${4:-2}" 
