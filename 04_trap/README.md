# README

Demonstrate `bash` trap handlers functionality  

TODO:

* This does not work if we use sleep 10000.  Have to work out how to find the sleep subprocess and send it a signal.  

## Examples

List the possible trap signals  

```sh
# in bash
bash 

# list traps
trap -l
 1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL       5) SIGTRAP
 6) SIGABRT      7) SIGEMT       8) SIGFPE       9) SIGKILL     10) SIGBUS
11) SIGSEGV     12) SIGSYS      13) SIGPIPE     14) SIGALRM     15) SIGTERM
16) SIGURG      17) SIGSTOP     18) SIGTSTP     19) SIGCONT     20) SIGCHLD
21) SIGTTIN     22) SIGTTOU     23) SIGIO       24) SIGXCPU     25) SIGXFSZ
26) SIGVTALRM   27) SIGPROF     28) SIGWINCH    29) SIGINFO     30) SIGUSR1
31) SIGUSR2
```

```sh
# debian
man 7 signal
```

## On ERR

```sh
# trap handler on an error
./trap_err_example.sh   
```

## On EXIT

```sh
# trap handler on exit
./trap_exit_example.sh   
```

## On DEBUG

```sh
# debug tracing with a handler
./trap_debug_example.sh   
```

## SIGINT

```sh
# handler on ctrl+c
./trap_ctrlc_example.sh   
```

## Sending signals to other processes

```sh
# list signals that can be sent
kill -l   

# terminal 1 (take note of pid)
./trap_common.sh

# terminal 2 (use pid)
kill -SIGTERM 19371
```

## Resources

* Traps docs [here](https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_12_02.html)  
