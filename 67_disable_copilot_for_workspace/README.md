# README

A script to disable extensions by workspace.  

`vscode` has he ability to disable extensions by workspace.  For my work repos I'd like to be able to disable `GitHub.copilot` across all those workspace automatically.  

TODO:

* Can I get to work on linux as well?
* Test if workspace folder exists.
* Seems to be a problem with vscode caching.
* Get it to load a set of extensions to install and disable from a config file
* Write it in golang
* Get a list of all installed extensions and run against a whitelist.  

## Examples

```sh
# show help
./disable-copilot.sh

# list all the workspaces
./disable-copilot.sh --list

# status of copilot for workspace
./disable-copilot.sh --status --workspace=react_examples

# disable copilot for workspace
./disable-copilot.sh --disable --workspace=react_examples

# enable copilot for workspace
./disable-copilot.sh --enable --workspace=react_examples

# start vscode in folder
./disable-copilot.sh --start --workspace=react_examples
```

## Resources

