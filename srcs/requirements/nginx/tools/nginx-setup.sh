#!/bin/bash

log_info() { echo -e "\033[32m[ INFO ] $1\033[0m"; }
log_error() { echo -e "\033[31m[ ERROR ] $1\033[0m"; }

log_info "Creating SSL directory and Generating SSL certificate..."
mkdir -p /etc/nginx/ssl && \
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
  -out /etc/nginx/ssl/$COMMON_NAME.crt -keyout /etc/nginx/ssl/$COMMON_NAME.key \
  -subj "/C=$COUNTRY/ST=$LOCATION/L=$LOCATION/O=$ORGANIZATION/OU=$ORGANIZATION_UNIT/CN=$COMMON_NAME"

log_info "Replacing environment variables in Nginx configuration..."
envsubst '${DOMAIN_NAME} ${SSL_CERT_PATH} ${SSL_KEY_PATH} ${WORDPRESS_HOSTNAME}' < /etc/nginx/sites-available/default | sponge /etc/nginx/sites-available/default
rm -rf /etc/nginx/nginx-setup.sh

exec "$@";