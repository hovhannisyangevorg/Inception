FROM debian:bullseye

LABEL "author"="gehovhan"

ENV COUNTRY="AM"
ENV LOCATION="Yerevan"
ENV ORGANIZATION="42Yerevan"
ENV ORGANIZATION_UNIT="student"
ENV COMMON_NAME="gehovhan.42.fr"

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get autoremove -y && \
    apt-get install -y nginx openssl gettext moreutils && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl && openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/${COMMON_NAME}.crt -keyout /etc/nginx/ssl/${COMMON_NAME}.key -subj "/C=${COUNTRY}/ST=${LOCATION}/L=${LOCATION}/O=${ORGANIZATION}/OU=${ORGANIZATION_UNIT}/CN=${COMMON_NAME}"

COPY ./conf/default.conf        /etc/nginx/sites-available/
COPY ./tools/nginx-setup.sh     /etc/nginx/nginx-setup.sh

RUN chmod +x /etc/nginx/nginx-setup.sh

CMD ["/etc/nginx/nginx-setup.sh"]
