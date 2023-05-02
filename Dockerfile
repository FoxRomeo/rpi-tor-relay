FROM arm32v6/alpine:3.12
#FROM arm32v6/alpine:latest
MAINTAINER docker@intrepid.de

ENV TORVERSION=<<TORVERSION>>
ENV MAKELIMIT=1

COPY health.sh /
RUN passwd -l root ; \
    chmod 755 /health.sh && \
    apk add --update --upgrade --no-cache bash alpine-sdk libevent libevent-dev zlib zlib-dev openssl openssl-dev libgcc && \
    addgroup \
      -S -g 9001 \
      tor && \
    adduser \
      -S -D \
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
    make -j ${MAKELIMIT} install && \
    mkdir -p /var/lib/tor && \
    chown tor:tor /var/lib/tor -R && \
    cd / && \
    rm -rf /usr/src && \
    apk del alpine-sdk libevent-dev zlib-dev openssl-dev

EXPOSE 9001
EXPOSE 9030
EXPOSE 9050

USER tor
CMD ["/usr/bin/tor", "--defaults-torrc", "/etc/tor/torrc", "--hush"]

HEALTHCHECK --start-period=3m --interval=3m --timeout=10s CMD /health.sh

