# README.md
Demonstrate how to mock dependencies with bats-mock

## Technical details
The script that is under test is sourced rather than run. 
We use the mocking library to redirect call to internal functions or external commands. 
We then control the output of those functions so we can test behaviour of the script under test.


## Prerequisites
```sh
brew install bats-core

# Add some proper asserts to tests
git clone https://github.com/bats-core/bats-support test/test_helper/bats-support
git clone https://github.com/bats-core/bats-assert test/test_helper/bats-assert  
git clone https://github.com/grayhemp/bats-mock test/test_helper/bats-mock
```

## Walkthrough
Wlll show the usage
```bash
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

Run a sinlge test file
```sh
bats -t ./test/tests.bats
```

## Debugging 
```sh
export DEBUG_BATS=1   
./run_tests.sh   
```