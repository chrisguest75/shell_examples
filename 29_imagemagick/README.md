# README

* convert an image into 


```sh
convert ./departures/build-global-departures/add-new-config.png -resize 50%x ./departures/build-global-departures/add-new-config.png            

cheatsheet convert  
# Resize an image to a fixed width and proportional height:
convert original-image.jpg -resize 100x converted-image.jpg

# Resize an image to a fixed height and proportional width:
convert original-image.jpg -resize x100 converted-image.jpg

# Resize an image to a fixed width and height:
convert original-image.jpg -resize 100x100 converted-image.jpg

# Resize an image and simultaneously change its file type:
convert original-image.jpg -resize 100x converted-image.png

# Resize all of the images within a directory, using a for loop:
for file in original/image/path/*; do
    convert "$file" -resize 150 converted/image/path/"$file"
done

```

convert ./CUDDLY.png ./CUDDLY.jpg 
 jp2a --width=160 -i CUDDLY.jpg --output=tmp.txt        

 # dark background 
jp2a --width=160 CUDDLY.jpg --output=tmp.txt            

jp2a --width=320 CUDDLY.jpg --output=tmp.txt  

jp2a --width=320 cuddly_logo1.jpg --output=cuddly.txt  