#!/bin/bash
#set -e

mysqld &
pid="$!"

while ! mysqladmin ping --silent; do
    sleep 1
done

envsubst < /docker-entrypoint-initdb.d/initdb.sql | sponge /docker-entrypoint-initdb.d/initdb.sql

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ];
then
      mysql -u$MYSQL_USER -p$MYSQL_PASSWORD < /docker-entrypoint-initdb.d/initdb.sql
fi

wait "$pid"