# README
Examples of using imagemagick to process images.  

```cheatsheet convert```  

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