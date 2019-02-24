FROM node:alpine
RUN apk add --no-cache \
    yarn findutils git

WORKDIR "/build"
ENTRYPOINT ["/usr/bin/find", ".", "-name", "package.json", "-not", "-path", "'*/node_modules*'", "-not", "-path", "'*/bower_components*'", "-print"]
CMD ["-execdir", "yarn", "--non-interactive", ";"]

