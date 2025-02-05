#!/bin/bash
set -e

mysqld &
pid="$!"

while ! mysqladmin ping --silent; do
    sleep 1
done

envsubst < /docker-entrypoint-initdb.d/initdb.sql | sponge /docker-entrypoint-initdb.d/initdb.sql

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ];
then
    echo "Initializing database $MYSQL_DATABASE..."
    mysql < /docker-entrypoint-initdb.d/initdb.sql
fi

wait "$pid"
