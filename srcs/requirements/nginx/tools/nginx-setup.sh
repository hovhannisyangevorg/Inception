#!/bin/bash

mkdir -p /etc/nginx/ssl && \
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
  -out /etc/nginx/ssl/$COMMON_NAME.crt -keyout /etc/nginx/ssl/$COMMON_NAME.key \
  -subj "/C=$COUNTRY/ST=$LOCATION/L=$LOCATION/O=$ORGANIZATION/OU=$ORGANIZATION_UNIT/CN=$COMMON_NAME"

envsubst < /etc/nginx/sites-available/default.conf | sponge /etc/nginx/sites-available/default.conf

nginx -g "daemon off;"