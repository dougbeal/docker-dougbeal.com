FROM busybox as dl-env
ENV HUGO_VERSION=0.49
RUN wget -O- https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar zx

FROM gcr.io/distroless/base
USER 33:33
COPY --from=dl-env /hugo /
ENTRYPOINT ["/hugo"]
