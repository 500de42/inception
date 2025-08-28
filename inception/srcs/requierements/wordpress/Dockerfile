FROM alpine:3.21

RUN apk update
RUN apk add --no-cache wget tar php82 php82-mysqli php82-fpm
RUN mkdir -p /var/www/html
RUN wget https://github.com/WordPress/WordPress/archive/refs/tags/6.4.3.tar.gz -O /tmp/wordpress.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
    rm /tmp/wordpress.tar.gz

COPY /conf/init.conf /usr/local/etc/php-fpm.d/www.conf

EXPOSE 9000

CMD [ "php-fpm82", "-F" ]
