FROM arm32v6/alpine:latest
MAINTAINER docker@intrepid.de

RUN passwd -l root ; \
    apk --update --upgrade --no-cache add \
      bash \
      tor && \
    chown root:root /var/lib/tor -R

# Run the command on container startup
CMD ["/usr/bin/tor", "--defaults-torrc", "/etc/tor/torrc", "--quiet"]



