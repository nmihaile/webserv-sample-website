IMAGE_NAME	=	webserv
TAG			=	latest

LIGHTRED		=	\033[91m
LIGHTGREEN		=	\033[92m
BOLD			=	\033[1m
REGULAR			=	\033[22m
RESET			=	\033[0m

up:
	docker compose up -d
	@echo "$(LIGHTGREEN)Docker container $(BOLD)webserv$(REGULAR) is running$(RESET)"
	@echo "$(LIGHTGREEN)Execute the webserv container interactively with: $(BOLD)docker exec -it webserv bash$(RESET)"

down:
	docker compose down
	@echo "$(LIGHTRED)Stoped docker container $(bold)webserv$(RESET)"

build:
	docker compose build

rebuild:
	docker build --no-cache -t $(IMAGE_NAME):$(TAG) .

restart: down up

.PHONY: up down build restart logs
