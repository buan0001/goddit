package db

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	
	"goddit/backend/models"
	_ "github.com/go-sql-driver/mysql"

)

type Database interface {
    GetAllUsers() ([]models.User, error)
    GetUserByID(id int) (*models.User, error)
    CreateUser(user *models.User) error
}


func InitDb(dbType string) *Database {
	if dbType == "sql" {
		fmt.Println("Initializing SQL Database")
		return NewSQLDatabase()
	} else if dbType == "mongodb" {
		fmt.Println("Initializing NoSQL Database")
		return NewMongoDatabase()
	} else {
		log.Fatalf("Unsupported database type: %s", dbType)
		return nil
	}
}


// Add database operation methods here (GetAllUsers, GetUserByID, CreateUser)