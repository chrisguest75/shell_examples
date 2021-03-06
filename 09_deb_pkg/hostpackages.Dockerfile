FROM ubuntu:18.04

RUN apt update && apt-get install apache2 -y
WORKDIR /var/www/html/debian
COPY packages/* /var/www/html/debian/packages/
COPY *.gz /var/www/html/debian

ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
