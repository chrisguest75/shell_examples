#!/bin/bash -x 
#!/usr/bin/env bash 
#Use !/bin/bash -x  for debugging 

# If we are being dotsourced we'll just do autocomplete
(return 0 2>/dev/null) && SOURCED=1 || SOURCED=0
if [[ $SOURCED == 0 ]]; then
    echo "Script needs to be sourced 'source ./remove-completion.bash'"
    exit 1
else
    echo "Script is being sourced (removing login2aws autocompletion)"
    complete -r login2aws
fi
