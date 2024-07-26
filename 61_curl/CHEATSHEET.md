# CHEATSHEET

## Examples

### POSTing JSON

```sh
# post a json file
curl -H 'Content-Type: application/json' -X POST http://localhost:3000/dev/hello -d @./src/functions/hello/mock.json
```

### POSTing Binary

```sh
curl -v --request POST --data-binary "@./out/random.bin" $SIGNEDURL1
```

### Forcing Protocols

```sh
curl --proto '=https' --tlsv1.3 https://www.google.com
curl --proto '=http' --tlsv1.3 https://www.google.com
curl --proto '=http' --tlsv1.3 http://www.google.com
```

## Parallel

Despatch parallel requests.  

```sh
# start httpbin
docker run -it --rm -p 8080:80 kennethreitz/httpbin

open http://127.0.0.1:8080

curl -vvv --parallel --parallel-immediate --parallel-max 10  http://127.0.0.1:8080/status/200 http://127.0.0.1:8080/status/200 http://127.0.0.1:8080/status/200 http://127.0.0.1:8080/headers http://127.0.0.1:8080/anything/help
```

## Resources
