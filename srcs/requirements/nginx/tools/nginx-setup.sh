#!/bin/bash

envsubst < /etc/nginx/sites-available/default.conf | sponge /etc/nginx/sites-available/default.conf

nginx -g "daemon off;"