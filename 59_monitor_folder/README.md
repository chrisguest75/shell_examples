# README

Demonstrate how to monitor a folder for changes.  

## Prereqs

```sh
apt install inotify-tools
```

## Example

```sh
mkdir -p ./test
./notify.sh "./test"
```

## Docker

Try the notify behaviour inside a container.  

NOTE: This should be tried on MacOS and Linux to check behaviour  

### Build

```sh
# build the image
docker build --no-cache --progress=plain -t monitor . 
```

### Run

```sh
# run a command 
docker run --rm -it -v$(realpath ./test):/share monitor
```

## Resources

* script-to-monitor-folder-for-new-files [here](https://unix.stackexchange.com/questions/24952/script-to-monitor-folder-for-new-files)

https://stackoverflow.com/questions/8699293/how-to-monitor-a-complete-directory-tree-for-changes-in-linux/64107015#64107015

https://unix.stackexchange.com/questions/323901/how-to-use-inotifywait-to-watch-a-directory-for-creation-of-files-of-a-specific