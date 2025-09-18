FROM    alpine:3.21

RUN     apk update && apk add --no-cache mariadb mariadb-client
RUN     mkdir -p /run/mysqld /var/lib/mysql /var/log/mysql \
        && chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/log/mysql
#run/mysqld pour le socket 
COPY    conf/initDB.sql /etc/mysql/init.sql
COPY    conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY    /conf/script.sh .

RUN     chmod +x script.sh
EXPOSE  3306

CMD ["/bin/sh", "-c", "script.sh"]