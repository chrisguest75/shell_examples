# README
An old skool banner printer. 

Uses imagemagick and jp2a to convert strings to banners in the terminal 

Cut out tiles and concat them back together based on a string.  

## Shell 
```sh
# defaults
./banner.sh --banner="HELLOWORLD" 

# examples
./banner.sh --banner="HELLOWORLD" --font=./fonts/carebear.jpg -w=26 -h=26 -c=12 -r=5
./banner.sh --banner="HELLOWORLD" --font=./fonts/cuddly.jpg --basea -w=32 -h=32 -c=10 -r=5
./banner.sh --banner="HELLOWORLD" --font=./fonts/knight4.jpg -w=32 -h=25 -c=10 -r=5

# more examples
./banner.sh --banner="ALPHA" --font=./fonts/carebear.jpg -w=26 -h=26 -c=12 -r=5
./banner.sh --banner="BETA" --font=./fonts/cuddly.jpg --basea -w=32 -h=32 -c=10 -r=5
./banner.sh --banner="GAMMA" --font=./fonts/knight4.jpg -w=32 -h=25 -c=10 -r=5
```

## Docker image
```sh
# build image
docker build -t banner .

# render banners
docker run -e COLUMNS=${COLUMNS} banner
docker run -e COLUMNS=${COLUMNS} banner --banner="DOCKER" --font=/workbench/fonts/carebear.jpg -w=26 -h=26 -c=12 -r=5
docker run -e COLUMNS=${COLUMNS} banner --banner="DOCKER" --font=/workbench/fonts/cuddly.jpg --basea -w=32 -h=32 -c=10 -r=5
```
