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
# or 
. ./login2aws           
```

## See basic account options
```sh
export LOGIN2AWS_ACCOUNTS=./account.json   

# print options
./login2aws <tab>

LOGIN2AWS_ACCOUNTS=./account.json ./login2aws <tab>
```

## Cleanup
```sh
# Remove completions 
. ./remove-completions.bash      

# unset the accounts path
unset LOGIN2AWS_ACCOUNTS         
```

## Testing and Debugging
1. Open a clean shell
1. Do not run the autocompletions

### Tests
```sh
# without autocomplete
./login2aws

# look at autocomplete output
LOGIN2AWS_ACCOUNTS=$(pwd)/test.json ./login2aws --complete 

# load from ~/.aws                                    
cp cp ./test.json /Users/cguest/.aws/account.json    
./login2aws --complete                                     

# load autocomplete
. ./login2aws
```

## Resources 
[Checking sourcing](https://stackoverflow.com/questions/2683279/how-to-detect-if-a-script-is-being-sourced)  
