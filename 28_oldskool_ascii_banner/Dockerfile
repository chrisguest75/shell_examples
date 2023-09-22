FROM ubuntu:20.04
RUN apt update && apt install bash jp2a imagemagick -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* 

WORKDIR /workbench
COPY ./banner.sh ./banner.sh
COPY ./fonts ./fonts

#CMD ["/workbench/banner.sh", "--banner=HELLO"]
ENTRYPOINT ["/workbench/banner.sh"]
