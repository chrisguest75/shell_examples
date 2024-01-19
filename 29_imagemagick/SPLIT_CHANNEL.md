# Split and combine colour channels

## RGB

```sh
mkdir ./out

# show colorspaces 
convert -list colorspace   
convert -list channel   

# seperate channels
convert source_image.jpg -channel GB -evaluate set 0 ./out/R.png
convert source_image.jpg -channel RB -evaluate set 0 ./out/G.png
convert source_image.jpg -channel RG -evaluate set 0 ./out/B.png

# convert to raw
convert ./out/R.png -depth 8 ./out/R.rgb
convert ./out/G.png -depth 8 ./out/G.rgb
convert ./out/B.png -depth 8 ./out/B.rgb

# you can see the rgb values
cat ./out/R.rgb | xxd | more   
cat ./out/G.rgb | xxd | more   
cat ./out/B.rgb | xxd | more   

# show on one image
convert ./out/R.png ./out/G.png ./out/B.png -append ./out/combined-rgb.png

# recombine
convert ./out/R.png ./out/G.png -channel G -fx 'v' ./out/B.png -channel B -fx 'v' ./out/combined-rgb.png

# recombine in rgb
convert ./out/R.png ./out/G.png -channel G -fx 'v' ./out/B.png -channel B -fx 'v' ./out/combined-rgb.rgb
cat ./out/combined-rgb.rgb | xxd | more  
```

## YUV

```sh
mkdir ./out

# seperate channels
convert source_image.jpg -colorspace YUV -sampling-factor 4:2:2 -separate ./out/YUV.yuv

cat ./out/YUV-0.yuv | xxd | more  
cat ./out/YUV-1.yuv | xxd | more  
cat ./out/YUV-2.yuv | xxd | more  

convert source_image.jpg -colorspace YUV -sampling-factor 4:2:2 -separate ./out/YUV.png

convert ./out/YUV-0.png ./out/YUV-1.png ./out/YUV-2.png -append ./out/combined-yuv-append.png

# COMBINING THEM IS NOT WORKING
convert ./out/YUV-0.png ./out/YUV-1.png ./out/YUV-2.png -combine -colorspace YUV ./out/combined-yuv.yuv
convert ./out/combined-yuv.yuv -colorspace RGB ./out/combined-yuv.png

convert ./out/YUV-2.png ./out/YUV-1.png ./out/YUV-0.png -combine -colorspace RGB ./out/combined-yuv.png

cat ./out/YUV-0.png ./out/YUV-1.png ./out/YUV-2.png  > ./out/combined.yuv
ffmpeg -s 3840x2160 -pix_fmt yuv422p -i ./out/combined.png ./out/combined.yuv


```
