#!/usr/bin/env zsh
set -euf -o pipefail

#-e  Exit immediately if a command exits with a non-zero status.
#-u  Treat unset variables as an error when substituting.
#-f  Disable file name generation (globbing).
#-o  pipefail     the return value of a pipeline is the status of
#                the last command to exit with a non-zero status,
#                or zero if no command exited with a non-zero status

readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
readonly HOME_DIR=~
if [[ $(command -v greadlink) ]]; then 
    # mac requires 'brew install coreutils'
    readonly SCRIPT_FULL_PATH="$(dirname "$(greadlink -f "$0")")"
else
    readonly SCRIPT_FULL_PATH="$(dirname "$(readlink -f "$0")")"
fi 

echo "** Path variables **"
echo "SCRIPT_NAME=${SCRIPT_NAME}"
echo "SCRIPT_PATH=${SCRIPT_PATH}"
echo "SCRIPT_DIR=${SCRIPT_DIR}"
echo "HOME_DIR=${HOME_DIR}"
echo "SCRIPT_FULL_PATH=${SCRIPT_FULL_PATH}"
echo ""

# **********************************************
# default if not set ${name-default}
# **********************************************

echo "** Default values and string lengths **"
readonly PARAMETER1=${1-default1}
echo "PARAMETER1=${PARAMETER1} LENGTH=${#PARAMETER1}"

readonly PARAMETER2=${2-default2}
echo "PARAMETER2=${PARAMETER2} LENGTH=${#PARAMETER2}"
echo ""

# **********************************************
# Remove glob
# **********************************************

echo "** Change case of string **"
_globbing="globbing"
echo "'$_globbing' becomes '${_globbing#glob*}'"
echo ""

# **********************************************
# Change casing
# **********************************************

echo "** Change case of string **"
_lowercase="starting as lowercase"
echo "'$_lowercase' becomes '${_lowercase:u}'"
echo "'$_lowercase' becomes '${_lowercase:u}'"
_uppercase="STARTING AS UPPERCASE"
echo "'$_uppercase' becomes '${_uppercase:l}'"
echo "'$_uppercase' becomes '${_uppercase:l}'"
echo ""

# **********************************************
# substring matching
# **********************************************

echo "** Substring matching **"
if [[ ${PARAMETER1} == hello* ]];then
    echo "PARAMETER1 starts with 'hello'"    
else
    echo "PARAMETER1 does not start with 'hello'"    
fi
echo ""

# **********************************************
# padding 
# **********************************************

echo "** Padding a string **"
PAD_SIZE=60
printf -v EMPTY_PAD %${PAD_SIZE}s
OUT=$PARAMETER1${EMPTY_PAD}
OUT=${OUT:0:$PAD_SIZE}
echo "*$OUT*"
echo ""

# **********************************************
# replace characters 
# **********************************************

echo "** Replace in string **"
_imagename="alpine:3.15"
echo "$_imagename becomes ${_imagename//:/}"
echo ""

# **********************************************
# trim whitespace
# **********************************************

echo "** Trim whitepace from string **"
function trim() {
    : ${1?"${FUNCNAME[0]}(string) - missing string argument"}

    if [[ -z ${1} ]]; then 
        echo ""
        return
    fi
    # remove an 
    trimmed=${1##*( )}
    echo ${trimmed%%*( )}
}
_trim="  hello  " 
out=$(trim "$_trim")
echo "Before |$_trim| After |$out|"
_trim="hello    " 
out=$(trim "$_trim")
echo "Before |$_trim| After |$out|"
_trim="   hello" 
out=$(trim "$_trim")
echo "Before |$_trim| After |$out|"
_trim=" " 
out=$(trim "$_trim")
echo "Before |$_trim| After |$out|"
_trim="  hello world  "
out=$(trim "$_trim")
echo "Before |$_trim| After |$out|"
_trim=""
out=$(trim "$_trim")
echo "Before |$_trim| After |$out|"
_trim=$(cat <<- EOF
    hello

    
EOF
)
out=$(trim "$_trim")
echo "Before |$_trim| After |$out|"
echo ""

# **********************************************