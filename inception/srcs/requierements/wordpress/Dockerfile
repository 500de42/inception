FROM alpine:3.21

RUN apk update
RUN apk add --no-cache wget tar php82 php82-mysqli php82-fpm mariadb-client
RUN mkdir -p /var/www/html 
RUN adduser -u 82 -S www-data -G www-data || true
RUN wget https://github.com/WordPress/WordPress/archive/refs/tags/6.4.3.tar.gz -O /tmp/wordpress.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
    rm /tmp/wordpress.tar.gz

COPY conf/init.conf /etc/php82/php-fpm.d/www.conf
COPY conf/init.sh .
RUN chmod +x /etc/php82/php-fpm.d/www.conf init.sh

EXPOSE 9000

CMD [ "php-fpm82", "-F" ]
