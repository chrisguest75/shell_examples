# README

Demonstrate some common examples with `curl`  

TODO:

* download file
* show headers
* ssl negotiation
* retries

## Examples

```sh
# download file silently
mkdir -p ./out
curl -s http://deb.debian.org/debian/pool/main/j/jq/jq_1.6.orig.tar.gz -o ./out/jq_1.6.orig.tar.gz 
```




```sh
curl -H "Content-Type: application/json" -X POST -d '{"user":"bob","pass":"123"}' http://example.com

# headers only
curl -I http://example.com
```


## Resources
