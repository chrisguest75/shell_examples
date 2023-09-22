# syntax=docker/dockerfile:1.4
FROM ubuntu:20.04 as BASE

RUN apt update && apt install lsb-release -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* 

WORKDIR /scratch

COPY detect-os.sh detect-os.sh

ENTRYPOINT ["/bin/bash", "-c", " /scratch/detect-os.sh"]

