FROM arm32v6/alpine:latest
MAINTAINER docker@intrepid.de

ENV TORVERSION=<<TORVERSION>>

RUN passwd -l root ; \
    apk add --update --upgrade --no-cache bash alpine-sdk libevent libevent-dev zlib zlib-dev openssl openssl-dev libgcc && \
    addgroup \
      -S -g 9001 \
      tor && \
    adduser \
      -S -H -D \
      -h /home/tor \
      -s /bin/bash \
      -u 9001 \
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
    mkdir -p /var/lib/tor && \
#    chown tor:tor /var/lib/tor -R && \
    cd / && \
    rm -rf /usr/src && \
    apk del alpine-sdk libevent-dev zlib-dev openssl-dev

EXPOSE 9001
EXPOSE 9030

#USER tor
# Run the command on container startup
CMD ["/usr/bin/tor", "--defaults-torrc", "/etc/tor/torrc", "--hush"]



