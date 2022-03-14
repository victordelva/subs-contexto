.PHONY = default deps build test start-mooc-backend clean start-database start-backoffice-frontend

# Shell to use for running scripts
SHELL := $(shell which bash)
IMAGE_NAME := codelytv/typescript-ddd-skeleton
SERVICE_NAME := app
MOOC_APP_NAME := mooc
BACKOFFICE_APP_NAME := backoffice

# Test if the dependencies we need to run this Makefile are installed
DOCKER := $(shell command -v docker)
DOCKER_COMPOSE := $(shell command -v docker-compose)
deps:
ifndef DOCKER
	@echo "Docker is not available. Please install docker"
	@exit 1
endif
ifndef DOCKER_COMPOSE
	@echo "docker-compose is not available. Please install docker-compose"
	@exit 1
endif

default: build

# Build image
build:
	docker build -t $(IMAGE_NAME):dev .

# Start Dev App
start: build
	docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d 

# Bash container
bash:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml exec mooc-backend bash


test:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml run mooc-backend npm run test:mooc:backend:features

down: 
	docker-compose -f docker-compose.yml -f docker-compose.override.yml down