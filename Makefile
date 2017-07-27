KAFKA_VERSION=0.11.0.0
SCALA_VERSION=2.11
DIR_NAME=kafka_$(SCALA_VERSION)-$(KAFKA_VERSION)


ifneq ("$(wildcard /usr/local/lib/$(DIR_NAME))","")
$(shell rm -rf /usr/local/lib/$(DIR_NAME))
endif


install:
	wget http://mirror.navercorp.com/apache/kafka/$(KAFKA_VERSION)/$(DIR_NAME).tgz	
	tar zxvf $(DIR_NAME).tgz
	mv $(DIR_NAME) /usr/local/lib/
	rm -rf ./$(DIR_NAME).tgz*
	ln -sf /usr/local/lib/$(DIR_NAME)/bin/* /usr/local/bin/
