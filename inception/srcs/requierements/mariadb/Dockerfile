FROM    alpine:3.21

RUN     apk update && apk add mariadb  

#COPY ~/repo/inception/secrets/db_password.txt 
#COPY ~/repo/inception/secrets/db_root_password.txt 


VOLUME ~/data/WordpressDB

CMD ["service", "mysql",  "start"];
