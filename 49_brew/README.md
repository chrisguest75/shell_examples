# README
Demonstrate how to create a brew package. 

TODO:
* Build a homebrew package.
* Show some examples of updating and outdated
* Do a linuxbrew and homebrew example.  

Questions:
* Local packages/taps?

## How it works
* To create an official formula you'll need to create a PR on the brew repository [here](https://github.com/Homebrew/homebrew-core)
* Taps are third party packages [Taps](https://docs.brew.sh/Taps)
* Formulas are the scripts that install the software [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)


### Directories
```sh
# installation directory
ls /usr/local/Homebrew  

# list formulas installed
ls /usr/local/Cellar     
# casks are macnative apps
ls /usr/local/Caskroom

# view the download cache
ls -la $(brew --cache)               
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
cp ./git-activity.rb $(brew --repo homebrew/core)/Formula/git-activity.rb    

# once copied into the main repo we have a formula to get info on
brew info git-activity       

# we can audit it (downloads and installs some tooling) 
brew audit --new git-activity

# NOTE: this will print out the hash it you change the release bin
brew install --build-from-source --verbose --debug git-activity

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
