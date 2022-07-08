# Shell Examples and Demos

[![Repository](https://skillicons.dev/icons?i=bash,aws,git,linux,vscode)](https://skillicons.dev)

A repository for showing examples of shell scripts.  

The aim is to use examples to demonstrate how shells behave and squash some assumptions.  
It's also a repository used for collecting various shell related tooling.  

[RELEASE_NOTES.md](./RELEASE_NOTES.md)  

## 1️⃣ Prequisites

* Install [shellcheck](https://github.com/koalaman/shellcheck)
* Install vscode extension for shellcheck

    ```sh
    code --install-extension timonwong.shellcheck
    ```

## ❔Shell Help

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

## ℹ️ Useful commands

```sh
# list all aliases
alias

# list all functions (zsh)
print -l ${(ok)functions}
```

## 00 - Cheatsheet

Cheatsheets are a great way to quickly get an answer to your question.  
Steps [README.md](./00_cheatsheet/README.md)  

## 01 - Simple argument parsing

Demonstrates how to build a script with simple argument parsing.  
Steps [README.md](./01_argument_parsing/README.md)  

## 02 - Functions as jobs

Demonstrates how to initiate a function as a job.  
Steps [README.md](./02_job_functions/README.md)  

## 03 - Pipe filters

Demonstrates how read from stdin stream and process it.  
Steps [README.md](./03_pipe_filter_function/README.md)  

## 04 - Trap handlers

Demonstrate trap handlers functionality  
Steps [README.md](./04_trap/README.md)  

## 05 - Strings

Demonstrate some examples of string manipulation and variables  
Steps [README.md](./05_strings_and_variables/README.md)  

## 06 - Restricted bash shell

Demonstrate a restricted bash shell  
Steps [README.md](./06_restricted_bash/README.md)  

## 07 - OS Detection

Demonstrate how to detect the OS type in script to change parameters to commands.  
Steps [README.md](./07_os_detection/README.md)  

## 08 - Paths

Demonstrates ways of manipulating paths  
Steps [README.md](./08_paths/README.md)  

## 09 - Debian packaging

Demonstrates building a debian package repository  
Steps [README.md](./09_deb_pkg/README.md)  

## 10 - Functions

Demonstrates different types of techniques for using functions  
Steps [README.md](./10_functions/README.md)  

## 11 - Man pages

Demonstrate how to create a manpage.  
Steps [README.md](./11_manpages/README.md)  

## 12 - CSV parsing

Demonstrate how to parse and work with CSV files.  
Steps [README.md](./12_csv/README.md)  

## 13 - Bats

Demonstrate how to use bats for testing  
Steps [README.md](./13_bats/README.md)  

## 14 - CI Env Overrides

Demonstrate a way to produce ENV overrides in a CI pipeline  
Steps [README.md](./14_ci_env_overrides/README.md)  

## 15 - Screen Control

Demonstrates how to control the termninal screen output  
Steps [README.md](./15_screen_control/README.md)  

## 16 - Globbing

Demonstrates techniques for globbing and operating on sets of files  
Steps [README.md](./16_globbing/README.md)  

## 17 - Logger

Demonstrates how to implement a logger for scripts  
Steps [README.md](./17_logger/README.md)  

## 18 - Bats Mocking

Demonstrates how to test using mocks with bats.  
Steps [README.md](./18_bats_mock/README.md)  

## 19 - Timing Operations

Demonstrate how to time operations in the shell to help with optimisation.  
Steps [README.md](./19_timing_operations/README.md)  

## 20 - GPG examples

Demonstrate how to use GPG to encrypt and decrpyt files.  
Steps [README.md](./20_gpg/README.md)  

## 21 - Webserver

Demonstrate how to set up a webserver in bash  
Steps [README.md](./21_webserver/README.md)  

## 22 - SystemD Service

Demonstrate how to create a systemd service.  
Steps [README.md](./22_systemd_service/README.md)  

## 23 - Whiptail Selector

Demonstrate how to use whiptail for file selection.  
Steps [README.md](./23_whiptail_selection/README.md)  

## 24 - Finding files

A few examples on using shell to find files  
Steps [README.md](./24_finding_files/README.md)  

## 25 - Autocompletions

Demonstrate how to write autocomplete scripts  
Steps [README.md](./25_autocomplete/README.md)  

## 26 - Cron

Demonstrate how to setup a cronjob  
Steps [README.md](./26_cron/README.md)  

## 27 - JournalCtl

Demonstrate how to use journalctl to discover logs  
Steps [README.md](./27_journalctl/README.md)  

## 28 - Old Skool Ascii Banner

An old skool banner printer.  
Steps [README.md](./28_oldskool_ascii_banner/README.md)  

## 29 - Imagemagick

Examples of using imagemagick to process images.  
Steps [README.md](./29_imagemagick/README.md)  

## 30 - User input

Demonstrate how to use user input in scripts  
Steps [README.md](./30_userinput/README.md)  

## 31 - Dependency checking

Demonstrates how to check dependencies exist before a script runs  
Steps [README.md](./31_dependency_checking/README.md)  

## 32 - JQ

Demonstrates some examples of using jq to process json files  
Steps [README.md](./32_jq/README.md)  

## 33 - AWSCLI

Demonstrates using awscli to query resources in an AWS account.  
Steps [README.md](./33_awscli/README.md)  

## 35 - APT and DPKG

Demonstrate examples of working with APT and DPKG  
Steps [README.md](./35_apt_and_dpkg/README.md)  

## 36 - Git Querying and Examples

Demonstrates some examples of using `git` queries and tools  
Steps [README.md](./36_git/README.md)  

## 37 - Guid generation

Demonstrates techniques for generating unique ids in scripts.  
Steps [README.md](./37_guids/README.md)  

## 38 - Mapping inputs to outputs

Demonstrate how to map an input to an output
Steps [README.md](./38_value_maps/README.md)  

## 42 - yq and yaml

Demonstrates some examples of using `yq` to process yaml files  
Steps [README.md](./42_yq_yaml/README.md)  

## 43 - AWK

Demonstrates techniques for using awk to process files.  
Steps [README.md](./43_awk/README.md)  

## 44 - Looping over indexed envvars

Demonstrates techniques processing environment variables.  
Steps [README.md](./44_indexed_envvars/README.md)  

## 46 - stdout and stderr redirection

Demonstrate and work through some stdout and stderr redirection  
Steps [README.md](./46_stdout_stderr/README.md)  

## 47 - FFMPEG

Demonstrate how to use ffmpeg to perform different types of encodings.  
Steps [README.md](./47_ffmpeg/README.md)  

## 48 - SED

Demonstrates techniques for using sed to process files.  
Steps [README.md](./48_sed/README.md)  

## 49 - brew

Demonstrate how to create a `brew` package.  
Steps [README.md](./49_brew/README.md)  

## 50 - tmux

Demonstrate some tmux examples and common commands.  
Steps [README.md](./50_tmux/README.md)  

## 51 - grep and regex

Demonstrates examples of how to use grep and regex.  
Steps [README.md](./51_grep_and_regex/README.md)  

## 52 - xml

Demonstrate how to handle Xml in shell scripts.  
Steps [README.md](./52_xml/README.md)  

## 53 - syncing files

Demonstrate some examples syncing directories  
Steps [README.md](./53_sync_files/README.md)  

## 54 - date handling

Demonstrate date handling in shell.  
Steps [README.md](./54_date_handling/README.md)  

## 55 - vim setup

Demonstrates configuring a container for `vim`  
Steps [README.md](./55_vim/README.md)  

## 59 - monitoring folders

Demonstrate how to monitor a folder for changes.  
Steps [README.md](./59_monitor_folder/README.md)  

## 60 - creating HLS streams from segments

Demonstrates building a hls from individual segments of wav files.  
Steps [README.md](./60_create_hls_from_segments/README.md)  

## 61 - curl

Demonstrate some common examples with `curl`  
Steps [README.md](./61_curl/README.md)  

## 62 - binary files

Working with binary files in shell.  
Steps [README.md](./62_binary_files/README.md)  

## 👀 Resources

* Google script standards [here](https://google.github.io/styleguide/shellguide.html)
* Understanding tabs output [here](https://unix.stackexchange.com/questions/389255/determine-how-long-tabs-t-are-on-a-line)


📝 TODO:
  * oh-my-zsh and oh-my-bash
  * Process Substition versus command substitution < <() < $()
    sdiff <(ffprobe -show_frames test.mp4  | grep pkt_pts_time) <(ffprobe -show_frames original.mp4 | grep pkt_pts_time)
  * Detecting dotsourcing.
        https://stackoverflow.com/questions/2683279/how-to-detect-if-a-script-is-being-sourced
        ```sh
        (return 0 2>/dev/null) && SOURCED=1 || SOURCED=0
          if [[ $SOURCED == 1 ]]; then
            #echo "Script is being sourced"
            return 1
            #else
            #echo "Script is a subshell"
          fi
        ```
  * tricks and shortcuts [[ $_ != $0 ]] && echo "Script is being sourced" || echo "Script is a subshell"
  * printing and formatting numbers
  * zsh versus bash
  * defensive programming
  * snaps
  * strace cmd 
  * debugfs
  * subst
  * cut
  * Add a keywords index for links through to examples.  
  * Options 
    https://unix.stackexchange.com/questions/310957/how-to-restore-the-value-of-shell-options-like-set-x
    ```sh
    set +o noclobber
    set -o 
    set -o noclobber
    https://en.wikipedia.org/wiki/Clobbering
    ```
  * listing state; functions, env, paths, etc  
  * Changing file extensions `find . -name "*.js" -exec sh -c 'mv "$1" "${1%.js}.ts"' _ {} \;`
  * running commands from gists. 

    ```sh
    ## Run with curl from gist
    export MAP_FILE=$(pwd)/test.map
    ROLE=$(curl -s https://gist.githubusercontent.com/chrisguest75/b6bf4770237e1307b3fef4ffa3d4a187/raw/0f05f1ae43ce0102fe9394b6dead9d502876be0d/get_mapped_value.sh | bash -s account1)
    echo $ROLE
    ```

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
