FROM ubuntu:20.04
RUN apt update && apt install bash jp2a imagemagick -y

WORKDIR /workbench
COPY ./banner.sh ./banner.sh
COPY ./fonts ./fonts

#CMD ["/workbench/banner.sh", "--banner=HELLO"]
ENTRYPOINT ["/workbench/banner.sh"]
