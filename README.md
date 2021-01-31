# Shell Examples and Demos
A repository for showing examples of shell scripts.

The aim is to use examples to demonstrate how shells behave and squash some assumptions. 

[RELEASE_NOTES.md](./RELEASE_NOTES.md)

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
info <command>
```

zsh
```sh
man zsh
man zshbuiltins
```

## Example 0 - Cheatsheet
Cheatsheets are a great way to quickly get an answer to your question.  
Steps [README.md](./00_cheatsheet/README.md)  

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
Demonstrates building a debian package repository
Steps [README.md](./09_deb_pkg/README.md)  

## Example 11 - Man pages
Demonstrate how to create a manpage.  
Steps [README.md](./11_manpages/README.md)  

## Example 12 - CSV parsing
Demonstrate how to parse a CSV file  
Steps [README.md](./12_csv/README.md)  

## Example 13 - Bats
Demonstrate how to use bats for testing  
Steps [README.md](./13_bats/README.md)  

## Example 14 - CI Env Overrides
Demonstrate a way to produce ENV overrides in a CI pipeline  
Steps [README.md](./14_ci_env_overrides/README.md) 

## Example 15 - Screen Control
Demonstrates how to control the termninal screen output  
Steps [README.md](./15_screen_control/README.md) 

## Example 16 - Globbing
Demonstrates techniques for globbing and operating on sets of files  
Steps [README.md](./16_globbing/README.md) 

## Example 17 - Logger
Demonstrates how to implement a logger for scripts   
Steps [README.md](./17_logger/README.md) 

## Example 18 - Bats Mocking 
Demonstrates how to test using mocks with bats.  
Steps [README.md](./18_bats_mock/README.md) 

## Example 19 - Timing Operations 
Demonstrate how to time operations in the shell to help with optimisation.  
Steps [README.md](./19_timing_operations/README.md) 

## Example 20 - GPG examples 
Demonstrate how to use GPG to encrypt and decrpyt files.  
Steps [README.md](./20_gpg/README.md) 

## Example 21 - Webserver 
Demonstrate how to set up a webserver in bash  
Steps [README.md](./21_webserver/README.md)

## Example 22 - SystemD Service
Demonstrate how to create a systemd service.  
Steps [README.md](./22_systemd_service/README.md) 

## Example 23 - Whiptail Selector
Demonstrate how to use whiptail for file selection.  
Steps [README.md](./23_whiptail_selection/README.md) 

## Example 24 - Finding files
A few examples on using shell to find files
Steps [README.md](./24_finding_files/README.md) 

## Example 26 - Crom
Demonstrate how to setup a cronjob
Steps [README.md](./26_cron/README.md) 

## Example 27 - JournalCtl
Demonstrate how to use journalctl to discover logs
Steps [README.md](./27_journalctl/README.md) 


## TODO:
  * Globbing 
  * Process Substition versus command substitution < <() < $()
  * Reading input 
  * Detecting dotsourcing. 
  * printing and formatting numbers
  * zsh versus bash
  * defensive programming
  * tricks and shortcuts [[ $_ != $0 ]] && echo "Script is being sourced" || echo "Script is a subshell"
  * generating temporary files. 
  * autocompletion example
  * google script standards https://google.github.io/styleguide/shellguide.html
  * snaps
  * strace cmd 
  * debugfs
  * awk & sed

## Shellchecking

```sh
find . -iname '*.sh' -exec shellcheck {} \; 
```

## Pre-commit hook (shellcheck)
Install the pre-commit hook.  
```sh
# hardlink the script 
ln ./hooks/pre-commit .git/hooks/pre-commit  
```

## Updating RELEASE_NOTES
[TURN](https://github.com/chrisguest75/turn)

```sh
docker run -it --rm -v $(pwd):/repo chrisguest/turn --action=create --type=release --includenext --tags
```