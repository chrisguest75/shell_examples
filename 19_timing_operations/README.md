# README

Demonstrate how to time operations in the shell to help with optimisation.

## Reasons

Always a good idea to understand about the performance of scripts. Understanding if it meets expectations.  

Example usage can be found [here](https://github.com/chrisguest75/docker_examples/blob/master/36_layers_speed/README.md)

TODO:

* hyperfine - https://github.com/sharkdp/hyperfine
* https://cr.yp.to/libtai/tai64.html
* https://www.reddit.com/r/commandline/comments/yle738/peculiar_shell_performance_differences_in/iuywce7

## Use EPOCHREALTIME

Simple example of measuring sleep 10 command

```sh
# microsecond 1 millionth of second
start=${EPOCHREALTIME}
sleep 10
end=${EPOCHREALTIME}
runtime=$(bc <<< "(${end} - ${start})")
echo "${runtime} seconds"
```

## Use time

Simple example of measuring sleep 10 command

```sh
time sleep 10     
```

## Time it over iterations

```sh
# add a custom function to time 
function under_test() {
    echo "Parameters $*"
    local sleeptime=1
    if [[ -n $1 ]]; then
        sleeptime=$1
    fi
    echo "sleep $sleeptime"
    sleep $sleeptime
}

# pass function to test, number of iterations and parameters to pass into the function (sleeptime of 2 in this case)
. ./time-it.sh under_test 10 2  
```
