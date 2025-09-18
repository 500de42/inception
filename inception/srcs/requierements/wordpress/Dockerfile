FROM alpine:3.21

WORKDIR /var/www/html

RUN apk update && apk add --no-cache \
    wget curl bash less tar \
    mariadb-client \
    php82 php82-session php82-openssl php82-iconv php82-json php82-xml \
    php82-mbstring php82-mysqli php82-curl php82-phar php82-fpm \
    php82-pecl-redis \
    && adduser -S www-data -G www-data

RUN ln -s /usr/bin/php82 /usr/bin/php

RUN curl -fsSL -o /usr/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/bin/wp

RUN rm -rf /var/www/html/*

COPY conf/init.conf /etc/php82/php-fpm.d/www.conf
COPY conf/init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh && chown -R www-data:www-data /var/www/html

EXPOSE 9000

CMD ["sh", "-c", "init.sh"]
