# README

Demonstrate how to write autocomplete scripts
 
TODO:

* register and unregister completions?
* Do completions already exist for script?

## Install completions

```sh
# source the completion script
. ./example-completion.bash  
# or
source ./example-completion.bash  
```

## See basic options

```sh
# print options
./test-script.sh <tab> <tab>
```

## See internals

```sh
# look at the internal variables that can be used to determine output
export COMPLETION_DEBUG="true"
./test-script.sh <tab> <tab>
unset COMPLETION_DEBUG
```

## How it works

We assign a completion function and then use it to print out a list of options.  

```sh
man builtins
/compgen
```

## Examples

```sh
./test_script.sh --action=ls <tab>
./test_script.sh --action=ls -f=-l              
./test_script.sh --action=ls --flag=-la 

./test_script.sh --action=ps <tab>
./test_script.sh --action=ls --flag=-aux 

# gets completion options from the script
./test_script.sh --action=ls --flag=-la <tab>  
```
## Remove completions

```sh
. ./remove-completions.bash    
# or
source ./remove-completions.bash    
```

```sh
./test-script.sh <tab> <tab>
```

## Research

* [bash-programmable-completion-tutorial](https://iridakos.com/programming/2018/03/01/bash-programmable-completion-tutorial)  
* [how-to-create-script-with-auto-complete](https://askubuntu.com/questions/68175/how-to-create-script-with-auto-complete)  
