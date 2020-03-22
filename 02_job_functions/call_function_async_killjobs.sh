#!/usr/bin/env bash -e

function do_work {
    local name=$1
    local count=$2
    echo "$count $name $$"   
}

function loop_test {
    local name=$1
    local iterations=$2
    local wait=$3

    for count in $(seq "$iterations"); do
        do_work "$name" "$count" &
        sleep "$wait" 
    done

    echo "Finished $name"
}


function main() {
    loop_test "work-1" 10 3 &
    loop_test "work-2" 20 2 &

    local count
    for count in $(seq 15); do
        jobs -l
        sleep 1 
    done

    echo "Killing Jobs"
    # shellcheck disable=SC2046
    kill $(jobs -p)
    echo "Remaining Jobs"
    jobs -l
    sleep 1
    echo "And again"    
    jobs -l
}

main
