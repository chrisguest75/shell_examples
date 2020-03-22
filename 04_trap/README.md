# README
Demonstrate trap handlers functionality 

## Examples

List the possible trap signals
```sh
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
man 7 signal
```

```sh
./trap_err_example.sh   
```

```sh
./trap_exit_example.sh   
```

```sh
./trap_debug_example.sh   
```


```sh
# THIS IS NOT WORKING
./trap_ctrlc_example.sh   
```