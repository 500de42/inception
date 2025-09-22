FROM alpine:3.21

RUN apk update && apk add --no-cache redis php-tokenizer php82-ctype

COPY redis.conf /usr/local/etc/redis/redis.conf

# RUN sed -i 's/^# maxmemory <bytes>/maxmemory 128mb/' /etc/redis.conf && \
#     sed -i 's/^# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/' /etc/redis.conf && \
#     sed -i 's/^bind 127.0.0.1 -::1/#bind 127.0.0.1 ::1/' /etc/redis.conf && \
#     sed -i 's/^protected-mode yes/protected-mode no/' /etc/redis.conf

EXPOSE 6379

CMD ["redis-server", "/usr/local/etc/redis/redis.conf", "--protected-mode", "no", "--bind", "0.0.0.0"]