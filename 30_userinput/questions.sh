#!/usr/bin/env bash

echo "What is your name?"
read name

echo "Hello, $name"

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

read -sp "Tell me a secret: " secret
echo ""
echo "Your secret is $secret"


read -p "Do you want to continue? Y/n " yescontinue
if [ "$yescontinue" == ""  ] || [ "$yescontinue" == "Y"  ] || [ "$yescontinue" == "y"  ]  ; then
    echo "Ok, lets continue"
else
    echo "Ok, come back later"
    exit 0
fi

echo "continuing"

