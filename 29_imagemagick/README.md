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

# Resize an image ignoring aspect ratio (without exclamation mark all resizes maintin aspect ratio)
convert ./source_image.jpg -resize "100x200\!" ./out/convert_image_50p_x.png  

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

## Image Difference

Compare two images for differences.  

```sh
# highlight mask of where differences are
compare ./out/image1.png ./out/image2.png -compose src diff.png

# subtract the differences
magick composite ./out/image1.png ./out/image2.png -compose difference diff_magick.png
```

## Zoom

```sh
# zoom and morph
convert ./second_image.jpg ./source_image.jpg -morph 30 \
        -duplicate 1,-2-1 -coalesce \
        -gravity center -extent 640x480 \
        -set delay '%[fx:(t>0&&t<n-1)?10:60]' \
        -loop 0 ./out/zoom.gif
```

## Checkerboard

Create a basic checkerboard.  

```sh
magick -size 1920x1080 pattern:checkerboard -auto-level +level-colors red,blue ./out/checkerboard.png
```

## Resources

* A lot of example scripts [here](http://www.fmwconcepts.com/imagemagick/magicwand/index.php)  
* An example set of edge detections [here](https://blog.jiayu.co/2019/05/edge-detection-with-imagemagick/)
* Image comparison [here](https://imagemagick.org/Usage/compare/)
* ImageMagick/ImageMagic [repo](https://github.com/ImageMagick/ImageMagick)  
* Modifying Built-in IM Patterns/Tiles [here](https://usage.imagemagick.org/canvas/#pattern)