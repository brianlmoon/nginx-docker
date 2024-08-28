ARG BASEIMAGE=mainline-alpine
FROM nginx:$BASEIMAGE AS base

RUN apk add --no-cache \
        nano \
        certbot \
        certbot-nginx \
        procps \
        apk-cron \
        bash
