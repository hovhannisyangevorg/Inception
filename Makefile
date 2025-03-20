ROOT_DIRECTORY = $(shell git rev-parse --show-toplevel)

up: mkvolume
	ROOT_DIRECTORY_INCEPTION="$(ROOT_DIRECTORY)" docker-compose -f $(ROOT_DIRECTORY)/srcs/docker-compose.yml up --build -d

down:
	ROOT_DIRECTORY_INCEPTION="$(ROOT_DIRECTORY)" docker-compose -f $(ROOT_DIRECTORY)/srcs/docker-compose.yml down -v

fclean: down vclean
	docker system prune -a -f

vclean:
	rm -rf ~/data/wordpress/* ~/data/mariadb/*

mkvolume:
	mkdir -p ~/data/wordpress ~/data/mariadb

.PHONY: up down fclean vclean mkvolume
