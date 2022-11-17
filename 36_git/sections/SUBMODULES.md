# SUBMODULES

Quick walkthrough of how to work with `submodules`.

NOTES:

* `vscode` handles the different submodules in the GUI.  

## Create repo

```sh
mkdir -p ./git_testing && cd ./git_testing
git init
```

## Add submodules

```sh
git submodule add git@github.com:chrisguest75/shell_examples.git
```

## Update

```sh
git clone --recurse-submodules git@github.com:chrisguest75/shell_examples.git
```

```sh
git submodule init
```

```sh
git submodule update --init
git submodule update --init --recursive
```

## Resources

* 7.11 Git Tools - Submodules [here](https://git-scm.com/book/en/v2/Git-Tools-Submodules)