#!/bin/sh

FTP_PASSWORD=$(cat /run/secrets/FTP_PASSWORD)

set -e
mkdir -p /var/run/vsftpd/empty

if ! id ftpuser 2>dev/null; then

adduser -h /var/www/html -s /bin/false -D ftpuser
adduser ftpuser www-data
echo "ftpuser:${FTP_PASSWORD}" | chpasswd

find /var/www/html -type d -exec chmod 750 {} \; > /dev/null 2>&1  
find /var/www/html -type f -exec chmod 640 {} \; > /dev/null 2>&1  
echo "permission changed"

fi

vsftpd /etc/vsftpd/vsftpd.conf
