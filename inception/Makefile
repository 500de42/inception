COMPOSE = docker compose -f ./srcs/docker-compose.yml

.PHONY: up down build clean fclean re

up:
	@$(COMPOSE) up --build

down:
	@$(COMPOSE) down

downv:
	@$(COMPOSE) down -v

build:
	@$(COMPOSE) build

clean:
	@docker system prune -af

fclean:
	@docker system prune -af --volumes

re: fclean build up