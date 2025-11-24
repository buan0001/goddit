package main

import (
    
	"log"
	"database/sql"
	
	_ "github.com/go-sql-driver/mysql"
	"goddit/backend/db"
	"goddit/backend/api"
	"github.com/joho/godotenv"

)


func main() {
	err := godotenv.Load(".env")

    if err != nil {
        log.Fatal("Error loading .env file")
    }
	
	// TODO: Make the active DB change depending on incoming query param
	database := db.InitDb("sql")
	// Maybe close connection again? Would have to be method on interface
	
	
	api.InitializeAPI(database)
}

type Database struct {
	Conn *sql.DB
}




