FROM alpine:3.21

RUN apk update && apk add --no-cache vsftpd lftp busybox-extras

COPY server_ftp.conf /etc/vsftpd.conf
COPY entrypoint.sh /etc/entrypoint.sh

RUN chmod +x /etc/entrypoint.sh 

EXPOSE 21 21000-21010

CMD ["/etc/entrypoint.sh"]