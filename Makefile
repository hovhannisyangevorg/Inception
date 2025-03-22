ROOT_DIRECTORY = $(shell git rev-parse --show-toplevel)

up: init
	@ROOT_DIRECTORY_INCEPTION="$(ROOT_DIRECTORY)" docker-compose -f "$(ROOT_DIRECTORY)/srcs/docker-compose.yml" up --build -d

down:
	@ROOT_DIRECTORY_INCEPTION="$(ROOT_DIRECTORY)" docker-compose -f "$(ROOT_DIRECTORY)/srcs/docker-compose.yml" down -v

re: fclean up


fclean: clean
	@docker system prune -a -f
	@docker volume prune -f
	@docker network prune -f

clean: down
	@docker stop $(docker ps -qa) 2>/dev/null || true
	@docker rm $(docker ps -qa) 2>/dev/null || true
	@docker rmi -f $(docker images -qa) 2>/dev/null || true
	@docker volume rm $(docker volume ls -q) 2>/dev/null || true
	@docker network rm $(docker network ls -q) 2>/dev/null || true
	@rm -rf ~/data/wordpress/ ~/data/mariadb/

init:
	@mkdir -p ~/data/wordpress ~/data/mariadb

.PHONY: up down re fclean clean init
