SHELL=/bin/bash
DOCKER_COMPOSE ?= docker-compose
DOCKER_COMPOSE_EXEC_PHP = $(DOCKER_COMPOSE) exec php

.DEFAULT_GOAL := help

.PHONY: help
help:
	grep -E '^[a-zA-Z-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "[32m%-12s[0m %s\n", $$1, $$2}'

.PHONY: test
test: ## Run tests
	$(DOCKER_COMPOSE_EXEC_PHP) vendor/bin/phpcs -p ./src --standard=PHPCompatibility,PSR2 --runtime-set testVersion 5.3
	$(DOCKER_COMPOSE_EXEC_PHP) vendor/bin/phpcs -p ./src --standard=PHPCompatibility,PSR2 --runtime-set testVersion 5.4
	$(DOCKER_COMPOSE_EXEC_PHP) vendor/bin/phpcs -p ./src --standard=PHPCompatibility,PSR2 --runtime-set testVersion 5.5
	$(DOCKER_COMPOSE_EXEC_PHP) vendor/bin/phpcs -p ./src --standard=PHPCompatibility,PSR2 --runtime-set testVersion 5.6
	$(DOCKER_COMPOSE_EXEC_PHP) vendor/bin/behat