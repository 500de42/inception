#!/bin/sh

chown -R mysql:mysql /var/lib/mysql /etc/mysql/init.sql
chmod 750 /var/lib/mysql /etc/mysql/init.sql

sed -i "s/\${MARIADB_USER}/$MARIADB_USER/g" /etc/mysql/init.sql
sed -i "s/\${DB_PASSWORD}/$DB_PASSWORD/g" /etc/mysql/init.sql
sed -i "s/\${MARIADB_DATABASE}/$MARIADB_DATABASE/g" /etc/mysql/init.sql
sed -i "s/\${MARIADB_USER2}/$MARIADB_USER2/g" /etc/mysql/init.sql
sed -i "s/\${DB_PASSWORD2}/$DB_PASSWORD2/g" /etc/mysql/init.sql
sed -i "s/\${MARIADB_ROOT_PASSWORD}/$MARIADB_ROOT_PASSWORD/g" /etc/mysql/init.sql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initialisation de la base..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

mysqld --user=mysql