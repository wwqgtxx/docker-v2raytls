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

sed -e "s/\${UUID}/${UUID}/" \
  "/opt/config.json" > /etc/v2ray/config.json

v2ray.location.asset="/etc/v2ray/config.json"

exec -a "${V2RAY_NAME}" v2ray
