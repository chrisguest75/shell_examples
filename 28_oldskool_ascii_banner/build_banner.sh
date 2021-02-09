#!/usr/bin/env bash

OUT=./letters

#67 C
#85 U
#68 D
#68 D
#76 L
#89 Y

convert ${OUT}/67.jpg ${OUT}/85.jpg ${OUT}/68.jpg ${OUT}/68.jpg ${OUT}/76.jpg ${OUT}/89.jpg +append banner.jpg
jp2a --term-width --colors --color-depth=24 --fill ./banner.jpg