# README
Demonstrates techniques for using sed to process files.

## Examples 
This technique can be used for any platform hosting nginx in a container where a port remap to a arbitrary number is required. i.e. CloudRun, Heroku, etc.

```sh
# modify the config file
export PORT=9123
# macosx
sed -i .bak "s/listen[ ]*80;/listen $PORT;/g" ./nginx.conf  
# linux
sed -i.bak "s/listen[ ]*80;/listen $PORT;/g" ./nginx.conf  
```

# Resources
* `cheatsheet sed`


