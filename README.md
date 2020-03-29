# Shell Examples and Demos
A repository for showing examples of shell scripts.

The aim is to use examples to demonstrate how shells behave and squash some assumptions. 
## Prequisites 
1. Install [shellcheck](https://github.com/koalaman/shellcheck)
1. Install vscode extension for shellcheck
    ```
    code --install-extension timonwong.shellcheck
    ```
## Shell Help
Depending on the shell you are running the help for builtins is different  
  
bash
```sh
man bash
help <builtin>
```

zsh
```sh
man zsh
man zshbuiltins
```

## Example 1 - Simple argument parsing
Demonstrates how to build a script with simple argument parsing.  
Steps [README.md](./01_argument_parsing/README.md)  

## Example 2 - Functions as jobs
Demonstrates how to initiate a function as a job.  
Steps [README.md](./02_job_functions/README.md)  

## Example 3 - Pipe filters
Demonstrates how read from stdin stream and process it.    
Steps [README.md](./03_pipe_filter_function/README.md)  

## Example 4 - Trap handlers
Demonstrate trap handlers functionality   
Steps [README.md](./04_trap/README.md)  

## Example 5 - Strings
Demonstrate some examples of string manipulation   
Steps [README.md](./05_strings/README.md)  

## Example 6 - Restricted bash shell
Demonstrate a restricted bash shell  
Steps [README.md](./06_restricted_bash/README.md)  

## Example 8 - Paths
Demonstrates ways of manipulating paths  
Steps [README.md](./08_paths/README.md)  

## Example 9 - Debian packaging
Demonstrates building a debian package
Steps [README.md](./09_deb_pkg/README.md)  

TODO:
  * Build an apt 
  * Add a man page.
  * Reading input 
  * Detecting dotsourcing. 
  * printing and formatting numbers
  * zsh versus bash
  * unit testing
    * asserts 
  * defensive programming
  * functions  
  * tricks and shortcuts [[ $_ != $0 ]] && echo "Script is being sourced" || echo "Script is a subshell"
  * generating temporary files. 
  * autocompletion example
  * man page example
  * logging 
  
