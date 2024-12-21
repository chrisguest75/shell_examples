# TEXT

Examples of using text.  

## Examples

```sh
mkdir -p ./out

# OS fonts
magick -list font | grep Font

magick -background black -fill white -font Cantarell -pointsize 100 label:Anthony ./out/label.png

# custom fonts
magick -size 1920x1280 -background black -fill white -font ./fonts/kanit-bold.ttf -gravity center -pointsize 250 label:hello-world ./out/label.png

# text manipulation
read -d '' caption <<EOF
Conflict is the gadfly of thought.
It stirs us to observation and memory.
It instigates to invention.
It shocks us out of sheeplike passivity, 
         and sets us at noting and contriving
EOF

in_file="./source_image.jpg"
out_file="./out/test.png"

convert -size 1920x1280 xc:none -gravity center -stroke grey -pointsize 140 -font ./fonts/kanit-bold.ttf -strokewidth 3 -annotate +0+0 "${caption}" -blur 0x25 -level 0%,50% -fill white -stroke none -annotate +0+0 "${caption}" "${in_file}" +swap -gravity center -geometry +0-0 -composite "${out_file}"
```

## Resources

* ImageMagick Examples -- Text to Image Handling [here](https://usage.imagemagick.org/text/)  
