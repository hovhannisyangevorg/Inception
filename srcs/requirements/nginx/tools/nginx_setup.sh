#!/bin/bash

# Define certificate information
country="AM"
location="Yerevan"
organization="42Yerevan"
organization_unit="student"
common_name="gehovhan.42.fr"

# Generate SSL certificate and key for NGINX
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$SSL_KEY_PATH" -out "$SSL_CERT_PATH" \
  -subj "/C=$country/L=$location/O=$organization/OU=$organization_unit/CN=$common_name"

cd /etc/nginx/sites-available/ || exit 1

# If default.conf exists, replace placeholders with environment variables
if [ -f ./default.conf ]; then
    sed -i "s#\\$DOMAIN_NAME#$common_name#g"      default.conf
    sed -i "s#\\$SSL_CERT_PATH#$SSL_CERT_PATH#g"  default.conf
    sed -i "s#\\$SSL_KEY_PATH#$SSL_KEY_PATH#g"    default.conf

    mv default.conf default
fi

# Start NGINX in the foreground
nginx -g "daemon off;"