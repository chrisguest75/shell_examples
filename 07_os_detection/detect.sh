#!/usr/bin/env bash 
#Use !/bin/bash -x  for debugging 
set -euf -o pipefail

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
# shellcheck disable=SC2034
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

OSNAME="$(uname -s)"
case "${OSNAME}" in
    Linux*)     readonly OSTYPE=LINUX;;
    Darwin*)    readonly OSTYPE=MAC;;
    CYGWIN*)    readonly OSTYPE=CYGWIN;;
    MINGW*)     readonly OSTYPE=MINGW;;
    *)          readonly OSTYPE="UNKNOWN:${OSNAME}"
esac

echo "SCRIPT_NAME: ${SCRIPT_NAME}"
echo "SCRIPT_PATH: ${SCRIPT_PATH}"
echo "SCRIPT_DIR: ${SCRIPT_DIR}"
echo "OS Type is ${OSTYPE}"
case "${OSTYPE}" in
    LINUX)     
        lsb_release -a 
        echo "Hostname: $(hostname)"
    ;;
    MAC)    
        sw_vers -productName
        sw_vers -productVersion
        sw_vers -buildVersion
        echo "Hostname (VPN): $(scutil --get HostName)"
        echo "LocalHostName: $(scutil --get LocalHostName)"        
    ;;
    CYGWIN)
    
    ;;
    MINGW)
    
    ;;
    *)
    ;;
esac

if [[ ${OSTYPE} == "MAC" ]]; then
    readonly SYMLINKED_PATH="$(dirname "$(greadlink -f "$0")")"
else
    readonly SYMLINKED_PATH="$(dirname "$(readlink -f "$0")")"
fi
echo "${SYMLINKED_PATH}"