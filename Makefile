IMAGE_NAME	=	webserv
TAG			=	latest

RED				=	\033[31m
GREEN			=	\033[32m
LIGHTRED		=	\033[91m
LIGHTGREEN		=	\033[92m
BOLD			=	\033[1m
REGULAR			=	\033[22m
RESET			=	\033[0m

up:
	docker compose up -d
	@echo "$(GREEN)Docker container $(BOLD)webserv$(REGULAR) is running$(RESET)"
	@echo "$(GREEN)Execute the $(LIGHGREEN)webserv$(GREEN) container interactively with: $(LIGHTGREEN)$(BOLD)docker exec -it webserv bash$(RESET)"

down:
	docker compose down
	@echo "$(RED)Stopped docker container: $(LIGHTRED)$(bold)webserv$(RESET)"

build:
	docker compose build

rebuild:
	docker build --no-cache -t $(IMAGE_NAME):$(TAG) .

restart: down up

.PHONY: up down build restart logs
