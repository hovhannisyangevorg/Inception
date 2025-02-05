FROM debian:stable-slim

RUN apt -y update && apt -y upgrade && \
    apt -y install mariadb-server mariadb-client gettext moreutils

RUN mkdir -p /var/lib/mysql /run/mysqld /usr/share/mysql /var/log/mysql && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld /usr/share/mysql /var/log/mysql && \
    chmod 755 /var/lib/mysql /run/mysqld /usr/share/mysql /var/log/mysql

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY ./migrations/initdb.sql /docker-entrypoint-initdb.d/initdb.sql

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

CMD ["/usr/local/bin/docker-entrypoint.sh"]
