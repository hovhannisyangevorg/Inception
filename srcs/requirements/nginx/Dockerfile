FROM alpine:3.19

# Set build arguments for NGINX configuration paths
ARG NGINX_CONFIG_PATH_IN_CONTAINER=/etc/nginx/sites-available/
ARG NGINX_CONFIG_PATH_HOST=/conf/default.conf

# Update package repository, install required packages, and clean up
RUN apk update && apk upgrade && \
    apk add --no-cache nginx openssl go bash && \
    rm -rf /var/cache/apk/*

# Copy NGINX configuration into the container
COPY ${NGINX_CONFIG_PATH_HOST} ${NGINX_CONFIG_PATH_IN_CONTAINER}

# Set working directory for additional scripts and configurations
WORKDIR /Inception/srcs/requirements/nginx/tools

# Copy the setup script
COPY /tools/nginx_setup.sh .

# Expose port 443 for HTTPS traffic
EXPOSE 443

# Ensure the setup script is executable
RUN chmod +x nginx_setup.sh

# Command to start NGINX using the setup script
CMD ["/bin/bash", "nginx_setup.sh"]
