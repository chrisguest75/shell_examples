#!/usr/bin/env bash

screenbuf=[]
declare -g -a screenbuf
declare -g -a sine

function generate_sine {
    local angle=0
    local step_angle=1
    local index=0
    local centreline=12
    local amplitude=10
    local PI=3.14159

    while [ $angle -le 359 ]
    do
        local sinx=$(awk "BEGIN{ printf \"%.12f\", ((sin($angle*($PI/180))*$amplitude)+$centreline)}")
        sinx=$(( (centreline * 2)-${sinx/.*} ))
        angle=$((angle+step_angle))
        sine[$index]=$sinx
        index=$(( index+1 ))
    done
}

function generate_background {
    printf "[$2 x $1]\n"    
    for line in $(seq 0 $1 ); 
    do
        local lineout=""
        for col in $(seq 0 $2); 
            do 
                local offset=$(( col + line )) 
                local r=$(( 255 - ( offset * 255 / 120 ) ))
                local g=$(( offset * 510 / 120 ))
                local b=$(( offset * 255 / 120 ))
                if [[ $g -gt 255 ]]; then 
                    g=$(( 510-g ))
                fi

                if [[ $r -lt 0 ]]; then 
                    r=0
                fi
                if [[ $g -lt 0 ]]; then 
                    g=0
                fi
                if [[ $b -lt 0 ]]; then 
                    b=0
                fi
                if [[ $r -gt 255 ]]; then 
                    r=255
                fi
                if [[ $g -gt 255 ]]; then 
                    g=255
                fi
                if [[ $b -gt 255 ]]; then 
                    b=255
                fi
                lineout="${lineout}\033[48;2;${r};${g};${b}m "                
        done
        screenbuf[$line]=$lineout
        #printf "${screenbuf[line]}"
    done
}

clear
SCREEN_Y=$(( $LINES - 2 ))
generate_background $SCREEN_Y $(( $COLUMNS - 1 ))
generate_sine
offset=0
yoffset=0
direction=0
start_sine=0
sineindex=$start_sine
sine_add=3
while [[ : ]]; do 

    printf "\033[0;0H"
    printf "[$COLUMNS x $LINES]\n"

    for line in $(seq 0 $(( $LINES - 2 )) ); 
    do
        newindex=$(( (sineindex + line * 5 - sine[sineindex]) % 360  ))
        newline=$(( (sine[newindex] + (sine[line])) % SCREEN_Y ))
        printf "${screenbuf[newline]}"
    done
    sineindex=$(( (sineindex + sine[offset]) % 360 ))

    if [[ $direction -eq 0 ]]; then
        offset=$(( offset + 1 ))
        if [[ $offset -eq 60 ]]; then
            direction=1
        fi 
    else
        offset=$(( offset - 1 ))
        if [[ $offset -eq 0 ]]; then
            direction=0
        fi 
    fi


    printf "\033[0m"
    #sleep 1

done 
