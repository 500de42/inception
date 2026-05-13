FROM    alpine:3.21

RUN     apk update && apk add --no-cache openssl nginx
RUN     apk update && apk upgrade

RUN mkdir -p /etc/nginx/ssl /var/log/nginx /var/run/nginx /var/www/html && \
    chown -R nginx:nginx /var/log/nginx /var/run/nginx /var/www/html

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/localhost.key \
    -out /etc/nginx/ssl/localhost.crt \
    -subj "/CN=kcharbon.42.fr"
    
#Nginx lit automatiquement les fichiers dans /etc/nginx/conf.d/ au démarrage.
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/fastcgi-php.conf /etc/nginx/fastcgi-php.conf
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
