FROM golang:alpine

ENV HUGO_VERSION=0.58.3
RUN wget -O- https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz | tar zx

RUN apk add --no-cache \
    yarn findutils go

