#!/usr/bin/env bash

# get a random number between 1 and 10
random=$(( ( RANDOM % 10 )  + 1 ))
echo "Sleeping for $random seconds"
sleep $random
echo "Done sleeping"
