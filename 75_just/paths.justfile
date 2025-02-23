set dotenv-load := true

export SOURCE_FILE:='../52_xml/README.md'

## Paths
# This justfile demonstrates the use of the path functions in just

# USE INBUILT PATH FUNCTIONS
# just -f paths.justfile paths-inbuilt
# just -f paths.justfile paths-inbuilt ../52_xml/README.md

# USE TRADITIONAL BASH PATH FUNCTIONS
# just -f paths.justfile paths-bash  
# just -f paths.justfile paths-bash ../52_xml/README.md 

# THIS IS BROKEN IF YOU RELY ON DEFAULT VALUE (IT GIVES INCCORECT PATH)
# just -f paths.justfile paths-test  
# just -f paths.justfile paths-test ../52_xml/README.md 

# default lists actions
default:
  @just -f {{ source_file() }} --list

paths-bash filepath="${SOURCE_FILE}":
  #!/usr/bin/env bash
  set -eufo pipefail
  echo "default: ${SOURCE_FILE}"

  export WORKING_PATH=$(pwd)
  export HOME_DIR=~
  export SCRIPT_PATH=$0
  export BASENAME_SCRIPT_PATH=$(basename "$0")
  export DIRNAME_SCRIPT_PATH=$(dirname "$SCRIPT_PATH")
  export EXTENSION_SCRIPT_PATH="${BASENAME_SCRIPT_PATH##*.}"
  export FILENAME_SCRIPT_PATH="${BASENAME_SCRIPT_PATH%.*}"
  echo "working_path: ${WORKING_PATH}"
  echo "home_dir: ${HOME_DIR}"
  echo "script_path: ${SCRIPT_PATH}"
  echo "basename_script_path: ${BASENAME_SCRIPT_PATH}"
  echo "dirname_script_path: ${DIRNAME_SCRIPT_PATH}"
  echo "extension_script_path: ${EXTENSION_SCRIPT_PATH}"
  echo "filename_script_path: ${FILENAME_SCRIPT_PATH}"

  export BASENAME_FILEPATH=$(basename "{{ filepath }}")
  export DIRNAME_FILEPATH=$(dirname "{{ filepath }}")
  export EXTENSION_FILEPATH="${BASENAME_FILEPATH##*.}"
  export FILENAME_FILEPATH="${BASENAME_FILEPATH%.*}"
  echo "basename_filepath: ${BASENAME_FILEPATH}"
  echo "dirname_filepath: ${DIRNAME_FILEPATH}"
  echo "extension_filepath: ${EXTENSION_FILEPATH}"
  echo "filename_filepath: ${FILENAME_FILEPATH}"


paths-inbuilt filepath="${SOURCE_FILE}":
  #!/usr/bin/env bash
  set -eufo pipefail
  echo "default: ${SOURCE_FILE}"
  echo "filepath: {{ filepath }}"
  echo ""
  echo "absolute_path() : {{ absolute_path(filepath) }}"
  echo "extension() : {{ extension(filepath) }}"
  echo "canonicalize() : {{ canonicalize(filepath) }}"
  echo "file_name() : {{ file_name(filepath) }}"
  echo "file_stem() : {{ file_stem(filepath) }}"
  echo "parent_directory() : {{ parent_directory(filepath) }}"
  echo "without_extension() : {{ without_extension(filepath) }}"

paths-test filepath="${SOURCE_FILE}":
  #!/usr/bin/env bash
  set -eufo pipefail
  echo "****************"
  echo "Test"
  echo "****************"
  echo "default: ${SOURCE_FILE}"
  export INPUT_FILEPATH="{{ filepath }}"
  export OUTPUT_FOLDER="./test_output"
  echo "${OUTPUT_FOLDER}/{{ without_extension(file_name(filepath)) }}_concat.wav"

