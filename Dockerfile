FROM durosoft/crystal-alpine:latest as builder
RUN mkdir /src
WORKDIR /src
COPY . /src/
RUN shards && crystal build --release --static src/*.cr -o crystal-app
FROM alpine:latest
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN apk add --update openssl pcre gc libevent libgcc
COPY --from=builder /src/crystal-app /usr/src/app/
EXPOSE 3000
ENTRYPOINT ./crystal-app
