package producer

import (
	"log"
	"os"
	"os/signal"

	"github.com/Shopify/sarama"
)

func test() {
	producer, err := sarama.NewSyncProducer([]string{"localhost:9092"}, nil)
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
