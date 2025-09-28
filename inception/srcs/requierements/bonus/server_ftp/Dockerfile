FROM alpine:3.21

RUN apk update && apk add --no-cache \
    vsftpd \
    lftp \
    busybox-extras \
    curl

# RUN sed -i 's/dl-cdn.alpinelinux.org/mirror1.hs-esslingen.de/g' /etc/apk/repositories \
# && apk update \
# && apk add --no-cache curl

COPY server_ftp.conf /etc/vsftpd/vsftpd.conf
COPY entrypoint.sh /etc/entrypoint.sh

RUN chmod +x /etc/entrypoint.sh 

EXPOSE 21 21000-21010

CMD ["/etc/entrypoint.sh"]