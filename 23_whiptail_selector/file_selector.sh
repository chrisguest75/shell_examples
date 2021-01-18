#!/usr/bin/env bash



title="Files"
curdir=$(pwd)
dir_list=$(ls -lhp  | awk -F ' ' ' { print $9 " " $5 } ')
selection=$(whiptail --title "$title" \
                        --menu "PgUp/PgDn/Arrow Enter Selects File/Folder\nor Tab Key\n$curdir" 20 80 10 \
                        --cancel-button Cancel \
                        --ok-button Select ../ BACK $dir_list 3>&1 1>&2 2>&3)

echo "Selected '$selection' and exitcode '$?'"


#whiptail --title "Select File" 
#whiptail --yesno "Did you already know whiptail?" --yes-button "Yes, I did" --no-button "No, never heard of it"  10 70

