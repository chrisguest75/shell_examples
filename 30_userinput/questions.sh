#!/usr/bin/env bash

# simple read
echo "What is your name?"
read name
echo "Hello, $name"

# input with integer verification
age=-1
while [[ $age -lt 0 ]]; do
    echo "How old are you?"
    read age
     if [[ "$age" != ?(+|-)+([0-9]) ]]; then
        echo "$age is invalid"
        age=-1
    elif [[ $age -lt 0 ]]; then
        echo "$age is invalid"
        age=-1
    fi    
done
echo "Hello $name, $age years old"

# read value masked
read -sp "Tell me a secret: " secret
echo ""
echo "Your secret is $secret"

# handle yesno question. 
read -p "Do you want to continue? Y/n " yescontinue
if [ "$yescontinue" == ""  ] || [ "$yescontinue" == "Y"  ] || [ "$yescontinue" == "y"  ]  ; then
    echo "Ok, lets continue"
else
    echo "Ok, come back later"
    exit 0
fi
echo "continuing"

# read in a read loop
echo ""
echo "ls -la"
while IFS=" " read -r __permissions __files __owner __group __size __day __month _time __name
do
    read -p "Do you want to print details for '$__name'? Y/n " yescontinue < /dev/tty
    if [ "$yescontinue" == ""  ] || [ "$yescontinue" == "Y"  ] || [ "$yescontinue" == "y"  ]  ; then
        echo "$__name $__permissions $__files $__owner $__group $__size $__day $__month $_time"
    else
        echo "$__name"
    fi
done < <(ls -la | tail -n +2)

