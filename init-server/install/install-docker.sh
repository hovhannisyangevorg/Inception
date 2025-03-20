#!/usr/bin/env bash

sudo apt-get update -y && sudo apt-get upgrade -y
sudo curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh && rm -f get-docker.sh
echo "alias docker-compose='docker compose'" >> ~/.bashrc

source ~/.bashrc
docker --version
docker compose --version