FROM alpine:3.21

WORKDIR /var/www/html
RUN apk update
RUN apk add --no-cache wget tar \
    php82 php82-session php82-openssl php82-iconv php82-json php82-xml php82-mbstring php82-mysqli php82-curl php82-phar php82-fpm php82-pecl-redis\
    mariadb-client curl bash less && adduser -S www-data -G www-data
RUN ln -s /usr/bin/php82 /usr/bin/php
RUN wget https://github.com/WordPress/WordPress/archive/refs/tags/6.4.3.tar.gz -O /tmp/wordpress.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
    rm /tmp/wordpress.tar.gz

RUN curl -fsSL -o /usr/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/bin/wp
COPY conf/init.conf /etc/php82/php-fpm.d/www.conf
COPY conf/init.sh /usr/local/bin/init.sh

RUN chmod +x /etc/php82/php-fpm.d/www.conf /usr/local/bin/init.sh
RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

CMD ["sh", "-c", "init.sh && php-fpm82 -F"]
