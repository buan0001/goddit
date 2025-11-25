package db

import (
	"fmt"
	"log"

	// "goddit/backend/db/mongo"
	"goddit/backend/db/mysql"
	// "goddit/backend/db/neo4j"
	"goddit/backend/models"
)

// Database is a composite interface that includes user and post queries
type Database interface {
	UserQueries
	PostQueries
}

type UserQueries interface {
	GetAllUsers() ([]models.User, error)
	GetUserByID(id int) (*models.User, error)
	CreateUser(user *models.User) (int, error)
	GetUserByUsername(username string) (*models.User, error)
}

// PostQueries defines methods for post-related database operations
type PostQueries interface {
	GetAllPosts() ([]models.Post, error)
	GetPostByID(id int) (*models.Post, error)
	CreatePost(post *models.Post) error
}

func InitDb(dbType string) Database {
	if dbType == "sql" {
		fmt.Println("Initializing SQL Database")
		return mysql.NewSQLDatabase()
	} else if dbType == "mongodb" {
		fmt.Println("Mongodb not yet implemented")
		// return mongo.NewMongoDatabase()
	} else if dbType == "neo4j" {
		fmt.Println("Graph DB not yet implemented")
		// return neo4j.NewNeo4jDatabase()
	}
	log.Fatalf("Unsupported database type: %s", dbType)
	return nil
}