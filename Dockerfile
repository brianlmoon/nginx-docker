ARG BASEIMAGE=mainline-alpine
FROM nginx:$BASEIMAGE AS base

ARG UID=101
ARG GID=101

RUN apk add --no-cache \
        nano \
        certbot \
        certbot-nginx \
        procps \
        apk-cron \
        bash

RUN deluser nginx && \
    addgroup -S -g $GID nginx && \
    adduser -S -u $UID -h /var/cache/nginx -s /sbin/nologin -G nginx nginx
