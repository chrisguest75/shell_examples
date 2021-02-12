#!/usr/bin/env bash
mode='d'
echo "Press (d) for date, (t) for timecode or (q) to quit"

while true; do

    # Loop command
    if [[ "$mode" == 'd' ]];then
        echo "#################################"
        echo -n "$(date)"
        echo ""
        echo "#################################"
        echo -ne "\e[3A\r"
    elif  [[ "$mode" == 't' ]];then
        echo "#################################"
        echo -n "$(date +%s)                   "
        echo ""
        echo "#################################"
        echo -ne "\e[3A\r"
    else
        echo "#################################"
        echo -n "Unrecognised mode"
        echo ""
        echo "#################################"
        echo -ne "\e[3A\r"
    fi

    # Check for keypress *waiting very briefly.
    read -t 0.01 -r -s -N 1 
    case "${REPLY}" in
        'q'|'Q')
            break
        ;;
        'd'|'D')
            mode='d'
        ;;
        't'|'T')
            mode='t'
        ;;  
        *)
            #mode=${REPLY}
            #echo "Unrecognised ${REPLY}"; 
        ;;
    esac        

done

# Post-loop command
echo "#################################"
echo "$(date)                           "
echo "$(date +%s)                       "
echo "#################################"
