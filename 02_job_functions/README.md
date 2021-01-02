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
screen ./call_function_async_killjobs.sh 100 200 2 5 

# Detach with ctrl+a d

# View processes
ps -a 

# Now list screens 
screen -list

ps -t <ttyid>


```

