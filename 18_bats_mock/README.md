# README.md
Demonstrate how to mock dependencies with bats-mock

## Prerequisites
```sh
brew install bats-core

# Add some proper asserts to tests
git clone https://github.com/bats-core/bats-support test/test_helper/bats-support
git clone https://github.com/bats-core/bats-assert test/test_helper/bats-assert  
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
