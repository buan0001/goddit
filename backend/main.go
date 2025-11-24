package main

import (
    "net/http"
	"log"
	"database/sql"
	
	_ "github.com/go-sql-driver/mysql"
	"goddit/backend/db"
	"goddit/backend/service"

    "github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)


func main() {
	err := godotenv.Load(".env")

    if err != nil {
        log.Fatal("Error loading .env file")
    }

	database := db.InitDb()
    defer database.Conn.Close()

	router := gin.Default()


    router.Run("localhost:8080")
}

type Database struct {
	Conn *sql.DB
}




