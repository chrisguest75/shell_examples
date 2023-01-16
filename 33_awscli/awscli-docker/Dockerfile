# syntax=docker/dockerfile:1.4
FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

ENV LANG=en_US.UTF-8 
ENV LANGUAGE=en_US:en 
ENV LC_ALL=en_US.UTF-8  

RUN apt-get update \
    && apt-get install -fy -qq --no-install-recommends ca-certificates nano bash curl jq unzip locales \
    && apt-get clean 

RUN locale-gen en_US.UTF-8 

RUN curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip -q awscliv2.zip \ 
    && rm -f awscliv2.zip \
    && aws/install \
    && /usr/local/bin/aws --version

ENTRYPOINT ["/usr/local/bin/aws"]