#!/usr/bin/env bash

if [ ! -d "/run/mysqld" ];
then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

mkdir -p /var/lib/mysql
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ];
then
	mysql_install_db;
  /usr/bin/mysqld_safe &
  sleep 3;
	envsubst < /docker-entrypoint-initdb.d/2025_03_21_202644_initdb.sql | sponge /docker-entrypoint-initdb.d/2025_03_21_202644_initdb.sql
	mariadb < /docker-entrypoint-initdb.d/2025_03_21_202644_initdb.sql;
	mysqladmin -u root password $MYSQL_ROOT_PASSWORD;
	mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown;
fi

rm -rf /docker-entrypoint-initdb.d/docker-entrypoint.sh /docker-entrypoint-initdb.d/2025_03_21_202644_initdb.sql

exec "$@";
