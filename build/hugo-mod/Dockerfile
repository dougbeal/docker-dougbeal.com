FROM busybox as dl-env
ENV HUGO_VERSION=0.58.3
RUN wget -O- https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz | tar zx

FROM gcr.io/distroless/cc as gccenv


FROM gcr.io/distroless/base

COPY --from=gccenv /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libgcc_s.so.1
COPY --from=gccenv /usr/lib/x86_64-linux-gnu/libgomp.so.1 /usr/lib/x86_64-linux-gnu/libgomp.so.1
COPY --from=gccenv /usr/lib/x86_64-linux-gnu/libgomp.so.1.0.0 /usr/lib/x86_64-linux-gnu/libgomp.so.1.0.0
COPY --from=gccenv /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libstdc++.so.6
COPY --from=gccenv /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.22 /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.22


COPY --from=dl-env /hugo /
WORKDIR "/build"

ENTRYPOINT ["/hugo", "--debug", "--verbose", "--cacheDir", "/build/cache", "--verboseLog", "--log", "--logFile", "/dev/stdout"]
