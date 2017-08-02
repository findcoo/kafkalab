build.docker:
	docker build -t kafka ./build/

build: build.docker ## build kafka docker image

run.stage: ## run staged kafka broker, zookeeper
	docker-compose -f docker-compose.test.yml up -d

stop.stage: ## stop staged kafka broker, zookeeper
	docker-compose -f docker-compose.test.yml down

help:
	@grep -E '^[a-zA-Z0-9._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
