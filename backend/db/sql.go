package db

import (
	"fmt"
	"log"
	"os"
    "database/sql"
    "goddit/backend/models"
)

type SQLDatabase struct {
    Conn *sql.DB
}

func NewSQLDatabase() *Database {
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


func (db *SQLDatabase) GetAllUsers() ([]models.User, error) {
    rows, err := db.Conn.Query("SELECT id, username, email FROM Users")
    if err != nil {
        return nil, err
    }
    defer rows.Close()

    var users []models.User
    for rows.Next() {
        var user models.User
        if err := rows.Scan(&user.ID, &user.Username, &user.Email); err != nil {
            return nil, err
        }
        users = append(users, user)
    }

    return users, nil
}

func (db *SQLDatabase) GetUserByID(id int) (*models.User, error) {
    row := db.Conn.QueryRow("SELECT id, username, email FROM Users WHERE id = ?", id)
    var user models.User
    if err := row.Scan(&user.ID, &user.Username, &user.Email); err != nil {
        return nil, err
    }
    return &user, nil
}

func (db *SQLDatabase) CreateUser(user *models.User) error {
    _, err := db.Conn.Exec("INSERT INTO Users (username, email) VALUES (?, ?)", user.Username, user.Email)
    return err
}