#!/bin/sh

adduser -S www-data -G www-data && mkdir -p /var/www/html/adminer/

curl -L -o /var/www/html/adminer/index.php https://sourceforge.net/projects/adminer.mirror/files/v5.4.0/adminer-5.4.0-mysql-en.php/download
php-fpm82 -F
