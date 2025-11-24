package mongo

import (
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"log"
	"os"

)

type MongoDatabase struct {
	Conn *mongo.Database
}

func NewMongoDatabase(collection *mongo.Collection) *MongoDatabase {
	client, err := mongo.Connect(nil, options.Client().ApplyURI(os.Getenv("MONGO_URI")))
	if err != nil {
		log.Fatalf("Failed to connect to MongoDB: %v", err)
	}
	conn := client.Database("goddit")

	return &MongoDatabase{Conn: conn}
}

