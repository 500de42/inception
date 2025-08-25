#!/bin/sh

sed -i "s/\${MARIADB_USER}/$MARIADB_USER/g" /etc/mysql/init.sql
sed -i "s/\${MARIADB_PASSWORD}/$DB_PASSWORD/g" /etc/mysql/init.sql
sed -i "s/\${MARIADB_DATABASE}/$MARIADB_DATABASE/g" /etc/mysql/init.sql
sed -i "s/\${MARIADB_USER2}/$MARIADB_USER2/g" /etc/mysql/init.sql
sed -i "s/\${MARIADB_PASSWORD2}/$DB_PASSWORD2/g" /etc/mysql/init.sql

mariadb-install-db
mysqld

