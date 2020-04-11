#!/usr/bin/env bash

screenbuf=[]

while [[ : ]]; do 
    clear
    printf "[$COLUMNS x $LINES]\n"
    
    for line in $(seq 0 $(( $LINES - 2 )) ); 
    do
        for col in $(seq 0 $(( $COLUMNS - 1 )) ); 
            do 
                r=$(( 255 - ( col * 255 / 76 ) ))
                g=$(( col * 510 / 76 ))
                b=$(( col * 255 / 76 ))
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
                printf "\033[48;2;${r};${g};${b}m \033[0m"
        done
    done
    #sleep 1

done 
