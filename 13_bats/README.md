# README

Demonstrate how to unittest functions with bats-core

NOTE: Also check [18_bats_mock](../18_bats_mock/README.md)

## Prerequisites

```sh
# check version 
brew info bats-core

# install it
brew install bats-core

# install vscode extension
code --install-extension jetmartin.bats  
```

Add some supporting libraries  

```sh
cd ./13_bats

# Add some proper asserts to tests
git clone https://github.com/bats-core/bats-support test/test_helper/bats-support
git clone https://github.com/bats-core/bats-assert test/test_helper/bats-assert  
git clone https://github.com/bats-core/bats-file test/test_helper/bats-file 
```

## Investigating code for bats

```sh
# install path
which bats
# show symlink
ls -al /usr/local/bin/bats   
# show installed files
ls -la /usr/local/Cellar/bats-core/1.6.0
# cat readme
cat /usr/local/Cellar/bats-core/1.6.0/README.md     
```

## Running tests (in shell)

```sh
# show help
test/tests.bats --help

# Pretty printed tests
bats test/tests.bats 
test/tests.bats 

# JUnit test results
bats -t ./test/tests.bats --formatter junit -T

# Output in tap format (shows setup and shutdown logs)
export DEBUG_BATS=true  
bats -t test/tests.bats 
unset DEBUG_BATS
```

## Selective

Filtering tests is possible using a regex  

```sh
./test/tests.bats -f "add_trailing_slash - No parameter"
./test/tests.bats -f "add_trailing_slash"
./test/tests.bats -f "trim"
```

## Running tests (in docker)

```sh
docker run -it bats/bats:1.6.0 --version
docker run -it -v $(pwd):/mnt --workdir /mnt bats/bats:1.6.0 test/tests.bats         
```

## Resources

* bats-core repo [here](https://github.com/bats-core)  
* Welcome to bats-core’s documentation! [here](https://bats-core.readthedocs.io/en/stable/)
