# CONTROLLING PROCESSES

Demonstrate ways to use subshells and processes  

TODO:

* Reading from file description created with process substitution

NOTES:

* Command substitution ($(...)) will be replaced by the output of the command, while process substitution (<(...)) will be replaced by a filename from which the output of the command may be read.  

## Run

### Async

One liners.  

```sh
# wait for sleep to complete
sleep 10 && echo "hello world"

# run sleep in the background
(sleep 10 &) && echo "hello world"
```

### Process and Command Substitution

```sh
# command substitution
current=$(pwd) && echo $current

# process substitution
current=<(pwd) && echo $current
cat <(pwd)

# this does not work as the file descriptor gets shut down
current=<(pwd) && cat "$current"
current=<(pwd) && read <<<$current
```

## Resources

