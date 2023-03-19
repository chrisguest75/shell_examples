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

just --version  
just --help    
```

## Examples

### Simple

```sh
just -f ./example.justfile

just -f ./example.justfile silentecho  

# show envvars
just -f ./example.justfile echovars           
```

### Docker

```sh
just -f ./docker.justfile

just -f ./docker.justfile list-images
just -f ./docker.justfile build
```

## Resources

* casey/just repo [here](https://github.com/casey/just)  
* casey/just repo example [here](https://github.com/casey/just/blob/master/justfile)  
