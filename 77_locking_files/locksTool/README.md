# README

Demonstrates how to build and single step debug a CPP program using `cmake`  

Based on cpp_examples/01_helloworld_cmake [here](https://github.com/chrisguest75/cpp_examples/blob/main/01_helloworld_cmake/README.md)  

`vscode` extensions [README.md](../README.md)  

## Build and Run

Select the Terminal > Run Build Task command.  

```sh
brew install cmake
```

## Justfile

```sh
# show options 
./justfile 

# build the code
./justfile build

# run 
./justfile run_lock
./justfile run_open
```

## Manual

```sh
# create make
cmake -S . -B ./build

# build target
cmake --build ./build

# run 
./build/locks test=lock
./build/locks test=open

# cleanup
cmake --build ./build --target clean  
```



## Debugging

Use the debugger in `vscode`  

## Resources

* Drop Autotools for CMake [here](https://opensource.com/article/21/5/cmake)  
* C/C++ for Visual Studio Code [here](https://code.visualstudio.com/docs/languages/cpp)  
