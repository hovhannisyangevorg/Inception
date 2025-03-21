FROM        debian:bullseye

LABEL       "author"="gehovhan"

RUN         apt update && apt upgrade -y && apt install -y mariadb-server mariadb-client gettext moreutils

COPY        ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY        ./tools/docker-entrypoint.sh /docker-entrypoint-initdb.d/docker-entrypoint.sh
COPY        ./migrations/2025_03_21_202644_initdb.sql /docker-entrypoint-initdb.d/2025_03_21_202644_initdb.sql

RUN         chmod 766 /docker-entrypoint-initdb.d/docker-entrypoint.sh && chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf
RUN         echo "alias mysqlstart='/usr/bin/mysqld_safe'" >> /etc/bash.bashrc

ENTRYPOINT  ["/docker-entrypoint-initdb.d/docker-entrypoint.sh"]

CMD         ["mysqld"]

