# README

Demonstrates techniques for generating unique ids in scripts.  

TODO:

* crypto hash
* nanoid https://github.com/ai/nanoid

## UUIDGEN

```sh
# macosx
uuidgen
```

```sh
# install uuidgen on debian
apt-get install uuid-runtime
uuidgen
```

## Using timestamp from date

```sh
date +%s

# macosx
$ date -r 1282368345
Sat Aug 21 07:25:45 CEST 2010
$ date -r 1282368345 +%Y-%m-%d
2010-08-21

$ date -d @1282368345
Sat Aug 21 07:25:45 CEST 2010
$ date -d @1282368345 --rfc-3339=date
2010-08-21
```

## Random (bash & zsh)

```sh
# random number
echo $RANDOM

# random number between 1 and 10
echo "$(( ( RANDOM % 10 )  + 1 ))"
```

## /dev/random

```sh
LC_CTYPE=C tr -dc A-Za-z0-9 < /dev/random | head -c 60 | xargs
# or
head /dev/urandom | tr -dc a-f0-9 | head -c 40
```

## cksum

This technique can be used for consistent hashing  

```sh
# take a string and cksum it.
echo $(echo "hashingstring" | cksum | cut -f 1 -d \ )
```

## 

```sh
head /dev/urandom | tr -dc a-f0-9 | head -c 40
```

## Resources

* /dev/random example [here](https://gist.github.com/5c0tt/b9f452a9076daca4fa35)  
* nodejs [uuid-support-in-the-crypto-module](https://nodejs.org/en/blog/release/v14.17.0/#uuid-support-in-the-crypto-module)  
