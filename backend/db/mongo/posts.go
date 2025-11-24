package mongo

import (
	"goddit/backend/models"
)

// PostQueries methods
func (db *MongoDatabase) GetAllPosts() ([]models.Post, error) {
    // MongoDB query implementation
    return nil, nil
}

func (db *MongoDatabase) GetPostByID(id int) (*models.Post, error) {
    // MongoDB query implementation
    return nil, nil
}

func (db *MongoDatabase) CreatePost(post *models.Post) error {
    // MongoDB query implementation
    return nil
}