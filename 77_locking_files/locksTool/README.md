# README

Demonstrates how to build and single step debug a CPP program using `cmake`  

`vscode` extensions [README.md](../README.md)  

## Build and Run

Select the Terminal > Run Build Task command.

```sh
brew install cmake

# make from terminal

mkdir -p build
cd build
cmake ..

cmake --build .

./locks
```

## Debugging

Use the debugger in `vscode`  

## Resources

* Drop Autotools for CMake [here](https://opensource.com/article/21/5/cmake)  
* C/C++ for Visual Studio Code [here](https://code.visualstudio.com/docs/languages/cpp)  
