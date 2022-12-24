# README

Demonstrate how to use options in shell.  

TODO:

* Work out how to push and pop options.  

- [README](#readme)
  - [List options](#list-options)
  - [Example](#example)
    - [Auto-exporting variables](#auto-exporting-variables)
    - [No clobbering of files](#no-clobbering-of-files)
    - [Debugging](#debugging)
    - [Pipefail and scripts](#pipefail-and-scripts)
  - [Resources](#resources)

## List options

```sh
# show bash options
bash

set -o
shopt | grep "on$"
```

```sh
# show zsh options
zsh 

set -o
setopt  
```

```sh
# print out current options
echo $- 
```

## Example

### Auto-exporting variables  

Read an env file and export each entry.  

```sh
set -a
. ./.env.template
set +a
env
```

### No clobbering of files  

```sh
set +o noclobber
set -o 
set -o noclobber
```

### Debugging

Use the following shebang for debugging  

```sh
#!/bin/bash -x
```

### Pipefail and scripts

```sh
set -euf -o pipefail
```

## Resources

* The Set Builtin [here](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html)  
* Clobbering [here](https://en.wikipedia.org/wiki/Clobbering)  
* How can I list Bash's options for the current shell? [here](https://unix.stackexchange.com/questions/210158/how-can-i-list-bashs-options-for-the-current-shell)  
* How to restore the value of shell options like `set -x`? [here](https://unix.stackexchange.com/questions/310957/how-to-restore-the-value-of-shell-options-like-set-x)  
