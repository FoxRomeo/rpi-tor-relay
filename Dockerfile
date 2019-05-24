FROM arm32v6/bash:latest
MAINTAINER docker@intrepid.de

RUN passwd -l root ; \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install -qq --force-yes bash tor && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    chown root:root /var/lib/tor -R

# Run the command on container startup
CMD ["/usr/bin/tor", "--defaults-torrc", "/etc/tor/torrc", "--quiet"]



