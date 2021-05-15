# Shell Examples and Demos
A repository for showing examples of shell scripts.

The aim is to use examples to demonstrate how shells behave and squash some assumptions.  
It's also a repository used for collecting various shell related tooling.  

[RELEASE_NOTES.md](./RELEASE_NOTES.md)   

## Prequisites 
1. Install [shellcheck](https://github.com/koalaman/shellcheck)
1. Install vscode extension for shellcheck
    ```sh
    code --install-extension timonwong.shellcheck
    ```
## Shell Help
Depending on the shell you are running the help for builtins is different  
  
`bash`
```sh
man bash
help <builtin>
info <command>
```

`zsh`
```sh
man zsh
man zshbuiltins
```

## Example 00 - Cheatsheet
Cheatsheets are a great way to quickly get an answer to your question.  
Steps [README.md](./00_cheatsheet/README.md)  

## Example 01 - Simple argument parsing
Demonstrates how to build a script with simple argument parsing.  
Steps [README.md](./01_argument_parsing/README.md)  

## Example 02 - Functions as jobs
Demonstrates how to initiate a function as a job.  
Steps [README.md](./02_job_functions/README.md)  

## Example 03 - Pipe filters
Demonstrates how read from stdin stream and process it.    
Steps [README.md](./03_pipe_filter_function/README.md)  

## Example 04 - Trap handlers
Demonstrate trap handlers functionality   
Steps [README.md](./04_trap/README.md)  

## Example 05 - Strings
Demonstrate some examples of string manipulation   
Steps [README.md](./05_strings/README.md)  

## Example 06 - Restricted bash shell
Demonstrate a restricted bash shell  
Steps [README.md](./06_restricted_bash/README.md)  

## Example 07 - OS Detection
Demonstrate how to detect the OS type in script to change parameters to commands.  
Steps [README.md](./07_os_detection/README.md)  

## Example 08 - Paths
Demonstrates ways of manipulating paths  
Steps [README.md](./08_paths/README.md)  

## Example 09 - Debian packaging
Demonstrates building a debian package repository  
Steps [README.md](./09_deb_pkg/README.md)  

## Example 10 - Functions
Demonstrates different types of techniques for using functions    
Steps [README.md](./10_functions/README.md)  

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

## Example 25 - Autocompletions
Demonstrate how to write autocomplete scripts  
Steps [README.md](./25_autocomplete/README.md)  

## Example 26 - Crom
Demonstrate how to setup a cronjob  
Steps [README.md](./26_cron/README.md)  

## Example 27 - JournalCtl
Demonstrate how to use journalctl to discover logs  
Steps [README.md](./27_journalctl/README.md)  

## Example 28 - Old Skool Ascii Banner
An old skool banner printer.   
Steps [README.md](./28_oldskool_ascii_banner/README.md)  

## Example 29 - Imagemagick
Examples of using imagemagick to process images.  
Steps [README.md](./29_imagemagick/README.md)  

## Example 30 - User input
Demonstrate how to use user input in scripts  
Steps [README.md](./30_userinput/README.md)  

## Example 31 - Dependency checking
Demonstrates how to check dependencies exist before a script runs  
Steps [README.md](./31_dependency_checking/README.md)  

## Example 32 - JQ
Demonstrates some examples of using jq to process json files  
Steps [README.md](./32_jq/README.md)  

## Example 33 - AWSCLI
Demonstrates using awscli to query resources in an AWS account.  
Steps [README.md](./33_awscli/README.md)  

## Example 35 - APT and DPKG
Demonstrate examples of working with APT and DPKG  
Steps [README.md](./35_apt_and_dpkg/README.md)  

## Example 36 - Git Querying
Demonstrates some examples of using git queries  
Steps [README.md](./36_git_querying/README.md)  

## TODO:
  * Globbing 
  * Process Substition versus command substitution < <() < $()
  * Detecting dotsourcing. 
  * printing and formatting numbers
  * zsh versus bash
  * defensive programming
  * tricks and shortcuts [[ $_ != $0 ]] && echo "Script is being sourced" || echo "Script is a subshell"
  * generating temporary files. 
  * google script standards https://google.github.io/styleguide/shellguide.html
  * snaps
  * strace cmd 
  * debugfs
  * awk & sed
  * understanding tabs output https://unix.stackexchange.com/questions/389255/determine-how-long-tabs-t-are-on-a-line

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

