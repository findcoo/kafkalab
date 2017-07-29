KAFKA_VERSION=0.11.0.0
SCALA_VERSION=2.11
DIR_NAME=kafka_$(SCALA_VERSION)-$(KAFKA_VERSION)


ifneq ("$(wildcard ./kafka)","")
$(shell rm -rf ./kafka)
endif


install:
	wget http://mirror.navercorp.com/apache/kafka/$(KAFKA_VERSION)/$(DIR_NAME).tgz	
	tar zxvf $(DIR_NAME).tgz
	rm -rf ./$(DIR_NAME).tgz*

build:
	docker build -t kafka .

run:
	docker run -d -p 2181:2181 -p 9092-9100:9092-9100 --name kafka kafka

zookeeper:
	bin/zookeeper-server-start.sh config/zookeeper.properties

kafka:
	bin/kafka-server-start.sh config/server.properties
