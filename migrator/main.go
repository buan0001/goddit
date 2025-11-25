package main

import (
	"fmt"
	"log"
	"database/sql"
	"os"
	"context"

	"goddit/backend/models"
	_ "github.com/go-sql-driver/mysql"
	"go.mongodb.org/mongo-driver/v2/bson"
	"go.mongodb.org/mongo-driver/v2/mongo"
	"go.mongodb.org/mongo-driver/v2/mongo/options"
	"github.com/joho/godotenv"
)

func main() {
	sqlConn := NewSQLConnection()
	mongoConn := NewMongoConnection()
	defer sqlConn.Close()
	defer mongoConn.Disconnect(context.TODO())

	migrateSQLToMongo(sqlConn, mongoConn)
}

func NewSQLConnection() *sql.DB {
	godotenv.Load(".env")

	dsn := os.Getenv("MYSQL_CONN_STR")

	conn, err := sql.Open("mysql", dsn)
	if err != nil {
		panic(err.Error())
	}

	if err := conn.Ping(); err != nil {
		log.Fatalf("Failed to ping the database: %v", err)
	}

	fmt.Println("Database connection established successfully!")

	return conn
}

func NewMongoConnection() *mongo.Client {
	// Copied from https://www.mongodb.com/docs/drivers/go/current/connect/mongoclient/
	var uri string
	if uri = os.Getenv("MONGO_CONN_STR"); uri == "" {
		log.Fatal("You must set your 'MONGODB_URI' environment variable. See\n\t https://docs.mongodb.com/drivers/go/current/usage-examples/")
	}
	// Uses the SetServerAPIOptions() method to set the Stable API version to 1
	serverAPI := options.ServerAPI(options.ServerAPIVersion1)
	// Defines the options for the MongoDB client
	opts := options.Client().ApplyURI(uri).SetServerAPIOptions(serverAPI)
	// Creates a new client and connects to the server
	client, err := mongo.Connect(opts)
	if err != nil {
		panic(err)
	}
	defer func() {
		if err = client.Disconnect(context.TODO()); err != nil {
			panic(err)
		}
	}()
	// Sends a ping to confirm a successful connection
	var result bson.M
	if err := client.Database("admin").RunCommand(context.TODO(), bson.D{{"ping", 1}}).Decode(&result); err != nil {
		panic(err)
	}
	fmt.Println("Pinged your deployment. You successfully connected to MongoDB!")

	return client
}

func migrateSQLToMongo(sqlDB *sql.DB, mongoClient *mongo.Client) {
	// Combine users with posts, comments, events, subscriptions and messages
	rows, err := sqlDB.Query(`
	SELECT * FROM users
	JOIN posts ON users.id = posts.user_id
	JOIN comments ON users.id = comments.user_id
	JOIN events ON users.id = events.organisor_id
	JOIN subscriptions ON users.id = subscriptions.user_id
	JOIN messages ON users.id = messages.sender_id
	LIMIT 1;
	`)
	if err != nil {
		log.Fatalf("Failed to query SQL database: %v", err)
	}
	defer rows.Close()
	
	// Prepare MongoDB collection
	collection := mongoClient.Database("goddit").Collection("users")
	for rows.Next() {
		var user models.User
		if err := rows.Scan(&user.ID, &user.Username, &user.Email, &user.Password); err != nil {
			log.Fatalf("Failed to scan row: %v", err)
		}

		// Insert user into MongoDB
		_, err := collection.InsertOne(context.TODO(), user)
		if err != nil {
			log.Fatalf("Failed to insert user into MongoDB: %v", err)
		}
	}
	if err := rows.Err(); err != nil {
		log.Fatalf("Row iteration error: %v", err)
	}

}