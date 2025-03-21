ROOT_DIRECTORY = $(shell git rev-parse --show-toplevel)

up: init
	@echo "Starting Docker Compose..."
	@ROOT_DIRECTORY_INCEPTION="$(ROOT_DIRECTORY)" \
		docker-compose -f "$(ROOT_DIRECTORY)/srcs/docker-compose.yml" up --build -d

re: fclean up
	@echo "Recompiling the project and rebuilding all services..."
	@$(MAKE) fclean
	@$(MAKE) up

down:
	@echo "Stopping and removing containers..."
	@ROOT_DIRECTORY_INCEPTION="$(ROOT_DIRECTORY)" \
		docker-compose -f "$(ROOT_DIRECTORY)/srcs/docker-compose.yml" down -v

fclean: down clean
	@echo "Pruning unused Docker images, containers, and networks..."
	@docker system prune -a -f

clean: down
	@echo "Removing WordPress and MariaDB data..."
	@rm -rf ~/data/wordpress/* ~/data/mariadb/*

init:
	@echo "Initializing server and creating volumes..."
	@./init-server/make-volumes/volume-make.sh

.PHONY: up down fclean vclean mkvolume
