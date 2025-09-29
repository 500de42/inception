FROM alpine:3.21

RUN apk update && apk add --no-cache busybox_extras \
    && mkdir -p /var/www/html/

COPY website.html /var/www/html/index.html

EXPOSE 8080

CMD ["httpd", "-f", "-p", "8080", "-h", "/var/www/html/static"]
