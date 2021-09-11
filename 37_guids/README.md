# README
Demonstrates techniques for generating unique ids in scripts.   

TODO:
* crypto hash
* nanoid 

## UUIDGEN
```sh
# macosx
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

## Random

```sh
echo $RANDOM
```

## /dev/random
```sh
LC_CTYPE=C tr -dc A-Za-z0-9 < /dev/random | head -c 60 | xargs
```

# Resources
* /dev/random example [here](https://gist.github.com/5c0tt/b9f452a9076daca4fa35)  
* nodejs [uuid-support-in-the-crypto-module](https://nodejs.org/en/blog/release/v14.17.0/#uuid-support-in-the-crypto-module)  

