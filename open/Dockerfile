FROM golang:latest as build-env
WORKDIR /go/src/app
ADD . /go/src/app

RUN go get -d -v ./...
RUN go install -v ./...

FROM gcr.io/distroless/base
USER 33:33
COPY --from=build-env /go/bin/app /
CMD ["/app"]
