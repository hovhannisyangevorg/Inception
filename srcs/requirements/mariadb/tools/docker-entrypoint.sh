#!/usr/bin/env bash

log_info() { echo -e "\033[32m[ INFO ] $1\033[0m"; }
log_error() { echo -e "\033[31m[ ERROR ] $1\033[0m"; }

log_info "Checking MySQL runtime directory..."
if [ ! -d "/run/mysqld" ];
then
  log_info "Creating /run/mysqld directory..."
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

log_info "Ensuring MySQL data directory exists..."
mkdir -p /var/lib/mysql

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ];
then
  log_info "Initializing MySQL database..."
	mysql_install_db;
  /usr/bin/mysqld_safe &
  sleep 3;
	envsubst < /docker-entrypoint-initdb.d/2025_03_21_202644_initdb.sql | sponge /docker-entrypoint-initdb.d/2025_03_21_202644_initdb.sql
	mariadb < /docker-entrypoint-initdb.d/2025_03_21_202644_initdb.sql;
	mysqladmin -u root password $MYSQL_ROOT_PASSWORD;
	mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown;
fi

log_info "Cleaning up initialization files..."
rm -rf /docker-entrypoint-initdb.d/docker-entrypoint.sh /docker-entrypoint-initdb.d/2025_03_21_202644_initdb.sql

exec "$@";
