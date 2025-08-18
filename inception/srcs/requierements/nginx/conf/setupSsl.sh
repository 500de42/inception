#!/bin/sh
mkdir -p conf/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout conf/ssl/localhost.key \
  -out conf/ssl/localhost.crt \
  -subj "/CN=localhost"
chmod 600 conf/ssl/localhost.key
#chmod 666 /etc/nginx/conf.d/default.conf
