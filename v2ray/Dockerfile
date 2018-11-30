FROM ubuntu:latest as builder
ARG V2RAY_VERSION

RUN apt-get update
RUN apt-get install curl -y
RUN curl -L -o /tmp/go.sh https://install.direct/go.sh
RUN chmod +x /tmp/go.sh --version $V2RAY_VERSION
RUN /tmp/go.sh

FROM nginx:alpine
MAINTAINER wwqgtxx <wwqgtxx@gmail.com>

#We need to install bash to easily handle arrays
# in the entrypoint.sh script
RUN apk add --update bash \
  certbot \
  openssl openssl-dev ca-certificates \
  && rm -rf /var/cache/apk/*

COPY --from=builder /usr/bin/v2ray/v2ray /usr/bin/v2ray/
COPY --from=builder /usr/bin/v2ray/v2ctl /usr/bin/v2ray/
COPY --from=builder /usr/bin/v2ray/geoip.dat /usr/bin/v2ray/
COPY --from=builder /usr/bin/v2ray/geosite.dat /usr/bin/v2ray/
COPY entrypoint.sh /opt/entrypoint.sh
COPY config.json /opt/config.json

RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
