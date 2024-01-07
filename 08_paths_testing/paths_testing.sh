#!/usr/bin/env bash
set -euf -o pipefail

function help() {
    cat <<- EOF
NAME
    $SCRIPT_NAME - Example of argument parsing

SYNOPSIS
    $SCRIPT_NAME [options]

OPTIONS
    -h --help                 show this help
    --test=[path]             path to test file

EXAMPLES
    $SCRIPT_NAME --test=/path/to/test

    $SCRIPT_NAME --test=test.md

EOF
}

TESTPATH=""

for i in "$@"
do
case $i in
    -h|--help)
        help
        exit 0
    ;;
    -t=*|--test=*)
      TESTPATH="${i#*=}"
      shift # past argument=value
    ;;
esac
done

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
readonly HOME_DIR=~
readonly SCRIPT_PATH=$0
readonly BASENAME_SCRIPT_PATH=$(basename "$0")
readonly DIRNAME_SCRIPT_PATH=$(dirname "$SCRIPT_PATH")
readonly EXTENSION="${BASENAME_SCRIPT_PATH##*.}"
readonly FILENAME="${BASENAME_SCRIPT_PATH%.*}"

# use readlink to find the full canonical path after striping it above.
if [[ $(command -v greadlink) ]]; then
    # mac requires 'brew install coreutils'
    readonly SCRIPT_FULL_PATH="$(dirname "$(greadlink -f "$0")")/${BASENAME_SCRIPT_PATH}"
else
    readonly SCRIPT_FULL_PATH="$(dirname "$(readlink -f "$0")")/${BASENAME_SCRIPT_PATH}"
fi

echo "#############################"
echo "## Processing args"
echo "#############################"
echo ""
echo "WORKING_PATH=${WORKING_PATH}"
echo "HOME_DIR=${HOME_DIR}"
echo "SCRIPT_PATH=${SCRIPT_PATH}"
echo "BASENAME_SCRIPT_PATH=${BASENAME_SCRIPT_PATH}"
echo "DIRNAME_SCRIPT_PATH=${DIRNAME_SCRIPT_PATH}"
echo "SCRIPT_FULL_PATH=${SCRIPT_FULL_PATH}"
echo "EXTENSION=${EXTENSION}"
echo "FILENAME=${FILENAME}"
echo ""

if [[ -n ${TESTPATH} ]]; then

echo "#############################"
echo "## Test path"
echo "#############################"

# use bash parameter expansions.
readonly BASENAME_TESTPATH=$(basename "$TESTPATH")
readonly DIRNAME_TESTPATH=$(dirname "$TESTPATH_PATH")
readonly TESTPATH_EXTENSION="${BASENAME_TESTPATH##*.}"
readonly TESTPATH_FILENAME="${BASENAME_TESTPATH%.*}"

# use readlink to find the full canonical path after striping it above.
if [[ $(command -v greadlink) ]]; then
    # mac requires 'brew install coreutils'
    readonly TESTPATH_FULL_PATH="$(dirname "$(greadlink -f "$TESTPATH")")/${BASENAME_TESTPATH}"
else
    readonly TESTPATH_FULL_PATH="$(dirname "$(readlink -f "$TESTPATH")")/${BASENAME_TESTPATH}"
fi

echo ""
echo "TESTPATH=${TESTPATH}"
echo "TESTPATH_FULL_PATH=${TESTPATH_FULL_PATH}"
echo "BASENAME_TESTPATH=${BASENAME_TESTPATH}"
echo "DIRNAME_TESTPATH=${DIRNAME_TESTPATH}"
echo "TESTPATH_EXTENSION=${TESTPATH_EXTENSION}"
echo "TESTPATH_FILENAME=${TESTPATH_FILENAME}"
echo ""
fi


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

