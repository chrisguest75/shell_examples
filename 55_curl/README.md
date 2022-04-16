# README

Demonstrate some common examples with `curl`  

TODO:

* download file
* show headers
* ssl negotiation
* retries

## 

```sh
curl http://example.com/file.zip -o new_file.zip

curl -H "Content-Type: application/json" -X POST -d '{"user":"bob","pass":"123"}' http://example.com

# headers only
curl -I http://example.com
```


## Resources
