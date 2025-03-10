# README

Demonstrate how `just` can be used like package.json scripts.

## Background

`npm` has the concept of scripts that developers use to provide common tasks such as "build" and "run". But when you're not in that ecosystem such as with `terraform` or `docker` then you find having to provide readme with quite complicated build commands or custom scripts. `just` allows a simple DSL to provide this functionality.

NOTES:

- It seems very fast at executing.
- It's a good alternative to using `package.json`
- `just` always runs in the directory of the just file.
- There seems to be some problems with where variables are evaluated.

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

You can cheat putting a shebang at the top of the justfile to make it executable.

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

# checks and confirmation
just -f ./example.justfile folders
```

### OS Specific

Tasks can be tagged for OSes.

NOTE: This is useful for tooling and cmdline differences.

```sh
# linux and mac differences
just -f ./os.justfile test
```

### Docker Example

Use `just` to script building and running containers.

```sh
# list recipes
just -f ./docker.justfile

# run list-images
just -f ./docker.justfile docker-images

# build container
just -f ./docker.justfile docker-build processor

# run container
just --timestamp -f ./docker.justfile docker-run processor

# testing internal functions
just --timestamp -f functions.justfile functions
```

## Timing

Try to show some timing on tasks.

REF: [19_timing_operations/README.md](../19_timing_operations/README.md)

```sh
# testing internal functions
just --timestamp -f timing.justfile mytask

# you can wrap the whole operation in time.
time just --timestamp -f timing.justfile mytask
```

## Multiline

Examples using multiline strings.

```sh
just -f ./multiline.justfile multiline1

just -f ./multiline.justfile multiline2
```

## Importing

Importing files containing tasks

```sh
just -f ./import.justfile docker-build
```

## Loops

A few example loops using bash rather than inbuilt.

```sh

just -f loops.justfile counter

just -f loops.justfile directory-listing
```

## Paths

Path handling in just.

```sh
# NOTE: default values cause problems
just -f paths.justfile paths-inbuilt

# Seems to work fine when you pass them in.
just -f paths.justfile paths-inbuilt ../52_xml/README.md
```

## Resources

- casey/just repo [here](https://github.com/casey/just)
- casey/just repo example [here](https://github.com/casey/just/blob/master/justfile)
