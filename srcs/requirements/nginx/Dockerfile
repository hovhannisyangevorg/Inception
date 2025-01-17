FROM debian:buster

# Set build arguments for NGINX configuration paths
ARG NGINX_CONFIG_PATH_IN_CONTAINER=/etc/nginx/sites-available/
ARG NGINX_CONFIG_PATH_HOST=/conf/default.conf

# Update package repository, install required packages, and clean up
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# Copy NGINX configuration into the container
COPY ${NGINX_CONFIG_PATH_HOST} ${NGINX_CONFIG_PATH_IN_CONTAINER}

# Set working directory for additional scripts and configurations
WORKDIR /Inception/srcs/requirements/nginx/tools

# Copy the setup script
COPY /tools/nginx_setup.sh .

# Ensure the setup script is executable
RUN chmod +x nginx_setup.sh

# Command to start NGINX using the setup script
CMD ["/bin/bash", "nginx_setup.sh"]
