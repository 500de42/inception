FROM alpine:3.21

RUN apk update && apk add --no-cache php82-mysqli curl php82-fpm

COPY adminer.sh /etc/adminer.sh

RUN chmod +x /etc/adminer.sh

EXPOSE 9000

CMD ["./etc/adminer.sh"]