#!/bin/bash

set -euo pipefail

# Validate environment variables

MISSING=""

[ -z "${UUID}" ] && MISSING="${MISSING} UUID"
[ -z "${V2RAY_NAME}" ] && MISSING="${MISSING} V2RAY_NAME"


if [ "${MISSING}" != "" ]; then
  echo "Missing required environment variables:" >&2
  echo " ${MISSING}" >&2
  exit 1 
  fi
  
if [ -f /tmp/${V2RAY_NAME}/${V2RAY_NAME} ]; then
  rm -rf /tmp/${V2RAY_NAME}
fi

cp -r /usr/bin/v2ray/ /tmp/

mv /tmp/v2ray /tmp/${V2RAY_NAME}

cd /tmp/${V2RAY_NAME}/

sed -e "s/\${UUID}/${UUID}/" \
  "/opt/config.json" > config.json
  
cp v2ray ${V2RAY_NAME}

exec ${V2RAY_NAME}