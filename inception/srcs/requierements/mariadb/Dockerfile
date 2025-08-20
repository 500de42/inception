FROM    alpine:3.21

RUN     apk update && apk add --no-cache mariadb mariadb-client
RUN     mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
RUN     mkdir -p /lib/mysql && chown -R mysql:mysql /lib/mysql
RUN     mkdir -p /log/mysql && chown -R mysql:mysql /log/mysql

COPY    conf/initDB.sql /docker-entrypoint-initdb.d/init.sql
COPY    conf/my.cnf /etc/mysql/my.cnf


CMD     ["mariadbd", "--user=mysql"]