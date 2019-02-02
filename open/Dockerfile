FROM golang:alpine as build-go
ADD . /go/src/github.com/dougbeal/open
WORKDIR /go/src/github.com/dougbeal/open
RUN apk add --no-cache git \
    && go get \
    && apk del git
RUN go build -o main .

FROM alpine
RUN mkdir -p /open
WORKDIR /open

COPY --from=build-go /go/src/github.com/dougbeal/open/main /open/
CMD ["/open/main"]
