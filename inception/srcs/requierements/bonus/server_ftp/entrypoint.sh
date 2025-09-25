#!/bin/sh

set -e

if ! id ftpuser 2>dev/null; then

adduser -h /var/www/html -s /bin/false -D ftpuser
adduser ftpuser www-data
echo "ftpuser:password" | chpasswd

find /var/www/html -type d -exec chmod 750 {} \;
find /var/www/html -type f -exec chmod 640 {} \;

fi

vsftpd /etc/vsftpd.conf
