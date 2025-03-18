#!/bin/bash

# Variables
country="AM"
location="Yerevan"
organization="42Yerevan"
organization_unit="student"
common_name="gehovhan.42.fr"
ssl_key_path="/etc/nginx/ssl/gehovhan.42.fr.key"
ssl_cert_path="/etc/nginx/ssl/gehovhan.42.fr.crt"

openssl genpkey -algorithm RSA -out "$ssl_key_path" -pkeyopt rsa_keygen_bits:2048
openssl req -new -key "$ssl_key_path" -out "/tmp/$common_name.csr" -subj "/C=$country/ST=$location/L=$location/O=$organization/OU=$organization_unit/CN=$common_name"
openssl x509 -req -in "/tmp/$common_name.csr" -signkey "$ssl_key_path" -out "$ssl_cert_path" -days 365
rm -f "/tmp/$common_name.csr"

echo "SSL certificate and key generated successfully."
