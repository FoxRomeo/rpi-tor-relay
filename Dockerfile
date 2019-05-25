FROM arm32v6/alpine:latest
MAINTAINER docker@intrepid.de

ENV TORVERSION=0.4.0.5

RUN passwd -l root ; \
    apk add --update --upgrade --no-cache bash alpine-sdk libevent libevent-dev zlib zlib-dev openssl openssl-dev && \
    addgroup \
      -S -g 1000 \
      tor && \
    adduser \
      -S -H -D \
      -h /home/tor \
      -s /bin/bash \
      -u 1000 \
      -G tor \
      tor && \
    passwd -l tor ; \
    mkdir /usr/src && \
    cd /usr/src && \
    wget "https://dist.torproject.org/tor-${TORVERSION}.tar.gz" && \
    tar xzvf tor-${TORVERSION}.tar.gz && \
    cd tor-${TORVERSION} && \
    ./configure --prefix=/usr --sysconfdir=/etc --with-tor-user=tor --with-tor-group=tor && \
    make install && \
    cd / && \
    rm -rf /usr/src && \
    apk del alpine-sdk libevent-dev zlib-dev openssl-dev
#    chown root:root /var/lib/tor -R

EXPOSE 9001
EXPOSE 9030

# Run the command on container startup
CMD ["/usr/bin/tor", "--defaults-torrc", "/etc/tor/torrc", "--quiet"]



