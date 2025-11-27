# DOTSOURCING

Demonstrate how to use dot-sourcing.  

NOTES:

* Dot sourced files do not need execute permissions.  

## Reason

The ability to dot source scripts gives us the ability to merge scripts into shell sessions.  

## Examples

```sh
# not dot sourced
./test-dotsource.sh            
```

```sh
# attempt to dot source
. ./test-dotsource.sh            
```

```sh
# permissions test
ls -al
. ./dot.sh
```



## Resources

* How to detect if a script is being sourced [here](https://stackoverflow.com/questions/2683279/how-to-detect-if-a-script-is-being-sourced)
