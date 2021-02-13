# README
Demonstrate how to use whiptail for file selection.

## Configure

```sh
# Debian
apt install whiptail

# MacOS
brew install newt
```

## Create test files
```sh
# create temporary files
mkdir ./files
touch ./files/selection_file{1..4}.txt
```

## Run 

```sh
./file_selector.sh
```

Example:
[Filebrowse](https://github.com/pageauc/FileBrowser/blob/master/filebrowse.sh)