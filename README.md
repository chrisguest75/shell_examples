# Shell Examples and Demos

[![Repository](https://skillicons.dev/icons?i=bash,aws,git,linux,vscode)](https://skillicons.dev)

A repository for showing examples of shell scripts.  

The aim is to use examples to demonstrate how shells behave and squash some assumptions.  
It's also a repository used for collecting various shell related tooling.  

A list of things still to try and investigate [TODO.md](./TODO.md)  

- [Shell Examples and Demos](#shell-examples-and-demos)
  - [1️⃣ Prequisites](#1️⃣-prequisites)
  - [❔Shell Help](#shell-help)
  - [ℹ️ Useful commands](#ℹ️-useful-commands)
  - [00 - Cheatsheet](#00---cheatsheet)
  - [01 - Simple argument parsing](#01---simple-argument-parsing)
  - [02 - Functions as jobs](#02---functions-as-jobs)
  - [03 - Pipe filters](#03---pipe-filters)
  - [04 - Trap handlers](#04---trap-handlers)
  - [05 - Strings](#05---strings)
  - [06 - Restricted bash shell](#06---restricted-bash-shell)
  - [07 - OS Detection](#07---os-detection)
  - [08 - Paths](#08---paths)
  - [09 - Debian packaging](#09---debian-packaging)
  - [10 - Functions](#10---functions)
  - [11 - Man pages](#11---man-pages)
  - [12 - CSV parsing](#12---csv-parsing)
  - [13 - Bats](#13---bats)
  - [14 - CI Env Overrides](#14---ci-env-overrides)
  - [15 - Screen Control](#15---screen-control)
  - [16 - Globbing](#16---globbing)
  - [17 - Logger](#17---logger)
  - [18 - Bats Mocking](#18---bats-mocking)
  - [19 - Timing Operations](#19---timing-operations)
  - [20 - GPG examples](#20---gpg-examples)
  - [21 - Webserver](#21---webserver)
  - [22 - SystemD Service](#22---systemd-service)
  - [23 - Whiptail Selector](#23---whiptail-selector)
  - [24 - Finding files](#24---finding-files)
  - [25 - Autocompletions](#25---autocompletions)
  - [26 - Cron](#26---cron)
  - [27 - JournalCtl](#27---journalctl)
  - [28 - Old Skool Ascii Banner](#28---old-skool-ascii-banner)
  - [29 - Imagemagick](#29---imagemagick)
  - [30 - User input](#30---user-input)
  - [31 - Dependency checking](#31---dependency-checking)
  - [32 - JQ](#32---jq)
  - [33 - AWSCLI](#33---awscli)
  - [35 - APT and DPKG](#35---apt-and-dpkg)
  - [36 - Git Querying and Examples](#36---git-querying-and-examples)
  - [37 - Guid generation](#37---guid-generation)
  - [38 - Mapping inputs to outputs](#38---mapping-inputs-to-outputs)
  - [42 - yq and yaml](#42---yq-and-yaml)
  - [43 - AWK](#43---awk)
  - [44 - Looping over indexed envvars](#44---looping-over-indexed-envvars)
  - [46 - stdin, stdout and stderr redirection](#46---stdin-stdout-and-stderr-redirection)
  - [47 - FFMPEG](#47---ffmpeg)
  - [48 - SED](#48---sed)
  - [49 - brew](#49---brew)
  - [50 - tmux](#50---tmux)
  - [51 - grep and regex](#51---grep-and-regex)
  - [52 - xml](#52---xml)
  - [53 - syncing files](#53---syncing-files)
  - [54 - date handling](#54---date-handling)
  - [55 - vim setup](#55---vim-setup)
  - [56 - options handling](#56---options-handling)
  - [59 - monitoring folders](#59---monitoring-folders)
  - [60 - creating HLS streams from segments](#60---creating-hls-streams-from-segments)
  - [61 - curl](#61---curl)
  - [62 - binary files](#62---binary-files)
  - [63 - md5](#63---md5)
  - [64 - calculations](#64---calculations)
  - [65 - pipes](#65---pipes)
  - [66 - generating and renaming files](#66---generating-and-renaming-files)
  - [68 - difftools](#68---difftools)
  - [69 - dotsourcing](#69---dotsourcing)
  - [70 - xargs](#70---xargs)
  - [71 - disk usage](#71---disk-usage)
  - [72 - line endings](#72---line-endings)
  - [73 - creating archives](#73---creating-archives)
  - [74 - envelope encryption](#74---envelope-encryption)
  - [75 - just](#75---just)
  - [76 - links](#76---links)
  - [78 - dns](#78---dns)
  - [👀 Resources](#-resources)
  - [Shellchecking](#shellchecking)
  - [Pre-commit hook (shellcheck)](#pre-commit-hook-shellcheck)
  - [Updating RELEASE\_NOTES](#updating-release_notes)

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
Steps [README.md](./07_detect_os/README.md)  

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

## 46 - stdin, stdout and stderr redirection

Demonstrate and work through some stdout and stderr redirection  
Steps [README.md](./46_stdin_stdout_stderr/README.md)  

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

## 56 - options handling

Demonstrate how to use options in shell.  
Steps [README.md](./56_options_handling/README.md)  

## 59 - monitoring folders

Demonstrate how to monitor a folder for changes using `inotify` or `watchman`.  
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

## 63 - md5

Demonstrate how to id files using `md5` and `md5sum`  
Steps [README.md](./63_md5_file_id/README.md)  

## 64 - calculations

Demonstrate some way of performing calculations in shell and scripts.  
Steps [README.md](./64_calculations/README.md)  

## 65 - pipes

Demonstrate how to work with anonymous and named pipes.  
Steps [README.md](./65_pipes/README.md)  

## 66 - generating and renaming files

Demonstrate techniques for generating and renaming files.  
Steps [README.md](./66_generating_renaming_files/README.md)  

## 68 - difftools

Example textual diffing tools.  
Steps [README.md](./68_difftools/README.md)  

## 69 - dotsourcing

Demonstrate how to use dot-sourcing.  
Steps [README.md](./69_dotsourcing/README.md)  

## 70 - xargs

Demonstrate basic behaviour with `xargs`.  
Steps [README.md](./70_xargs/README.md)  

## 71 - disk usage

Demonstrate some examples of calculating disk usage.  
Steps [README.md](./71_disk_usage/README.md)  

## 72 - line endings

Demonstrate some examples of working with line-endings differences.  
Steps [README.md](./72_line_endings/README.md)  

## 73 - creating archives

Demonstrate how to create archive files.  
Steps [README.md](./73_creating_archives/README.md)  

## 74 - envelope encryption

Demonstrate how to perform envelope encryption.  
Steps [README.md](./74_envelope_encryption/README.md)  

## 75 - just

Demonstrate how `just` can be used like package.json scripts.  
Steps [README.md](./75_just/README.md)  

## 76 - links

Demonstrate symbolic and hard links.  
Steps [README.md](./76_links/README.md)  

## 78 - dns

Examples for working with DNS.  
Steps [README.md](./78_dns/README.md)  

## 👀 Resources

- Google script standards [here](https://google.github.io/styleguide/shellguide.html)
- Understanding tabs output [here](https://unix.stackexchange.com/questions/389255/determine-how-long-tabs-t-are-on-a-line)

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
