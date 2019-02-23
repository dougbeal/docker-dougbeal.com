FROM busybox as dl-env
ENV HUGO_VERSION=0.54.0
RUN wget -O- https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz | tar zx



FROM dougbeal/distroless:cc_debug_82
COPY --from=dl-env /hugo /
ENTRYPOINT ["/hugo"]
