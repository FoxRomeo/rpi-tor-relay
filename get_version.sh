#!/bin/bash

#https://www.torproject.org/download/tor/
#<td class="text-right"><a href="https://dist.torproject.org/tor-0.4.1.6.tar.gz">Download</a>
VERSION=`curl -s "https://www.torproject.org/download/tor/" | grep -E '\"https://dist.torproject.org/tor-+[0-9]\.+[0-9]\.+[0-9]\.+[0-9].tar.gz\"' |  sed -n -e 's/^.*<td class=\"text-right\"><a href=\"https:\/\/dist\.torproject\.org\/tor-'//p | sed -n -e 's/\.tar\.gz\">Download<\/a>.*$'//p | head -n 1`

echo ${VERSION}