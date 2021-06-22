# README
Demonstrate a restricted bash shell

## Examples
```sh
# open a restricted bash shell
bash -r 
```

## Restricted
```sh
# can't do this
cd ..
```

```sh
# can't do this either
TEMPFILE=$(mktemp)
echo "HELLO" >  $TEMPFILE
```