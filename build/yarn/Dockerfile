FROM node:alpine
RUN apk add --no-cache \
    yarn findutils

WORKDIR /build
ENTRYPOINT [ "find", ".", "-name", "package.json", "-not", "-path", "'*/node_modules*'", "-not", "-path", "'*/bower_components*'", "-print", "-execdir", "yarn", "--verbose", "--non-interactive", "\;" ]

