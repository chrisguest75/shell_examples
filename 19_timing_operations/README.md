# README 
Demonstrate how to time operations in the shell to help with optimisation.

Example usage can be found [here](https://github.com/chrisguest75/docker_build_examples/tree/volume_images/36_layers_speed)

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