package mysql

import (
	"goddit/backend/models"
)

// PostQueries methods
func (db *SQLDatabase) GetAllPosts() ([]models.Post, error) {
    // SQL query implementation
    return nil, nil
}

func (db *SQLDatabase) GetPostByID(id int) (*models.Post, error) {
    // SQL query implementation
    return nil, nil
}

func (db *SQLDatabase) CreatePost(post *models.Post) error {
    // SQL query implementation
    return nil
}