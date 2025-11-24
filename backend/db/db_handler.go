package db

import (
	"fmt"
	"log"
	"os"
	
	"goddit/backend/models"
	"goddit/backend/db/mongo"
	"goddit/backend/db/mysql"
)

// Database is a composite interface that includes user and post queries
type Database interface {
    UserQueries
    PostQueries
}

type UserQueries interface {
    GetAllUsers() ([]models.User, error)
    GetUserByID(id int) (*models.User, error)
    CreateUser(user *models.User) error
}

// PostQueries defines methods for post-related database operations
type PostQueries interface {
    GetAllPosts() ([]models.Post, error)
    GetPostByID(id int) (*models.Post, error)
    CreatePost(post *models.Post) error
}


func InitDb(dbType string) *Database {
	if dbType == "sql" {
		fmt.Println("Initializing SQL Database")
		return mysql.NewSQLDatabase()
	} else if dbType == "mongodb" {
		fmt.Println("Initializing NoSQL Database")
		return mongo.NewMongoDatabase()
	} else if dbType == "neo4j" {
		fmt.Println("Initializing Graph Database")
		return neo4j.NewNeo4jDatabase()
	} else {
				log.Fatalf("Unsupported database type: %s", dbType)
		return nil
	}
}


// Add database operation methods here (GetAllUsers, GetUserByID, CreateUser)