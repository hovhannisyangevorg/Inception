FROM debian:bullseye

LABEL "author"="gehovhan"

ENV PHP_VERSION=7.4

RUN apt update \
	&& apt upgrade -y \
	&& apt install -y \
	curl \
	php${PHP_VERSION} \
	php${PHP_VERSION}-mysql \
	php${PHP_VERSION}-fpm \
	php${PHP_VERSION}-pdo \
	php${PHP_VERSION}-gd \
	php${PHP_VERSION}-cli \
	php${PHP_VERSION}-mbstring \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/*

RUN sed -i "s/listen = .*/listen = 0.0.0.0:9000/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    ln -s /usr/local/bin/wp /usr/local/bin/wp-cli

COPY ./tools/wordpress-setup.sh /wp/scripts/wordpress-setup.sh

RUN chmod +x /wp/scripts/wordpress-setup.sh

WORKDIR /var/www/html
ENTRYPOINT ["/wp/scripts/wordpress-setup.sh"]

CMD ["php-fpm7.4", "-F"]
