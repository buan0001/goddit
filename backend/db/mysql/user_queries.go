package mysql

import (
	"goddit/backend/models"
)

func (db *SQLDatabase) GetAllUsers() ([]models.User, error) {
	rows, err := db.Conn.Query("SELECT id, username, email FROM users")
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
	row := db.Conn.QueryRow("SELECT id, username, email FROM users WHERE id = ?", id)
	var user models.User
	if err := row.Scan(&user.ID, &user.Username, &user.Email); err != nil {
		return nil, err
	}
	return &user, nil
}

func (db *SQLDatabase) CreateUser(user *models.User) (int, error) {
	result, err := db.Conn.Exec("INSERT INTO users (username, email, password) VALUES (?, ?, ?)", user.Username, user.Email, user.Password)
	if err != nil {
		return 0, err
	}
	id, err := result.LastInsertId()
	if err != nil {
		return 0, err
	}
	return int(id), nil
}

func (db *SQLDatabase) GetUserByUsername(username string) (*models.User, error) {
	row := db.Conn.QueryRow("SELECT id, username, email, password FROM users WHERE username = ?", username)
	var user models.User
	if err := row.Scan(&user.ID, &user.Username, &user.Email, &user.Password); err != nil {
		return nil, err
	}
	return &user, nil
}
