#!/bin/bash

EXITCODE=0

if [[ -n "${DIR_PORT}" ]]; then
  if netstat -an | grep "LISTEN" | grep "${DIR_PORT}" > /dev/null; then
    echo "listening for connections on port ${DIR_PORT}. HEALTHY"
  else
    echo "not listening for connections on port ${DIR_PORT}. UNHEALTHY"
    EXITCODE=1
  fi
fi

if [[ -n "${SOCKS_PORT}" ]]; then
  if netstat -an | grep "LISTEN" | grep "${SOCKS_PORT}" > /dev/null; then
    echo "listening for connections on port ${SOCKS_PORT}. HEALTHY"
  else
    echo "not listening for connections on port ${SOCKS_PORT}. UNHEALTHY"
    EXITCODE=1
  fi
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
