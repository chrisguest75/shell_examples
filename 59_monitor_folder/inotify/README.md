# README

Demonstrate how to monitor a folder for changes using `inotify`.  

## Local Example (linux only)

```sh
apt install inotify-tools
```

```sh
# linux only
mkdir -p ./test
./notify.sh "./test"
```

## Docker

Try the notify behaviour inside a container.  

NOTE: This should be tried on MacOS and Linux to check behaviour  

### Build

```sh
# build the image
docker build -f Dockerfile --no-cache --progress=plain -t monitor . 
```

### Run

```sh
mkdir -p ./test
# run a command 
docker run --rm -it -v$(realpath ./test):/share monitor
```

Now create, modify and delete files in the `./test` folder.  

## Resources

* script-to-monitor-folder-for-new-files [here](https://unix.stackexchange.com/questions/24952/script-to-monitor-folder-for-new-files)  
* How to monitor a complete directory tree for changes in Linux? [here](https://stackoverflow.com/questions/8699293/how-to-monitor-a-complete-directory-tree-for-changes-in-linux/64107015#64107015)  
* How to use inotifywait to watch a directory for creation of files of a specific extension [here](https://unix.stackexchange.com/questions/323901/how-to-use-inotifywait-to-watch-a-directory-for-creation-of-files-of-a-specific)  
* Is there a command like "watch" or "inotifywait" on the Mac? [here](https://stackoverflow.com/questions/1515730/is-there-a-command-like-watch-or-inotifywait-on-the-mac)  
