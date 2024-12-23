# MAKEFILES

GNU make utility to maintain groups of programs

NOTES:

* Tabs not spaces (use vscode spaces status bar to set tabs)

## Versions and Flavours

```sh
# macos
make --version

>GNU Make 3.81
>Copyright (C) 2006  Free Software Foundation, Inc.
```

## Task Processsing

We use .PHONY to create a target that can be processed

```sh
cd ./taskprocessing

# will process first target
make 

# process a specific target 
make target1
```

## Basics

```sh
cd ./basics

# will process first target
make 

make clean
# process a specific target 
make VARIABLE1=this_is_an_override
```

## Resources

* A Simple Makefile Tutorial [here](https://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/)
* Appendix B Errors Generated by Make [here](https://www.gnu.org/software/make/manual/html_node/Error-Messages.html)  

