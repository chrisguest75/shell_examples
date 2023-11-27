# README

Demonstrate some common examples with `curl`  

- [README](#readme)
  - [Cheatsheet](#cheatsheet)
  - [Start](#start)
  - [Debug](#debug)
  - [Stop](#stop)
  - [Examples](#examples)
    - [Download files](#download-files)
    - [Retries](#retries)
    - [Posting](#posting)
    - [Follow redirects](#follow-redirects)
  - [Resources](#resources)

TODO:

* add wget equivalents
* ssl negotiation
* redirects implement and point to another nginx server (permanent with curl?)
* go through options - -cookie-jar [can-you-set-up-cookies-in-nginx](https://www.digitalocean.com/community/questions/can-you-set-up-cookies-in-nginx)  

For `imgcat` check that the iterm2 shell integrations are installed.  

For ref:

* Using --fail to return exit codes [docker_examples/77_healthchecks](https://github.com/chrisguest75/docker_examples/tree/master/77_healthchecks)

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

# return error
open http://0.0.0.0:8080/error
# redirect
open http://0.0.0.0:8080/podinfo

# podinfo
curl -i http://0.0.0.0:8081/
curl -i http://0.0.0.0:8081/echo 
# error code
curl -i http://0.0.0.0:8081/status/503 
# show timestamps
curl -vvvv -i --trace-time http://0.0.0.0:8081/delay/10 
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

Simple examples using `curl` features.  

### Download files

Render an image to the terminal.  

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

# just get the file size (headers only)
curl -sI http://0.0.0.0:8080/downloads/nginx.png | grep content-length
```

### Retries  

```sh
# retries - watch them in the mitmproxy
curl -vvvv --retry-all-errors --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -s http://0.0.0.0:8081/status/503 
# no retries for success
curl -vvvv --retry-all-errors --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -s http://0.0.0.0:8081/status/200
# 404 is classed as success
curl -vvvv --retry-all-errors --connect-timeout 5 --max-time 20 --retry 5 --retry-delay 0 --retry-max-time 40 -s http://0.0.0.0:8081/status/404
```

### Posting  

```sh
# echo back a post from podinfo
curl -H "Content-Type: application/json" -X POST -d '{"user":"bob","pass":"123"}' http://0.0.0.0:8081/echo 
```

### Follow redirects  

```sh
# follow HTTP/1.1 302 Moved Temporarily
curl -vvvv -L http://0.0.0.0:8080/podinfo     
```

### Range Requests

NOTE: `content-length` will be the full length of the binary.  

```sh
# request a stream of bytes. 
curl -s -H "Range: bytes=32-195" "http://mysite.com/random.bin" | xxd
```

## Resources

* stefanprodan/podinfo [repo](https://github.com/stefanprodan/podinfo)  
* Avoiding the Top 10 NGINX Configuration Mistakes [here](https://www.nginx.com/blog/avoiding-top-10-nginx-configuration-mistakes/#analyzer)
* Installing NGINX Open Source [here](https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source)
* nginx documentation [here](https://nginx.org/en/docs/)  
* How To Create Temporary and Permanent Redirects with Nginx [here](https://www.digitalocean.com/community/tutorials/how-to-create-temporary-and-permanent-redirects-with-nginx)  
* HTTP range requests [here](https://developer.mozilla.org/en-US/docs/Web/HTTP/Range_requests)  
