# README

Demonstrate some common examples with `curl`  

TODO:

* download file - NOT WORKING
* show headers
* ssl negotiation
* retries
* redirects

## Cheatsheet

Examples are here in [CHEATSHEET.md](./CHEATSHEET.md)

## Start

```sh
# start 
docker compose up -d

# dynamic page
curl -i http://0.0.0.0:8080/
curl -i http://0.0.0.0:8080/info

xdg-open http://0.0.0.0:8080/downloads/nginx.png
xdg-open http://0.0.0.0:8080/
```

## Debug

```sh
docker compose exec -it nginx /bin/sh
```

## Stop

```sh
docker compose down
```

## Examples

Download files

```sh
# download file silently
mkdir -p ./out
curl -s http://deb.debian.org/debian/pool/main/j/jq/jq_1.6.orig.tar.gz -o ./out/jq_1.6.orig.tar.gz 
```

```sh
# headers only
docker run -p 8080:80 --rm --name nginx -d nginx:1.21.6 
curl -I http://0.0.0.0:8080
docker stop nginx
```

```sh
docker run -p 8080:80 --rm --name nginx -d nginx:1.21.6 

    curl -vvvv --retry-all-errors --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -Is http://0.0.0.0:8080 | grep Server: 

curl --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -I http://0.0.0.0:8080 | grep Server: 
docker stop nginx
```

```sh
curl -H "Content-Type: application/json" -X POST -d '{"user":"bob","pass":"123"}' http://example.com

```







## Resources

https://www.nginx.com/blog/avoiding-top-10-nginx-configuration-mistakes/#analyzer

https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source

https://nginx.org/en/docs/