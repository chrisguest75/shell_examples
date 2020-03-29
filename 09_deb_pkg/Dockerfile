FROM ubuntu:18.04

RUN apt update && apt-get install apache2 build-essential -y
RUN mkdir -p /var/www/html/debian
COPY hello-world.deb /var/www/html/debian/hello-world-1.0_amd64.deb
WORKDIR /var/www/html/debian
RUN dpkg-scanpackages . | gzip -c9  > ./Packages.gz

ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
