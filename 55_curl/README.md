# README

Demonstrate some common examples with `curl`  

TODO:

* ssl negotiation
* retries - podinfo failures
* redirects implement and point to another nginx server
* go through options - -cookie-jar,  --trace-time

For `imgcat` check that the iterm2 shell integrations are installed.  

## Cheatsheet

Examples are here in [CHEATSHEET.md](./CHEATSHEET.md)  

## Start

```sh
# nginx             - "10000:80"
# nginxproxy        - "8080:8080" points to nginx:80
# nginxproxyweb     - "9000:8081"
#
# podinfo           - "10001:80"
# podinfoproxy      - "8081:8080" points to podinfo:9898
# podinfoproxyweb   - "9001:8081"
docker compose up -d

# open proxy webs (xdg-open on linux)
open http://0.0.0.0:9000/
open http://0.0.0.0:9001/

# dynamic page - nginx
curl -i http://0.0.0.0:8080/
curl -i http://0.0.0.0:8080/info
curl http://0.0.0.0:8080/downloads/nginx.png

# podinfo
curl -i http://0.0.0.0:8081/
curl -i http://0.0.0.0:8081/echo 
# error code
curl -i http://0.0.0.0:8081/status/503 
```

## Debug

```sh
# logs
docker compose logs nginx

# exec into container
docker compose exec -it nginx /bin/sh

# if changing config you can restart compose services
docker compose restart 
```

## Stop

```sh
docker compose down
```

## Examples

Download files

```sh
# this only works in iterm2
curl -s http://0.0.0.0:8080/downloads/nginx.png | imgcat
```

```sh
# download file silently
mkdir -p ./out
curl -s http://deb.debian.org/debian/pool/main/j/jq/jq_1.6.orig.tar.gz -o ./out/jq_1.6.orig.tar.gz 
```

```sh
# headers only
curl -I http://0.0.0.0:8080
```

Retries  

```sh
# retries - watch them in the mitmproxy
curl -vvvv --retry-all-errors --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -s http://0.0.0.0:8081/status/503 
# no retries for success
curl -vvvv --retry-all-errors --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -s http://0.0.0.0:8081/status/200
# 404 is classed as success
curl -vvvv --retry-all-errors --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -s http://0.0.0.0:8081/status/404
```

Posting  

```sh
# echo back a post from podinfo
curl -H "Content-Type: application/json" -X POST -d '{"user":"bob","pass":"123"}' http://0.0.0.0:8081/echo 
```

## Resources

* stefanprodan/podinfo [repo](https://github.com/stefanprodan/podinfo)  
* Avoiding the Top 10 NGINX Configuration Mistakes [here](https://www.nginx.com/blog/avoiding-top-10-nginx-configuration-mistakes/#analyzer)
* Installing NGINX Open Source [here](https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source)
* nginx documentation [here](https://nginx.org/en/docs/)  
