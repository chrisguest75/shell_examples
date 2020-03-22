#!/usr/bin/env bash 
#set -euf -o pipefail
set -ef -o pipefail

#-e  Exit immediately if a command exits with a non-zero status.
#-u  Treat unset variables as an error when substituting.
#-f  Disable file name generation (globbing).
#-o  pipefail     the return value of a pipeline is the status of
#                the last command to exit with a non-zero status,
#                or zero if no command exited with a non-zero status

FILTER=""
if [[ -n $1 ]]; then
  FILTER=$1
else
  echo "No filter set"
fi

# hashtable
#counts=
declare -A counts   

# read data
while read -r item count
do
  # shellcheck disable=SC2053
  if [[ ! $item == $FILTER ]]; then
    (( counts[$item]+=count ))
  fi
done

for item in "${!counts[@]}"
do
    printf '%-15s %8d\n' "${item}" "${counts[${item}]}"
done

