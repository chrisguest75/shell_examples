#!/usr/bin/env bash

title="Files"
curdir=$(pwd)/files

dir_list=$(ls -lhp $curdir | awk -F ' ' ' { print $9 " " $5 } ')

selection=$(whiptail --title "$title" \
                        --menu "PgUp/PgDn/Arrow Enter Selects File/Folder\nor Tab Key\n$curdir" 20 80 10 \
                        --cancel-button Cancel \
                        --ok-button Select ../ BACK $dir_list 3>&1 1>&2 2>&3)

exitcode=$?
echo "Selected '$selection' and exitcode '$exitcode'"
if [[ "$exitcode" == "0" ]]; then
    file_to_be_removed=$selection
    selection=$(whiptail --yesno "Did you really want to delete '$selection'?" --yes-button "Yes, I do" --no-button "No, leave it alone"  10 70)
    echo "Selected '$selection' and exitcode '$?'"
else
    echo "Skipped"
fi 

