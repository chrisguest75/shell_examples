# README

Demonstrates how to build a script with simple argument parsing.  

You can modify this basic script `example.sh` to create new scripts that accept arguments.  

Features include:

* Flag values such as --debug
* Long and abbreviated options
* Value based options --option=value
* Case switched options
* Heredoc help example
* Shellchecked

For more simple scripts there is a more `simple_example.sh`  

## Example usage

Run through the following examples

```sh
# No args prints usage
./example.sh                               

# Print usage
./example.sh --help

# Perform ls action
./example.sh --action=ls

# Perform ps action
./example.sh --action=ps

# Pass in multiple flags to ls
./example.sh --action=ls -f=-l -f=-R -f=-a --debug    
```

## Simple Example usage

Run through the following examples

```sh
# No args performs work
./simple_example.sh                               

# Print usage 
./simple_example.sh --help
```
