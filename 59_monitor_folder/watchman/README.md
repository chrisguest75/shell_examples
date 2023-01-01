# README

Demonstrate how to monitor a folder for changes using `watchman`.  

## Docker

Try the notify behaviour inside a container.  

NOTE: This should be tried on MacOS and Linux to check behaviour  

### Build

```sh
# build the image
docker build -f Dockerfile --no-cache --progress=plain -t watchman . 
```

### Run

```sh
mkdir -p ./test
# run a command 
docker run --rm -it -v$(realpath ./test):/share --name watchman watchman

# second window
docker exec -it watchman /bin/bash  

# show current watchers 
watchman watch-list
watchman trigger-list /share

# show what it is filtering 
watchman find /share '*.txt'

# if you copy a file you'll see it triggers the script.
cat /scratch/watcher.log 
```

Now create, modify and delete files in the `./test` folder.  

## Resources

* A file watching service [here](https://facebook.github.io/watchman/)  
* facebook/watchman repo [here](https://github.com/facebook/watchman)  
