# rpi-tor-releay
Raspberry Pi (RPi) Docker container with tor proxy
(arm32v6 aka RPi A/B/B+ and later)

If you have a running instance copy your "torrc" and "fingerprint", if you don't have a fingerprint, set path to "rw" instead of "ro". "keys" must be "rw" all the time (even if it's empty).

start with:
docker run -d --restart=unless-stopped --name rpi-tor-relay -v {local path}/torrc:/etc/tor/torrc:ro -v {local path}/fingerprint:/var/lib/tor/fingerprint:ro -v {local path}/keys:/var/lib/tor/keys:rw -p 9030:9030 -p 9001:9001 intrepidde/rpi-tor-relay

based on resin/rpi-raspbian:jessie using tor
