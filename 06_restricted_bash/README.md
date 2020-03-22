# README
Demonstrate a restricted bash shell

```sh
bash -r 
```

Restricted
```sh
cd ..
```

Restricted
```sh
TEMPFILE=$(mktemp)
echo "HELLO" >  $TEMPFILE
```