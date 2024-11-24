# JUST CHEATSHEET

Tips:

* Put a comment above each task as a description  
* `just` always executes in folder of `justfile`
* There are functions available to perform string manipulation.
* With 1.37 we now have macros for ansi output.  

## Variables

```sh
# show internal variables
just -f example.justfile --variables

# render the variables. 
just -f example.justfile --evaluate

# override defaults
just -f example.justfile WORLD="helloworld" printworld
```

## Arguments

```sh
# pass the remaining arguemnts to the script
just -f example.justfile WORLD="helloworld" printargs --verbose --file=./file.txt
```

## Resources

* casey/just repo [here](https://github.com/casey/just)  
* casey/just repo example [here](https://github.com/casey/just/blob/master/justfile)  
