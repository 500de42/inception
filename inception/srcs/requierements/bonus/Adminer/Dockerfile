FROM alpine:3.21

RUN apk update && apk add --no-cache php:8.2-apache mysqli 

RUN curl -o /var/www/html/adminer/index.php https://www.adminer.org/latest.php

EXPOSE 8080

CMD ["apache2-foreground"]