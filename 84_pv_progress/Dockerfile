# syntax=docker/dockerfile:1.4
FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -fy -qq --no-install-recommends bash ca-certificates pv \
    && apt-get clean

WORKDIR /scratch
CMD [ "/bin/bash" ]
