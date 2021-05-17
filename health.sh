#!/bin/bash

EXITCODE=0


if [[ -z "${DIR_PORT}" ]]; then
 DIR_PORT=9030
fi
if netstat -an | grep "LISTEN" | grep "${DIR_PORT}" > /dev/null; then
    echo "listening for connections on port ${DIR_PORT}. HEALTHY"
else
    echo "not listening for connections on port ${DIR_PORT}. UNHEALTHY"
    EXITCODE=1
fi

if [ -z "${OR_PORT}" ]; then
 OR_PORT=9001
fi
if netstat -an | grep LISTEN | grep "${OR_PORT}" > /dev/null; then
    echo "listening for connections on port ${OR_PORT}. HEALTHY"
else
    echo "not listening for connections on port ${OR_PORT}. UNHEALTHY"
    EXITCODE=1
fi


exit $EXITCODE
