#!/bin/sh

adduser -S www-data -G www-data && mkdir -p /var/www/html/adminer/

curl -L -o /var/www/html/adminer/index.php https://www.adminer.org/latest.php
php-fpm82 -F
