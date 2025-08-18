FROM    alpine:3.21

RUN     apk update && apk add --no-cache openssl nginx
RUN     apk update && apk upgrade

COPY . .
#dossier standard pour stocker les certificats dans Nginx
COPY conf/ssl/localhost.crt /etc/nginx/ssl/
COPY conf/ssl/localhost.key /etc/nginx/ssl/

#Nginx lit automatiquement les fichiers dans /etc/nginx/conf.d/ au démarrage.
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY Index.html /var/www/html/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
