package mysql

import (
	"fmt"
	"log"
	"os"
    "database/sql"
    _ "github.com/go-sql-driver/mysql"
)

type SQLDatabase struct {
    Conn *sql.DB
}

func NewSQLDatabase() *SQLDatabase {
	dsn := os.Getenv("CONN_STR")

	conn, err := sql.Open("mysql", dsn)
	if err != nil {
		panic(err.Error())
	}

	if err := conn.Ping(); err != nil {
		log.Fatalf("Failed to ping the database: %v", err)
	}

	fmt.Println("Database connection established successfully!")

	return &SQLDatabase{Conn: conn}
}


