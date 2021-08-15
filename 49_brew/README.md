# README
Demonstrate how to create a brew package. 

TODO:
* Build a homebrew package.
* Show some examples of updating and outdated
* Put the git querying scripts into a package.  


brew list coreutils  

brew list 
brew list --cask


brew developer off
brew developer on 



export HOMEBREW_EDITOR=code
brew create https://github.com/chrisguest75/shell_examples/releases/download/0.0.1-865a1fd/git-activity-release.tar.gz

 sha256 "3269ef7af68ab0f6570dc12f9579bc36f9217b9f76c44ee0a4315a1e03d97baf"


/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/shell_examples.rb

brew audit --new shell_examples


shell_examples:
  * 1: col 1: Please remove default template comments
  * 3: col 1: Please remove default template comments
  * 5: col 33: Description shouldn't end with a full stop.
  * 6: col 12: Formula should have a homepage.
  * 11: col 3: Commented-out dependency "cmake" => :build
  * 14: col 5: Please remove default template comments
  * 15: col 5: Please remove default template comments
  * 18: col 5: Please remove default template comments
  * Formulae in homebrew/core must specify a license.
  * GitHub repository not notable enough (<30 forks, <30 watchers and <75 stars)
Error: 10 problems in 1 formula detected

brew --repo homebrew/core        
code $(brew --repo homebrew/core)    

# Resources 

https://medium.com/ballerina-techblog/how-to-create-your-own-homebrew-package-or-formula-8dfbf8e001d3

https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap

Brew API
https://rubydoc.brew.sh/Formula


https://docs.brew.sh/Formula-Cookbook

