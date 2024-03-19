#!/usr/bin/env bash

# Create directory structure
mkdir -p srcs/requirements/{bonus,mariadb,nginx,tools,wordpress}
mkdir -p ./srcs/requirements/nginx/{conf,tools}
mkdir -p ./srcs/requirements/mariadb/{conf,tools}

# Create files
touch Makefile
touch srcs/docker-compose.yml
touch srcs/.env

# Create subdirectory files
touch srcs/requirements/mariadb/{Dockerfile,.dockerignore}
touch srcs/requirements/nginx/{Dockerfile,.dockerignore}

# Set permissions
chmod -R 775 srcs
chmod 664 Makefile srcs/docker-compose.yml srcs/.env
chmod 664 srcs/requirements/mariadb/{Dockerfile,.dockerignore}
chmod 664 srcs/requirements/nginx/{Dockerfile,.dockerignore}

# Set ownership
chown -R wil:wil .

# Populate srcs/.env
echo "DOMAIN_NAME=wil.42.fr" > srcs/.env
echo "# certificates" >> srcs/.env
echo "CERTS_=./XXXXXXXXXXXX" >> srcs/.env
echo "# MYSQL SETUP" >> srcs/.env
echo "MYSQL_ROOT_PASSWORD=XXXXXXXXXXXX" >> srcs/.env
echo "MYSQL_USER=XXXXXXXXXXXX" >> srcs/.env
echo "MYSQL_PASSWORD=XXXXXXXXXXXX" >> srcs/.env

echo "File hierarchy created successfully."
