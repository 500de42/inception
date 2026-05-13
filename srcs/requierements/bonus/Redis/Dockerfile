FROM alpine:3.21

RUN apk update && apk add --no-cache redis php-tokenizer php82-ctype

COPY redis.conf etc/redis.conf

EXPOSE 6379

CMD ["redis-server", "etc/redis.conf", "--protected-mode", "no", "--bind", "0.0.0.0"]