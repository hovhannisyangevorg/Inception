FROM debian:bullseye

LABEL "author"="gehovhan"

RUN apt-get update -y && apt-get upgrade -y && apt-get autoremove -y && apt-get install -y nginx openssl gettext moreutils && rm -rf /var/lib/apt/lists/*

COPY ./conf/default.conf        /etc/nginx/sites-available/default
COPY ./tools/nginx-setup.sh     /etc/nginx/nginx-setup.sh

RUN chmod +x /etc/nginx/nginx-setup.sh

ENTRYPOINT  ["/etc/nginx/nginx-setup.sh"]

CMD ["nginx", "-g", "daemon off;"]