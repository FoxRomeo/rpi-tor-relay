# rpi-tor-releay
<a href="https://hub.docker.com/r/intrepidde/rpi-tor-relay"><img src="https://img.shields.io/docker/pulls/intrepidde/rpi-tor-relay.svg?style=plastic&logo=appveyor" alt="Docker pulls"/></a><br>
Raspberry Pi (RPi) Docker container with tor proxy
(arm32v6 aka RPi A/B/B+ and later)

If you have a running instance copy your "torrc" and "fingerprint", if you don't have a fingerprint, set path to "rw" instead of "ro". "keys" must be "rw" all the time (even if it's empty).


BREAKING CHANGE: with new version 0.4.3.6 the runser is not root anymore (for security reasons of course). New runuser is "tor" uid 9001 (a user with uid 1000 was created before, but not used) If you want to use old root with new images add "--user root" to docker parameters, but it's better to change fingerprint directory to rw for new user ("chmod 9001 {local path}/fingerprint"), or use image taged with "0.4.3.5" or "0.4.3.5-root" (this images will receive updates ONLY UNTIL end of September 2020 for now!).


start with:
docker run -d --restart=unless-stopped --name rpi-tor-relay -v {local path}/torrc:/etc/tor/torrc:ro -v {local path}/fingerprint:/var/lib/tor/fingerprint:ro -v {local path}/keys:/var/lib/tor/keys:rw -p 9030:9030 -p 9001:9001 intrepidde/rpi-tor-relay

based on arm32v6/alpine:latest

https://www.intrepid.de/index.php/projects/git-docker/17-intrepidde-rpi-tor-relay

https://hub.docker.com/r/intrepidde/rpi-tor-relay
