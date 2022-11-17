# README

Demonstrates how to initiate an internal function as a job.

The jobs are local to the script process.

## Example

Run the example.  It runs a couple of functions as background jobs and then kills them.  

```sh
# use defaults
./call_function_async_killjobs.sh                           

# use iterations and wait time overrides
./call_function_async_killjobs.sh 10 10 2 4                            
```

## Run using screen

We can run the script in as a background screen terminal.  

```sh
# start a detached session (you can detach with ctrl+a d)
screen -dmS asyncsession1 ./call_function_async_killjobs.sh 10 20 2 5

# Now list screens 
screen -list

# View processes
ps -a 

# Attach to screen
screen -r <name>
```
