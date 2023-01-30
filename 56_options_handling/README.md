# README

Demonstrate how to use options in shell.  

TODO:

* Work out how to push and pop options.  

- [README](#readme)
  - [Bash](#bash)
    - [List options](#list-options)
    - [Auto-exporting variables](#auto-exporting-variables)
    - [No clobbering of files](#no-clobbering-of-files)
    - [Debugging](#debugging)
    - [Pipefail and scripts](#pipefail-and-scripts)
  - [ZSH](#zsh)
  - [Resources](#resources)

## Bash

Bourne Again Shell.  

### List options

```sh
# show bash options
bash

# help for set
help set
man bash

set -o
shopt | grep "on$"
```

```sh
# print out current options
echo $- 
```

### Auto-exporting variables  

Read an env file and export each entry.  

```sh
# -a  Mark variables which are modified or created for export.
set -a
. ./.env.template
set +a
env
```

### No clobbering of files  

```sh
# noclobber is same as -C
# -C  If set, disallow existing regular files to be overwritten
#           by redirection of output.
set +o noclobber
set -o 
set -o noclobber
```

### Debugging

Use the following shebang for debugging  

```sh
#!/bin/bash -x
# -x  Print commands and their arguments as they are executed.
```

### Pipefail and scripts

```sh
# -e  Exit immediately if a command exits with a non-zero status.
# -u  Treat unset variables as an error when substituting.
# -f  Disable file name generation (globbing).
# -o option-name
# pipefail     the return value of a pipeline is the status of
#              the last command to exit with a non-zero status,
#              or zero if no command exited with a non-zero status
set -euf -o pipefail
```

## ZSH

Zee Shell.  

```sh
# show zsh options
zsh 

man zsh

set -o
setopt  
```

```sh
setopt extendedglob
ls ^d*.txt
unsetopt extendedglob
```

## Resources

* The Set Builtin [here](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html)  
* Clobbering [here](https://en.wikipedia.org/wiki/Clobbering)  
* How can I list Bash's options for the current shell? [here](https://unix.stackexchange.com/questions/210158/how-can-i-list-bashs-options-for-the-current-shell)  
* How to restore the value of shell options like `set -x`? [here](https://unix.stackexchange.com/questions/310957/how-to-restore-the-value-of-shell-options-like-set-x)  
