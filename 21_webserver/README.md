# README

Hosting a basic webserver using bash.

Original: [sinatra](https://github.com/benrady/shinatra)

## Run

```sh
# Setup the server
./webserver.sh 8081 "Hello from bash" &
```

```sh
# Make client request
curl -vvvv localhost:8081/clientpath
```

