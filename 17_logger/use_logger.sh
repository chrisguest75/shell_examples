#! /usr/bin/env bash
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

readonly FILESAFEDATE=$(date +"%Y%m%d_%H%M%S")

readonly LOGS_PATH=${SCRIPT_DIR}/logs

mkdir -p ${LOGS_PATH}
#source ${SCRIPT_DIR}/logger.sh 
#log_debug $argument "extras"
#for argument in 1 2 3; do 
#    log_info $argument; 
#done
export BASHLOG_FILE=1
export BASHLOG_FILE_PATH=${LOGS_PATH}/logs_${FILESAFEDATE}.txt
export DEBUG=1

# This will break into shell so we can examine environment 
#export DEBUG=2
export BASHLOG_EXTRA=1
source ${SCRIPT_DIR}/bash-logger.sh 

log 'debug' 'This is debug';
log 'info' 'This is info';
log 'warn' 'This is warn';
#log 'error' 'This is error';

log 'debug' 'This is debug' 'extra1';
log 'info' 'This is info' 'extra1';
log 'warn' 'This is warn' 'extra1';
#log 'error' 'This is error' 'extra1';

export BASHLOG_JSON_PATH=${LOGS_PATH}/logs_${FILESAFEDATE}.json
export BASHLOG_JSON=1
log 'debug' 'This is debug' 'extra1';
log 'info' 'This is info' 'extra1';
log 'warn' 'This is warn' 'extra1';
log 'error' 'This is error' 'extra1';
