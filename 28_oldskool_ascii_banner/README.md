# README
An old skool banner printer. 

Uses imagemagick and jp2a to convert strings to banners in the terminal 

```sh
# defaults
./banner.sh --banner="HELLOWORLD" 

# examples
./banner.sh --banner="HELLOWORLD" --font=./fonts/carebear.jpg -w=26 -h=26 -c=12 -r=5
./banner.sh --banner="HELLOWORLD" --font=./fonts/cuddly.jpg --basea -w=32 -h=32 -c=10 -r=5
./banner.sh --banner="HELLOWORLD" --font=./fonts/knight4.jpg -w=32 -h=25 -c=10 -r=5

```


```sh
./banner.sh --banner="ALPHA" --font=./fonts/carebear.jpg -w=26 -h=26 -c=12 -r=5
./banner.sh --banner="BETA" --font=./fonts/cuddly.jpg --basea -w=32 -h=32 -c=10 -r=5
./banner.sh --banner="GAMMA" --font=./fonts/knight4.jpg -w=32 -h=25 -c=10 -r=5
```

## Docker image
```sh
docker build -t banner . 
docker run -e COLUMNS=${COLUMNS} banner
```
