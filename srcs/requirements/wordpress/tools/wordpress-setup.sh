#!/bin/bash

WP_DIR="/var/www/html"

log_info() { echo -e "\033[32m[ INFO ] $1\033[0m" }
log_error() { echo -e "\033[31m[ ERROR ] $1\033[0m" }

mkdir -p $WP_DIR
rm -rf $WP_DIR/*

if wp core download --allow-root --path=$WP_DIR; then
    log_info "WordPress core downloaded successfully."
else
    log_error "Failed to download WordPress core."
fi

if cp $WP_DIR/wp-config-sample.php $WP_DIR/wp-config.php; then
    log_info "wp-config.php created."
else
    log_error "Failed to create wp-config.php."
fi

sed -i "s/define( 'DB_NAME', '.*' );/define( 'DB_NAME', '${MYSQL_DATABASE}' );/g" $WP_DIR/wp-config.php
sed -i "s/define( 'DB_USER', '.*' );/define( 'DB_USER', '${MYSQL_USER}' );/g" $WP_DIR/wp-config.php
sed -i "s/define( 'DB_PASSWORD', '.*' );/define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );/g" $WP_DIR/wp-config.php
sed -i "s/define( 'DB_HOST', '.*' );/define( 'DB_HOST', '${MYSQL_HOSTNAME}' );/g" $WP_DIR/wp-config.php

# Install WordPress
if wp core install --allow-root --url="$DOMAIN_NAME" --title="$WORDPRESS_TITLE" --admin_user="$WORDPRESS_ROOT_USERNAME" --admin_password="$WORDPRESS_ROOT_PASSWORD" --admin_email="$WORDPRESS_ROOT_EMAIL" --path=$WP_DIR; then
    log_info "WordPress installed successfully."
else
    log_error "Failed to install WordPress."
fi

if wp user get "$WORDPRESS_USER_USERNAME" --allow-root --path=$WP_DIR > /dev/null 2>&1; then
    log_info "User '$WORDPRESS_USER_USERNAME' already exists."
else
    if wp user create "$WORDPRESS_USER_USERNAME" \
        "$WORDPRESS_USER_EMAIL" \
        --role="$WORDPRESS_USER_ROLE" \
        --user_pass="$WORDPRESS_USER_PASSWORD" \
        --first_name="$WORDPRESS_USER_FIRST_NAME" \
        --last_name="$WORDPRESS_USER_LAST_NAME" \
        --send-email \
        --allow-root \
        --path=$WP_DIR; then
        log_info "WordPress user '$WORDPRESS_USER_USERNAME' created successfully."
    else
        log_error "Failed to create WordPress user '$WORDPRESS_USER_USERNAME'."
    fi
fi

if wp core update --allow-root --path=$WP_DIR; then
    log_info "WordPress core updated successfully."
else
    log_error "Failed to update WordPress core."
fi

mkdir -p /run/php && chown -R www-data:www-data /run/php

if ! wp theme is-active twentytwentytwo --allow-root --path=$WP_DIR; then
    wp theme install twentytwentytwo --activate --allow-root --path=$WP_DIR
    log_info "WordPress theme installed and activated successfully."
else
    log_info "The 'Twenty Twenty-Two' theme is already active."
fi

exec "$@"
