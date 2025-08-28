FROM alpine:3.21

RUN apk update
RUN apk add --no-cache wget tar php82 php82-mysqli php82-fpm

COPY /conf/init.conf /usr/local/etc/php-fpm.d/www.conf

EXPOSE 9000

CMD [ "php-fpm82", "-F" ]
