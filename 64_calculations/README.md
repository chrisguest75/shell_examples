# README

Demonstrate some way of performing calculations in shell and scripts.  

NOTE: There seems to be differences between bash and zsh

TODO:

* python 1 liners..
* perl
* zx?

## Shells

Check the shell you are using as different shells exhibit different  

```sh
# check current shell
echo $SHELL
```

## Bash

```sh
# integer maths
echo $(( 10 + 5))

# decimals do not work
echo $(( 10.5 + 5))
```

## Zsh

```sh
# integer maths
echo $(( 10 + 5))

# decimals work
echo $(( 10.5 + 5))
echo $(( 10.57777 * 5))
```

## bc

```sh
man bc

echo "10.5 * 5" | bc     
echo 'scale = 16; 5 / 3' | bc  
```

## awk

```sh
# sum and format numbers using awk
awk '{OFMT = "%9.6f";s+=$1} END {print s}' << EOF
4922049292.888
3420302882.9098785656
1334423422.34344
EOF
```

## sqlite

```sh
echo "time,cpu,pid,process" > ./cpu.csv
for index in $(seq 0 100 ); 
do
    ps -opcpu -opid -ocomm -cax | grep -i windowserver | sort -r | sed "s/^/$(date '+%H:%M:%S') /" | sed 's/\t/ /g' | sed 's/  */ /g' | sed 's/ /,/g'
    sleep 1
done >> ./cpu.csv

sqlite3 :memory: -cmd '.mode csv' -cmd '.import cpu.csv cpu' 'SELECT time, COUNT(*), AVG(cpu) FROM cpu '
```

## Resoures

* sqlite csv examples [here](../12_csv/README.md)
