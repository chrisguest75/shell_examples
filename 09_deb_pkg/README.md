# README

Demonstrates building a .deb packages repository

For help with installing Debian packages [README.md](../35_apt_and_dpkg/README.md)  

TODO:

* Look at adequate - https://manpages.debian.org/testing/adequate/adequate.1.en.html

## Build .deb Examples

Build the image to build the packages and index  

```sh
docker build -t debianbuilder -f build.Dockerfile . 
```

Build the debian package in Docker  

```sh
mkdir packages
docker run -it -v=$(pwd):/packages debianbuilder --action=build -p=hello-world -o=./packages/   
```

## Build Packages.gz

```sh
docker run -it -v=$(pwd):/packages debianbuilder --action=package -p=packages

# Add --debug to it if you want to check paths in index
docker run -it -v=$(pwd):/packages debianbuilder --action=package -p=packages --debug
```

## Host and acesss repository

Host the repository

```sh
docker build -f hostpackages.Dockerfile -t hostpackages .  
docker run --name hostpackages --rm -d -p 8080:80 hostpackages
open http://localhost:8080  
curl localhost:8080
curl localhost:8080/debian/packages/hello-world_1.0_all.deb
curl localhost:8080/debian/Packages.gz
```

## Use the package

Install the package into a Docker container  

```sh
docker build --build-arg=REPOSITORY_URL=http://0.0.0.0:8080/debian --network="host" -t usepackages --no-cache -f usepackages.Dockerfile . 
docker stop hostpackages
```

Install the package from the repository locally  

```sh
echo "deb [trusted=yes] http://localhost:8080/debian ./" | sudo tee -a /etc/apt/sources.list > /dev/null 
sudo apt-get update   
sudo apt-get install hello-world  

which hello-world.sh
hello-world.sh

sudo apt-get remove hello-world  

sudo add-apt-repository -r "deb [trusted=yes] http://localhost:8080/debian ./"
cat /etc/apt/sources.list
docker stop aptrep
```

## Troubleshooting

Get access inside the container.  

```sh
# Debug deb build or packaging
docker run -it -v=$(pwd):/packages --entrypoint /bin/bash debianbuilder

# Debug repository
docker run --name hostpackages --rm -it --entrypoint=/bin/bash hostpackages 

# Debug use package
docker run -it --entrypoint /bin/bash usepackages 

# Base 
docker run -it --entrypoint=/bin/bash ubuntu:16.04 
```
