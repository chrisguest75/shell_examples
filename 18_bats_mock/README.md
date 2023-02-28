# README

Demonstrate how to mock dependencies with bats-mock

NOTE: Also check [13_bats](../13_bats/README.md)

## Technical details

The script that is under test is sourced rather than run.  
We use the mocking library to redirect call to internal functions or external commands.  
We then control the output of those functions so we can test behaviour of the script under test.  

## Prerequisites

```sh
# check version 
brew info bats-core

# install it
brew install bats-core
```

Add some supporting libraries  

```sh
cd ./18_bats_mock

# Add some proper asserts to tests
git clone https://github.com/bats-core/bats-support test/test_helper/bats-support
git clone https://github.com/bats-core/bats-assert test/test_helper/bats-assert  
git clone https://github.com/grayhemp/bats-mock test/test_helper/bats-mock
```

NOTE: There is a new version of this - https://github.com/buildkite-plugins/bats-mock


## Walkthrough

```bash
# Show the usage
./script_to_test.sh 
```

Will filter the git log on finding #

```bash
./script_to_test.sh \#  
```

## Run Tests

Run all the tests  

```sh
./run_tests.sh      
```

Run a single test file

```sh
bats -t ./test/tests.bats

# JUnit test results
bats -t ./test/tests.bats --formatter junit -T
```

## Selective

Filtering tests is possible using a regex  

```sh
./test/tests.bats -f "script_to_test"
```

## Debugging

```sh
# Output in tap format (shows setup and shutdown logs)
export DEBUG_BATS=true  
bats -t test/tests.bats 
unset DEBUG_BATS 
```

## Resources

* bats-core repo [here](https://github.com/bats-core)  
* Welcome to bats-core’s documentation! [here](https://bats-core.readthedocs.io/en/stable/)  
* bats-mock repo [here](https://github.com/grayhemp/bats-mock)  
