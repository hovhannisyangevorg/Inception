#!/bin/bash

mkdir -p /home/$USER/data/mariadb
mkdir -p /home/$USER/data/mariadb_logs
mkdir -p /home/$USER/data/mariadb_tmp
mkdir -p /home/$USER/data/mariadb_config

chown -R $USER:$USER /home/$USER/data