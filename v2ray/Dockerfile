FROM v2ray/official
MAINTAINER wwqgtxx <wwqgtxx@gmail.com>

#We need to install bash to easily handle arrays
# in the entrypoint.sh script
RUN apk add --update bash \
  certbot \
  openssl openssl-dev ca-certificates \
  && rm -rf /var/cache/apk/*

COPY entrypoint.sh /opt/entrypoint.sh
COPY config.json /opt/config.json

RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
