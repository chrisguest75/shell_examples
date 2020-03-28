#!/usr/bin/env bash 
#set -euf -o pipefail
set -euf -o pipefail

#-e  Exit immediately if a command exits with a non-zero status.
#-u  Treat unset variables as an error when substituting.
#-f  Disable file name generation (globbing).
#-o  pipefail     the return value of a pipeline is the status of
#                the last command to exit with a non-zero status,
#                or zero if no command exited with a non-zero status

FILTER=""
# Using ${1-} means if we don't set $1 it doesn't fail with unbound variable
if [[ -n ${1-} ]]; then
  FILTER=$1
else
  echo "No filter set"
fi

# hashtable
declare -A counts=()

# read data and aggregate the counts for each item filtering on a value
while read -r item count
do
  # shellcheck disable=SC2053
  if [[ ! $item == $FILTER ]]; then
    (( counts[$item]+=count ))
  fi
done

# output the counts
for item in "${!counts[@]}"
do
    printf '%-15s %8d\n' "${item}" "${counts[${item}]}"
done

