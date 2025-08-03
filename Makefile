IMAGE_NAME	=	webserv
TAG			=	latest

RED				=	\033[31m
GREEN			=	\033[32m
LIGHTRED		=	\033[91m
LIGHTGREEN		=	\033[92m
LIGHTCYAN		=	\033[96m
BOLD			=	\033[1m
REGULAR			=	\033[22m
RESET			=	\033[0m

build: check-env
	docker compose build;
	@echo "$(LIGHTCYAN)now run:$(LIGHTGREEN) make up"

rebuild: check-env
	docker build --no-cache -t $(IMAGE_NAME):$(TAG) .;
	@echo "$(LIGHTCYAN)now run:$(LIGHTGREEN) make up"

check-env:
	@if [ ! -f .env ]; then \
		read -p "Enter absolute path to your repository: " repo_path; \
		case $$repo_path in \
			*/) ;; \
			*) repo_path="$$repo_path/";; \
		esac; \
		echo "REPO_PATH=$$repo_path" > .env; \
		printf "\033[92mcreated environment file '.env'\033[0m\n"; \
	fi

up:
	docker compose up -d
	@echo "$(GREEN)Docker container $(BOLD)webserv$(REGULAR) is running$(RESET)"
	@echo "$(GREEN)Execute the $(LIGHGREEN)webserv$(GREEN) container interactively with: $(LIGHTGREEN)$(BOLD)docker exec -it webserv bash$(RESET)"

down:
	docker compose down
	@echo "$(RED)Stopped docker container: $(LIGHTRED)$(bold)webserv$(RESET)"

restart: down up

fclean: down
	rm -rf .env
	docker rmi -f webserv

.PHONY: up down build restart logs
