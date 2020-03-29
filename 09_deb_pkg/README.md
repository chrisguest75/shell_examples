# README
Demonstrates building a .deb packages

## Example
Build the debian package
```sh
dpkg-deb --build hello-world
```

Build the debian repository
```sh
docker build -f Dockerfile -t aptrep .
```

Host the repository
```sh
docker run --name aptrep --rm -d -p 8080:80 aptrep
curl localhost:8080
curl localhost:8080/debian/hello-world-1.0_amd64.deb
curl localhost:8080/debian/Packages.gz
```

Install the package from the repository
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
docker run --name aptrep --rm -it --entrypoint=/bin/bash aptrep 
```




