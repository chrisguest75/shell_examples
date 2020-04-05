# README.md
Demonstrate how to unittest functions with bats-core

## Prerequisites
```sh
brew install bats-core

# Add some proper asserts to tests
git clone https://github.com/ztombol/bats-support test/test_helper/bats-support
git clone https://github.com/ztombol/bats-assert test/test_helper/bats-assert  
```

## Investigating code for bats. 
```sh
which bats
ls -al /usr/local/bin/bats   
ls -la /usr/local/Cellar/bats-core/1.1.0
cat /usr/local/Cellar/bats-core/1.1.0/README.md   
```

## Running tests (in shell)
```sh
# Pretty printed tests
bats test/tests.bats 
test/tests.bats 

# Output in tap format (shows setup and shutdown logs)
export DEBUG_BATS=true  
bats -t test/tests.bats 
unset DEBUG_BATS
```

## Running tests (in docker)
```sh
docker run -it bats/bats:latest --version
docker run -it -v $(pwd):/mnt --workdir /mnt bats/bats:latest test/tests.bats         
```
