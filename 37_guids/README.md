# README
Demonstrates techniques for generating unique ids in scripts.   

TODO:
* crypto hash
* /dev/random

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


# Resources

https://gist.github.com/5c0tt/b9f452a9076daca4fa35

https://nodejs.org/en/blog/release/v14.17.0/#uuid-support-in-the-crypto-module

