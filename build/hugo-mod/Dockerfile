FROM busybox as dl-env
ENV HUGO_VERSION=0.58.3
RUN wget -O- https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz | tar zx

FROM golang:1.13

COPY --from=dl-env /hugo /
WORKDIR "/build"
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
