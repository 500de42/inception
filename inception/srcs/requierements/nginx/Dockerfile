FROM    alpine:3.21

RUN     apk update && apk add --no-cache openssl nginx
RUN     apk update && apk upgrade

RUN mkdir -p /etc/nginx/ssl /var/log/nginx /var/run/nginx /var/www/html && \
    chown -R nginx:nginx /var/log/nginx /var/run/nginx /var/www/html
    
COPY . .
#dossier standard pour stocker les certificats dans Nginx
COPY conf/ssl/localhost.crt /etc/nginx/ssl/
COPY conf/ssl/localhost.key /etc/nginx/ssl/ 

#Nginx lit automatiquement les fichiers dans /etc/nginx/conf.d/ au démarrage.
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/fastcgi-php.conf /etc/nginx/fastcgi-php.conf
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
