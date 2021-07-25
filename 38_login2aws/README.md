# README
Demonstrate how to map an input to an output

TODO:
* admin, viewonly, etc
* select idp
* exit autocomplete
* check dotsource on autocompletions

## Install completions
```sh
# source the completion script
. ./login2aws-completion.bash             
# or
source ./login2aws-completion.bash             
```

## See basic account options
```sh
export LOGIN2AWS_ACCOUNTS=./account.json   

# print options
./login2aws <tab>

LOGIN2AWS_ACCOUNTS=./account.json ./login2aws <tab>
```

## Remove completions 
```sh
./remove-completions.bash      
```

## Resources 
[Checking sourcing](https://stackoverflow.com/questions/2683279/how-to-detect-if-a-script-is-being-sourced)  
