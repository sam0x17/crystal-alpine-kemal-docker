FROM durosoft/crystal-alpine:latest as builder
RUN mkdir /src
WORKDIR /src
COPY . /src/
RUN shards && crystal build --release src/*.cr -o crystal-app
FROM alpine:latest
EXPOSE 3000
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN apk add --update openssl pcre gc libevent libgcc
COPY --from=builder /src/crystal-app /usr/src/app/
ENTRYPOINT [ "/usr/src/app/crystal-app"]
