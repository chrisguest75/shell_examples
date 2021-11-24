# README

Examples of using imagemagick to process images.  

Cheatsheet has some commands `cheatsheet convert`.  

## Install

```sh
# linuxbrew & homebrew
brew install imagemagick

# debian
apt install imagemagick
```

## Info

```sh
# get type info on a file 
file ./image_00001.png

# imagemagick tool for identifying type
identify ./image_00001.png
```

## Resize

```sh
# create output          
mkdir ./out

# Resize an image to a fixed width and proportional height:
convert ./source_image.jpg -resize 100x ./out/convert_image_100x.jpg

# Resize an image to a fixed height and proportional width:
convert ./source_image.jpg -resize x100 ./out/convert_image_x100.jpg

# Resize an image to a fixed width and height:
convert ./source_image.jpg -resize 100x100 ./out/convert_image_100x100.jpg

# Resize an image and simultaneously change its file type:
convert ./source_image.jpg -resize 50%x ./out/convert_image_50p_x.png  

# Resize all of the images within a directory, using a for loop:
for file in original/image/path/*; do
    convert "$file" -resize 150 converted/image/path/"$file"
done
```

## Change colour model

Sometimes you may wish to force a colour model so a particular package can load it.

```sh
# remove the auto greyscale save for imaes only containing greyscale
convert oldgrey.png -define png:color-type=6 newrgb.png
```

## Mask out regions

```sh
# create output          
mkdir ./converted_frames

for file in ./frames/headlooktest_*.jpg; do
    # remove extension
    outname="${file%.*}"
    convert "$file" -fill white -draw "rectangle 0,0 500,720 rectangle 750,0 1280,720" ./converted_frames/"$(basename $outname).bmp"
done
```

## Resources

* A lot of example scripts [here](http://www.fmwconcepts.com/imagemagick/magicwand/index.php)  
* An example set of edge detections [here](https://blog.jiayu.co/2019/05/edge-detection-with-imagemagick/)

