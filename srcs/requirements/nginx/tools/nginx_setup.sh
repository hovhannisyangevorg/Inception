#!/bin/bash

# Define certificate information
country="AM"
location="Yerevan"
organization="42Yerevan"
organization_unit="student"
common_name="gehovhan.42.fr"
ssl_key_path="/etc/nginx/ssl/gehovhan.42.fr.key"
ssl_cert_path="/etc/nginx/ssl/gehovhan.42.fr.crt"

# Ensure the directory exists
mkdir -p /etc/nginx/ssl

# Generate SSL certificate and key for NGINX
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -sha256 -keyout "$ssl_key_path" -out "$ssl_cert_path" -subj "/C=$country/L=$location/O=$organization/OU=$organization_unit/CN=$common_name"

cd /etc/nginx/conf.d/ || exit 1

# If default.conf exists, replace placeholders with environment variables
mv default.conf default.conf

chmod 777 /etc/nginx/ssl/gehovhan.42.fr.key

# Start NGINX in the foreground
nginx -g "daemon off;"