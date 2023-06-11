# README

Demonstrate how `just` can be used like package.json scripts.  

NOTES:

* It seems very fast at executing.  

TODO:

* Variables
* Functions
* Logic
* Choose

## Install

```sh
brew info just

# install
brew install just
brew upgrade just

just --version  
just --help    
```

## Examples

### Shebang

```sh
# the shebang works
./justfile echovars

# run echo with defaults
./justfile echo

# run echo with parameters
./justfile echo parameter1 parameter2
```

### Simple

Simple example to demonstrate a few concepts.  

```sh
# list recipes
just -f ./example.justfile

# run silentecho  
just -f ./example.justfile echo parameter1 parameter2

# run silentecho  
just -f ./example.justfile silentecho

# show envvars
just -f ./example.justfile echovars
```

### Docker Example

```sh
# list recipes
just -f ./docker.justfile

# run list-images
just -f ./docker.justfile list-images

# run build
just -f ./docker.justfile build
```

## Resources

* casey/just repo [here](https://github.com/casey/just)  
* casey/just repo example [here](https://github.com/casey/just/blob/master/justfile)  
