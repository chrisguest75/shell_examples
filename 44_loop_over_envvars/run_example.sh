#!/usr/bin/env bash
echo "*************************************"
echo "** .env_numbered"
echo "*************************************"
. .env_numbered

#env | sort
#export | sort
#local | sort
#printenv | sort
#set | sort

VARIABLES=$(set | grep -Eo "^MY_URL_[0-9]{1,9}=" | grep -Eo "^MY_URL_[0-9]{1,9}")
while IFS=' ', read -r VARIABLE
do
    # use ${!x} to print a variable from a string
    echo "$VARIABLE is ${!VARIABLE}"
done <<< "$VARIABLES"

echo ""
echo "*************************************"
echo "** .env_array"
echo "*************************************"
. .env_array

for variable in "${MY_URL[@]}"
do
   echo "$variable"
done