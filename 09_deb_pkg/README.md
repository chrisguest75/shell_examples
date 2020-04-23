# README
Demonstrates building a .deb packages repository

## Build .deb Examples 
Build the debian package locally (on linux)
```sh
dpkg-deb --build hello-world
```

Build the debian package in Docker
```sh
docker build -t builddeb -f builddeb.Dockerfile . 
docker run -it -e PACKAGE=hello-world -v=$(pwd):/packages builddeb
```

## Build Package
```sh
docker build -t buildpackages -f buildpackages.Dockerfile .
docker run -it -v=$(pwd):/packages buildpackages
```

## Host and acesss repository
Host the repository
```sh
docker build -f hostpackages.Dockerfile -t hostpackages .  
docker run --name hostpackages --rm -d -p 8080:80 hostpackages
open http://localhost:8080  
curl localhost:8080
curl localhost:8080/debian/hello-world-1.0_amd64.deb
curl localhost:8080/debian/Packages.gz
```

## Use the package
Install the package into a Docker container
```sh
docker build --build-arg=REPOSITORY_URL=http://0.0.0.0:8080/debian --network="host" -t usepackages --no-cache -f usepackages.Dockerfile . 
docker stop hostrepository
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
# Debug packaging
docker run -it -v=$(pwd):/packages --entrypoint /bin/bash buildpackages

# Debug repository
docker run --name hostrepository --rm -it --entrypoint=/bin/bash hostrepository 

# Debug use package
docker run -it --entrypoint /bin/bash usepackages 

# Base 
docker run -it --entrypoint=/bin/bash ubuntu:16.04 

```




