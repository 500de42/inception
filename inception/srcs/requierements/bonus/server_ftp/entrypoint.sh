#!/bin/sh

set -e
mkdir -p /var/run/vsftpd/empty


# WP_URL="http://localhost"   # nom du service WordPress
# echo "Waiting for WordPress to be ready..."
# until  curl -s --connect-timeout 2 "$WP_URL" >/dev/null; do
#     echo "WordPress not ready yet. Waiting 5s..."
#     sleep 5
# done
# echo "WordPress is up! Starting FTP server..."


if ! id ftpuser 2>dev/null; then

adduser -h /var/www/html -s /bin/false -D ftpuser
adduser ftpuser www-data
echo "ftpuser:password" | chpasswd

find /var/www/html -type d -exec chmod 750 {} \;
find /var/www/html -type f -exec chmod 640 {} \;

fi

vsftpd /etc/vsftpd/vsftpd.conf
