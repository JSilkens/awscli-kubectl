FROM --platform=$BUILDPLATFORM alpine:latest

LABEL org.opencontainers.image.authors="me@jsilkens.be"

RUN apk add --no-cache aws-cli curl kubectl docker-credential-ecr-login

ENV SIGNING_HELPER_VERSION=1.3.0

RUN ARCH=$TARGETARCH && \
    if [ "$ARCH" = "amd64" ]; then \
        HELPER_URL=https://rolesanywhere.amazonaws.com/releases/$SIGNING_HELPER_VERSION/X86_64/Linux/aws_signing_helper; \
    elif [ "$ARCH" = "arm64" ]; then \
        HELPER_URL=https://rolesanywhere.amazonaws.com/releases/$SIGNING_HELPER_VERSION/Aarch64/Linux/aws_signing_helper; \
    else \
        echo "Unsupported architecture: $ARCH"; exit 1; \
    fi && \
    curl -o /usr/local/bin/aws_signing_helper $HELPER_URL && \
    chmod +x /usr/local/bin/aws_signing_helper && \
    echo "AWS Signing Helper installed successfully at /usr/local/bin/aws_signing_helper"
