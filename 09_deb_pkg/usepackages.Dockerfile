FROM ubuntu:16.04

ARG REPOSITORY_URL=
RUN echo "deb [trusted=yes] ${REPOSITORY_URL} ./" | tee -a /etc/apt/sources.list > /dev/null 

# Do not clean out package caches so I can play with the image.
RUN apt-get update && apt-get install bash -y

RUN apt-cache show hello-world
RUN apt-get update && apt-get install hello-world -y
RUN which hello-world.sh
RUN hello-world.sh

ENTRYPOINT ["/bin/bash", "-c", "hello-world.sh"]

