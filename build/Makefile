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

zoo.stage:
	bin/zookeeper-server-start.sh config/zookeeper.stage.properties

broker.stage:
	bin/kafka-server-start.sh config/broker.stage.properties

zoo1:
	bin/zookeeper-server-start.sh config/zookeeper.properties

zoo2:
	bin/zookeeper-server-start.sh config/zookeeper.properties

zoo3:
	bin/zookeeper-server-start.sh config/zookeeper.properties

broker1:
	bin/kafka-server-start.sh config/broker1.properties

broker2:
	bin/kafka-server-start.sh config/broker2.properties
