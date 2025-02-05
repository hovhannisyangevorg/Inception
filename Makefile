SERVICE = $(c)
ROOT_DIRECTORY = $(shell git rev-parse --show-toplevel)

up:
	export ROOT_DIRECTORY_INCEPTION="$(ROOT_DIRECTORY)" && docker-compose -f $(ROOT_DIRECTORY)/srcs/docker-compose.yml up --build -d

down:
	export ROOT_DIRECTORY_INCEPTION="$(ROOT_DIRECTORY)" && docker-compose -f $(ROOT_DIRECTORY)/srcs/docker-compose.yml down -v













# TODO: root_directory_path redirect in top level .env file after push ...
#SERVICE = $(c)
#ROOT_DIRECTORY = $(shell git rev-parse --show-toplevel)
#
#setrootdir:
#	@sed -i "s#root_directory_path#export ROOT_DIRECTORY_INCEPTION=\"$(ROOT_DIRECTORY)\"#g" ~/.bashrc
#	@bash -i -c "source ~/.bashrc"
#
#unsetrootdir:
#	@sed -i "s#export ROOT_DIRECTORY_INCEPTION=\"$(ROOT_DIRECTORY)\"#root_directory_path#g" ~/.bashrc
#	@bash -i -c "source ~/.bashrc"
#
#up: setrootdir
#	docker-compose -f $(ROOT_DIRECTORY)/srcs/docker-compose.yml up --build -d
#
#down: unsetrootdir
#	docker-compose -f $(COMPOSE_FILE) down -v

# Stop the specified service
#stop:
#	docker-compose -f $(COMPOSE_FILE) stop $(SERVICE)

# Start the specified service (already created)
#start:
#	docker-compose -f $(COMPOSE_FILE) start $(SERVICE)

# List containers and their status
#ps:
#	docker-compose -f $(COMPOSE_FILE) ps

#clean-docker:
#	docker system prune -a -f

#.PHONY: clean-docker





