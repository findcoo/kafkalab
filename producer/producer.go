package producer

import (
	"log"
	"os"
	"os/signal"
	"time"

	"github.com/Shopify/sarama"
)

func producer() {
	config := sarama.NewConfig()
	config.Producer.RequiredAcks = sarama.RequiredAcks

	producer, err := sarama.NewSyncProducer([]string{"127.0.0.1:9092"}, nil)
	if err != nil {
		panic(err)
	}

	defer func() {
		if err := producer.Close(); err != nil {
			log.Fatal(err)
		}
	}()

	signals := make(chan os.Signal, 1)
	signal.Notify(signals, os.Interrupt)

	msg := &sarama.ProducerMessage{
		Topic: "test_topic",
		Key:   nil,
		Value: sarama.StringEncoder("testing 123"),
	}
	partition, offset, err := producer.SendMessage(msg)
	if err != nil {
		log.Panic(err)
	}

	log.Printf("> message sent to partition %d at offset %d\n", partition, offset)
}

func consumer() {
	consumer, err := sarama.NewConsumer([]string{"127.0.0.1:9092"}, nil)
	if err != nil {
		log.Panic(err)
	}

	defer func() {
		if err := consumer.Close(); err != nil {
			log.Fatal(err)
		}
	}()

	partitionConsumer, err := consumer.ConsumePartition("test_topic", 0, sarama.OffsetNewest)
	if err != nil {
		log.Panic(err)
	}

	for {
		select {
		case msg := <-partitionConsumer.Messages():
			log.Printf("Consumed message offset %d\n", msg.Offset)
			log.Printf("Consumed message is %s\n", msg.Value)
		case <-time.After(time.Second * 5):
			return
		}
	}
}
