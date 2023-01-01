# syntax=docker/dockerfile:1.4
FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -fy -qq --no-install-recommends ca-certificates inotify-tools \
    && apt-get clean 

WORKDIR /scratch
COPY notified.sh ./notified.sh 
COPY notify.sh ./notify.sh 
ENTRYPOINT ["/scratch/notify.sh", "/share" ]

