#!/usr/bin/env bash 
set -euf -o pipefail

echo "Waiting..."

function trap_hup_handler() {
    echo "SIGHUP handler exiting"
    exit $(( 128 + 1 ))
}
function trap_int_handler() {
    echo "SIGINT handler exiting"
    exit $(( 128 + 2 ))
}
function trap_quit_handler() {
    echo "SIGQUIT handler exiting"
    exit $(( 128 + 3 ))
}
function trap_term_handler() {
    echo "SIGTERM handler exiting"
    exit $(( 128 + 15 ))
}
function ctrlc_script() {
    echo "CTRL+C exiting"
    exit
}
function error_exit() {
    echo "TRAPPED: Error exitcode"
    # you can overwrite the exit code.
    #exit 0
}
function exit_script() {
    echo "TRAPPED: exit_script"
    # you can overwrite the exit code.
    #exit 0
}

trap exit_script EXIT
trap error_exit ERR
trap ctrlc_script INT
trap trap_hup_handler SIGHUP
trap trap_int_handler SIGINT
trap trap_quit_handler SIGQUIT
trap trap_term_handler SIGTERM

thisPid="${$}";
echo "PID $thisPid: Sleeping 10000"
_continue=true
while $_continue; 
do
    echo -n "."
    sleep 1
done
