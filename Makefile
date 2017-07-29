KAFKA_VERSION=0.11.0.0
SCALA_VERSION=2.11
DIR_NAME=kafka_$(SCALA_VERSION)-$(KAFKA_VERSION)


ifneq ("$(wildcard ./kafka)","")
$(shell rm -rf ./kafka)
endif


install:
	wget http://mirror.navercorp.com/apache/kafka/$(KAFKA_VERSION)/$(DIR_NAME).tgz	
	mkdir ./kafka
	tar zxvf $(DIR_NAME).tgz -C ./kafka --strip-components=1
	rm -rf ./$(DIR_NAME).tgz*

build:
	docker build -t kafka .

run:
	docker run -it --rm --name kafka
