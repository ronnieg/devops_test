FROM golang:1.16-alpine AS build

WORKDIR /app

COPY src/go.mod ./
COPY src/go.sum ./

RUN go mod download

COPY src/*.go ./

RUN go build -o /dummy-webservice

FROM alpine:latest AS service

ENV REDIS_ADDR=localhost:6379

WORKDIR /

COPY --from=build /dummy-webservice /dummy-webservice

EXPOSE 8080

ENTRYPOINT ["/dummy-webservice"]