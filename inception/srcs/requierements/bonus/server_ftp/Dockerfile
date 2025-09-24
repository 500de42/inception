FROM alpine:3.21

RUN apk update && apk add --no-cache vsftpd lftp busybox-extras \
    && adduser -h /var/www/html -s /bin/false ftpuser

COPY server_ftp.conf /etc/vsftpd.conf

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 21 21000-21010

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]