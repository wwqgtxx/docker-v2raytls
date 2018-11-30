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

if [ -f /etc/v2ray/config.json ]; then
  rm /etc/v2ray/config.json
fi

mkdir /etc/v2ray/ -p

cd /etc/v2ray/

sed -e "s/\${UUID}/${UUID}/" \
  "/opt/config.json" > config.json

exec -a "${V2RAY_NAME}" v2ray
