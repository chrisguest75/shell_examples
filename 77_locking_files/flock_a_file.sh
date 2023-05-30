#! /usr/bin/env bash

readonly LOCKTYPE=${1--x}

echo "${LOCKTYPE}"
lsof -p $$

(
    # exclusive lock on file descriptor 80
    flock ${LOCKTYPE} -n 80 || exit 1
    # commands executed under lock ...
    echo "PID of the subshell: $BASHPID"
    lsof -p $BASHPID
    echo "** Sleeping **"
    sleep 100
) 80> ./mylockfile

