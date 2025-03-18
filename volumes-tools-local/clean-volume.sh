#!/bin/bash

rm -rf  ~/data/wordpress/*
rm -rf  ~/data/mariadb/*

mkdir -p ~/data/wordpress
mkdir -p ~/data/mariadb

wp user list --allow-root --path=/var/www/html