#!/bin/bash

set -euo pipefail

# Validate environment variables

MISSING=""

[ -z "${UUID}" ] && MISSING="${MISSING} UUID"


if [ "${MISSING}" != "" ]; then
  echo "Missing required environment variables:" >&2
  echo " ${MISSING}" >&2
  exit 1 
  fi

# Generate strong DH parameters for nginx, if they don't already exist.
if [ -f /etc/v2ray/config.json ]; then
  rm /etc/v2ray/config.json
fi

sed -e "s/\${UUID}/${UUID}/" \
  "/opt/config.json" > /etc/v2ray/config.json

v2ray -config=/etc/v2ray/config.json
