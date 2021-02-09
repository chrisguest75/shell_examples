#!/usr/bin/env bash

OUT=./letters

ord() {
  LC_CTYPE=C printf '%d' "'$1"
}

#67 C
#85 U
#68 D
#68 D
#76 L
#89 Y
text=$1
textlen=${#text}
filelist=""
for index in $(seq 0 $(( textlen - 1)) ); 
do 
    letter=${text:$index:1}
    #echo $letter
    #echo $(ord $letter)
    filelist="$filelist ${OUT}/$(ord $letter).jpg"
done
#echo $filelist

convert $filelist +append banner.jpg
#jp2a --term-width --colors --color-depth=24 --fill ./banner.jpg
jp2a --width=$(( textlen * 32 )) --colors --color-depth=24 --fill ./banner.jpg
