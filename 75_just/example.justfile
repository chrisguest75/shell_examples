set dotenv-load := true

export WORLD := "world"

# default lists actions
default:
  @just -f example.justfile --list

# echo with default parameters
echo param1="defaultvalue1" param2="defaultvalue2":
  echo "This echoes $0, {{ param1 }}, {{ param2 }}"

# this is a comment
silentecho:
  @echo 'Silent echoes'

# show dotenv-load
echovars:
  @echo "EXAMPLE_VAR1=${EXAMPLE_VAR1}"
  @echo "EXAMPLE_VAR2=${EXAMPLE_VAR2}"

# check if AWS_PROFILE and AWS_REGION are set
checks:
  [ ! -z "${AWS_PROFILE-}" ] || (echo "AWS_PROFILE is not set"; exit 1)
  [ ! -z "${AWS_REGION-}" ] || (echo "AWS_REGION is not set"; exit 1)

[confirm("Are you sure you want to delete everything?")]
folders: checks
  #!/usr/bin/env bash
  echo '{{invocation_directory()}}'
  echo '{{justfile_directory()}}'
  pwd
  if [ -d './test' ]; then
    echo 'True!'
    rm -rf './test'
  fi
  echo "This is an {{arch()}} machine".
  echo "AWS_PROFILE=${AWS_PROFILE}"
  echo "AWS_REGION=${AWS_REGION}"
  #export

# show overriding variables
printworld:
  #!/usr/bin/env bash
  pwd
  echo "WORLD=${WORLD}"

# show overriding variables
printargs *args:
  #!/usr/bin/env bash
  set -eufo pipefail
  pwd
  echo "ARGUMENTS={{ args }}"

ansi:
  just --version
  # version 1.37 requied
  echo "{{ CLEAR }}"

clear:
  just --version
  # version 1.37 requied
  echo "{{ style("error") }}OH NO{{ NORMAL }}"
