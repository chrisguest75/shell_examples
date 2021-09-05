# README
Demonstrate how to create a brew package. 

TODO:
* Build a homebrew package.
* Show some examples of updating and outdated
* Do a linuxbrew and homebrew example.  

Questions:
* Local packages/taps?

## How it works
* To create an official package you'll 
* Taps are third party packages

https://docs.brew.sh/Taps
https://docs.brew.sh/Formula-Cookbook

### Directories
```sh
# installation directory
ls /usr/local/Homebrew  

ls /usr/local/Cellar     
ls /usr/local/Caskroom

```

## Basic commands
```sh
# useful for debugging.
brew config   

# list the files in a package
brew list coreutils  
```

```sh
# list installed packages 
brew list 

# list only installed casks
brew list --cask

# list packages installed from taps
brew tap-info --installed   
```

```sh
# switching in and out of developer mode
brew developer off
brew developer on 
```

```sh
# open the location of the formulas for homebrew/core
brew --repo homebrew/core        
code $(brew --repo homebrew/core)    
```
## Install example
```sh
# !!! probably soft link instead of copy 
cp ./git-activity.rb $(brew --repo homebrew/core)    

# once copied into the main repo we have a formula to get info on
brew info git-activity       

# we can audit it 
brew audit --new git-activity

# this is failing 
brew install --debug git-activity 
brew install --interactive --debug git-activity

# test install
 ./git-activity.sh --path=$(git root) 

```


## Creation
```sh
export HOMEBREW_EDITOR=code
brew create --set-name git-activity https://github.com/chrisguest75/shell_examples/releases/download/0.0.1-f43376d/git-activity-release.tar.gz 
``` 


https://rubydoc.brew.sh/Homebrew/Assertions.html



# Resources 
* Creating homebrew package blog [here](https://medium.com/ballerina-techblog/how-to-create-your-own-homebrew-package-or-formula-8dfbf8e001d3)
* Brew API [here](https://rubydoc.brew.sh/Formula)
* Formula cookbook [here](https://docs.brew.sh/Formula-Cookbook)
* Maintaining Taps [here](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
