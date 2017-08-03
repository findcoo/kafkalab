build.docker:
	docker build -t kafka ./build/

build: build.docker ## build kafka docker image

run.stage: ## run staged kafka broker, zookeeper
	docker-compose -f docker-compose.test.yml up -d

stop.stage: ## stop staged kafka broker, zookeeper
	docker-compose -f docker-compose.test.yml down

log.stage: ## print stage container log
	docker-compose -f docker-compose.test.yml logs -f

test.consumer: ## testing console consumer
	docker-compose -f docker-compose.test.yml exec broker1 bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning

test.producer: ## testing producer
	docker-compose -f docker-compose.test.yml exec broker1 bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test

help:
	@grep -E '^[a-zA-Z0-9._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
