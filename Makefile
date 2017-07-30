docker.build:
	docker build -t kafka ./build/

build: docker.build

run:
	docker run -d -p 2181:2181 -p 9092-9100:9092-9100 --name kafka kafka

stage:
	docker-compose -f docker-compose.test.yml up -d

stage.down:
	docker-compose -f docker-compose.test.yml down
