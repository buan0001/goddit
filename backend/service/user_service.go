package service

import (
    "goddit/backend/db"
    "goddit/backend/models"
)

type UserService struct {
    repo db.Database
}

func NewUserService(repo db.Database) *UserService {
    return &UserService{repo: repo}
}

func (s *UserService) GetAllUsers() ([]models.User, error) {
    return s.repo.GetAllUsers()
}

func (s *UserService) GetUserByID(id int) (*models.User, error) {
    return s.repo.GetUserByID(id)
}

func (s *UserService) CreateUser(user *models.User) error {
    return s.repo.CreateUser(user)
}