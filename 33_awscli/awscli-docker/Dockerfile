# syntax=docker/dockerfile:1.4
FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

ENV LANG=en_US.UTF-8 
ENV LANGUAGE=en_US:en 
ENV LC_ALL=en_US.UTF-8  

RUN rm -f /etc/apt/apt.conf.d/docker-clean; \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' \
    > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    set -x; apt-get update \
    && apt-get install -fy -qq --no-install-recommends ca-certificates bash curl unzip locales \
    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip -q awscliv2.zip \ 
    && rm -f awscliv2.zip \
    && aws/install \
    && rm -rf ./aws \
    && /usr/local/bin/aws --version \
    && apt purge -fy curl unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 

ENTRYPOINT ["/usr/local/bin/aws", "--version"]