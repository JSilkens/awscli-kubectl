FROM --platform=$BUILDPLATFORM alpine:latest

LABEL org.opencontainers.image.authors="me@jsilkens.be"

RUN apk add --no-cache aws-cli curl kubectl