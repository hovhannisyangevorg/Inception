#!/bin/bash

log_info() { echo -e "\033[32m[ INFO ] $1\033[0m"; }
log_error() { echo -e "\033[31m[ ERROR ] $1\033[0m"; }

mkdir -p /run/php && chmod 777 -R /run/php && chown -R www-data:www-data /run/php

log_info "Removing existing files from the /var/www/html."
rm -rf /var/www/html/*

log_info "Downloading WordPress"
wp core download --allow-root

log_info "Creating wp-config.php file"
wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="$MYSQL_HOSTNAME" --allow-root

log_info "Installing WordPress"
wp core install --allow-root --url="$DOMAIN_NAME" --title="$WORDPRESS_TITLE" --admin_user="$WORDPRESS_ROOT_USERNAME" --admin_password="$WORDPRESS_ROOT_PASSWORD" --admin_email="$WORDPRESS_ROOT_EMAIL"

log_info "Creating WordPress user: $WORDPRESS_USER_USERNAME"
wp user create $WORDPRESS_USER_USERNAME $WORDPRESS_USER_EMAIL --role=$WORDPRESS_USER_ROLE --first_name=$WORDPRESS_USER_FIRST_NAME --last_name=$WORDPRESS_USER_LAST_NAME --user_pass="$WORDPRESS_USER_PASSWORD" --allow-root

log_info "WordPress core updated"
wp core update --allow-root --path="/var/www/html/"

log_info "WordPress theme installed and activated"
wp theme install twentytwentytwo --activate --allow-root

log_info "WordPress setup and user creation completed successfully"

exec "$@";
