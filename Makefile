SERVICE = $(c) 									# Service name passed as an argument
COMPOSE_FILE = ./srcs/docker-compose.yml

# Start the specified service in detached mode
up:
	docker-compose -f $(COMPOSE_FILE) up --build -d $(SERVICE)

# Stop and remove all containers defined in the Compose file
down:
	docker-compose -f $(COMPOSE_FILE) down

# Stop the specified service
#stop:
#	docker-compose -f $(COMPOSE_FILE) stop $(SERVICE)

# Start the specified service (already created)
#start:
#	docker-compose -f $(COMPOSE_FILE) start $(SERVICE)

# List containers and their status
#ps:
#	docker-compose -f $(COMPOSE_FILE) ps


