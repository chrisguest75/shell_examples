# README
Demonstrate how to create a brew package. 

TODO:
* Build a homebrew package.
* Show some examples of updating and outdated
* Do a linuxbrew and homebrew example.  

```sh
brew list coreutils  
```

```sh
brew list 
brew list --cask
```

```sh
brew developer off
brew developer on 
```

```sh
export HOMEBREW_EDITOR=code
brew create --set-name git-activity https://github.com/chrisguest75/shell_examples/releases/download/0.0.1-f43376d/git-activity-release.tar.gz 
``` 

```sh
brew audit --new git-activity
```

```sh
brew --repo homebrew/core        
code $(brew --repo homebrew/core)    

cp ./git-activity.rb $(brew --repo homebrew/core)    
```


```sh
brew info git-activity       

# this is failing 
brew install --debug git-activity 

```

# Resources 
* Creating homebrew package blog [here](https://medium.com/ballerina-techblog/how-to-create-your-own-homebrew-package-or-formula-8dfbf8e001d3)
* Brew API [here](https://rubydoc.brew.sh/Formula)
* Formula cookbook [here](https://docs.brew.sh/Formula-Cookbook)
* Maintaining Taps [here](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
