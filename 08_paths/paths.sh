#!/usr/bin/env bash
set -euf -o pipefail

function add_trailing_slash() {
    : ${1?"${FUNCNAME[0]}(path) - missing path argument"}

    if [[ -z ${1} ]]; then 
        #echo "${FUNCNAME[0]}(path) - path is empty" && exit 1
        echo ""
        return
    fi
    # remove an existing slash and add new one.
    echo "${1%/}/"
}

# use bash parameter expansions.
readonly WORKING_PATH=$(pwd)
readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_PATH=${0}
readonly SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
readonly HOME_DIR=~
readonly EXTENSION="${SCRIPT_NAME##*.}"
readonly FILENAME="${SCRIPT_NAME%.*}"

# use readlink to find the full canonical path after striping it above. 
if [[ $(command -v greadlink) ]]; then 
    # mac requires 'brew install coreutils'
    readonly SCRIPT_FULL_PATH="$(dirname "$(greadlink -f "$0")")/${SCRIPT_NAME}"
else
    readonly SCRIPT_FULL_PATH="$(dirname "$(readlink -f "$0")")/${SCRIPT_NAME}"
fi

echo "#############################"
echo "## Processing args"
echo "#############################"
echo ""
echo "SCRIPT_FULL_PATH=${SCRIPT_FULL_PATH}"
echo "WORKING_PATH=${WORKING_PATH}"
echo "SCRIPT_NAME=${SCRIPT_NAME}"
echo "SCRIPT_PATH=${SCRIPT_PATH}"
echo "SCRIPT_DIR=${SCRIPT_DIR}"
echo "HOME_DIR=${HOME_DIR}"
echo "SCRIPT_DIR=${SCRIPT_DIR}"
echo "EXTENSION=${EXTENSION}"
echo "FILENAME=${FILENAME}"

echo ""
echo "#############################"
echo "## Processing args"
echo "#############################"
echo ""
readonly PARAMETER1=${1-}
echo "PARAMETER1=${PARAMETER1} LENGTH=${#PARAMETER1}"

echo ""
echo "#############################"
echo "## Adding trailing slashes"
echo "#############################"
echo ""
echo "add_trailing_slash(\"this/is/my/path\") returns \"$(add_trailing_slash "this/is/my/path")\""
echo "add_trailing_slash(\"this/is/my/path/\") returns \"$(add_trailing_slash "this/is/my/path/")\""
echo "add_trailing_slash(\"\") returns \"$(add_trailing_slash "")\""

echo ""
echo "#############################"
echo "## Removing prefixes from paths"
echo "#############################"
echo ""
# if you run this from root it will remove the 08_paths prefix
while IFS=, read -r filepath 
do
    new_path="${filepath#./08_paths}"
    echo "file '$new_path'"
done < <(find ./ -iname "*") 

echo ""
echo "#############################"
echo "## End of script"
echo "#############################"

