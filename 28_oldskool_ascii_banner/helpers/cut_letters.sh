#!/usr/bin/env bash

OUT=./letters
rm -rf "${OUT}"
mkdir "${OUT}"

letter=65
for row in $(seq 0 32 128); 
do
    for column in $(seq 0 32 288); 
    do
        convert ./cuddly.jpg -crop 32x32+${column}+${row} ${OUT}/${letter}.jpg
        letter=$(( letter + 1 ))
    done
done


