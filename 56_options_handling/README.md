# README

Demonstrate how to use shell options in shell scripts.  

- [README](#readme)
  - [Bash](#bash)
    - [List options](#list-options)
    - [Auto-exporting variables](#auto-exporting-variables)
    - [No clobbering of files](#no-clobbering-of-files)
    - [Debugging](#debugging)
    - [Pipefail and scripts](#pipefail-and-scripts)
      - [Pushing and popping options](#pushing-and-popping-options)
  - [ZSH](#zsh)
  - [Resources](#resources)

## Bash

Bourne Again Shell.  

### List options

Set or unset values of shell options and positional parameters.  

| Flag            | Description |
|-----------------|-------------|
| allexport       | Automatically exports all variables created or modified. |
| emacs           | Enables an Emacs-style command line editing interface. |
| errexit         | Exits the shell immediately if a command exits with a non-zero status. |
| errtrace        | The ERR trap is inherited by shell functions. |
| functrace       | The DEBUG and RETURN traps are inherited by shell functions. |
| histexpand      | Enables history expansion, allowing re-use of commands from history. |
| history         | Saves commands in the command history. |
| ignoreeof       | Prevents exiting the shell using EOF (End Of File) characters like Ctrl+D. |
| keyword         | (Non-standard option, availability varies.) |
| monitor         | Enables job control, running processes in the background. |
| noclobber       | Prevents overwriting of existing files by redirection (e.g., `>`). |
| noexec          | Reads and checks commands without executing them. |
| nolog           | (Non-standard option, availability varies.) |
| notify          | Provides immediate job notification for background jobs. |
| onecmd          | Runs only one command and then exits. |
| physical        | Avoids resolving symbolic links when performing commands like `cd`. |
| posix           | Enables POSIX compliance mode. |
| privileged      | Enables privileged mode. |
| verbose         | Prints shell input lines as they are read. |
| vi              | Enables a Vi-style command line editing interface. |
| xtrace          | Prints commands and their arguments as they are executed. |
| braceexpand     | Enables brace expansion, allowing for generating arbitrary strings. |
| hashall         | Remembers the full pathname of commands to avoid searching the PATH each time. |
| interactive-comments | Enables the use of comments (`#`) in interactive shells. |
| noglob          | Disables filename expansion (globbing). |
| nounset         | Treats unset variables as an error when performing parameter expansion. |
| pipefail        | Ensures the exit status of a pipeline is the status of the last command to exit with a non-zero status, or zero if all commands exit successfully. |

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

There are a common set of options that scripts set to prevent hard to understand errors.  
However, not everyone is convinced with `-e` option as mentioned here in [Why doesn't set -e (or set -o errexit, or trap ERR) do what I expected?](https://mywiki.wooledge.org/BashFAQ/105).  

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

#### Pushing and popping options

NOTE: The reason we have to save both `$-` and `set +o` is because the `set +o` is run as a subprocess and not all options are inherited.  

```sh
# boilerplate saving and restoring options
local saveOptions=$-
local original_state=$(set +o | sort)
printf "$saveOptions\n"
printf "$original_state\n"

# override flags on and off
set +e
set -x
this_should_fail "test_error"
echo "exitcode: $?"

# restore the original shell options
eval "$original_state"
set -$saveOptions
```

Tests to show how it works.  

```sh
# show options and follow examples
./options_test.sh --help 

# pushing and popping options
./options_test.sh --debug --skip_error --error  
./options_test.sh --skip_error --error  
```

## ZSH

Zee Shell.  

```sh
# show zsh options
zsh 

man zsh

# list options 
set -o | sort 
# list options as "set" commands 
set +o | sort 
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
* Why doesn't set -e (or set -o errexit, or trap ERR) do what I expected? [here](https://stackoverflow.com/questions/55480492/is-there-a-clean-concise-way-to-push-pop-bash-verbose-and-xtrace-options-for-a)  
