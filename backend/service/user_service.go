package service

import (
    "fmt"

    "goddit/backend/db"
    "goddit/backend/models"

    "golang.org/x/crypto/bcrypt"
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

func (s *UserService) CreateUser(username, email, password string) (interface{}, error) {
    hashedPassword, err := HashPassword(password)
    fmt.Println("Hashed password:", hashedPassword)
    if err != nil {
        return 0, err
    }
    user := &models.User{
        Username: username,
        Email:    email,
        Password: hashedPassword,
    }
    
    return s.repo.CreateUser(user)
}

func (s *UserService) AuthenticateUser(username, password string) (*models.User, error) {
    user, err := s.repo.GetUserByUsername(username)
    if err != nil {
        return nil, err
    }
    if !CheckPasswordHash(password, user.Password) {
        return nil, err
    }
    return user, nil
}


func HashPassword(password string) (string, error) {
    bytes, err := bcrypt.GenerateFromPassword([]byte(password), 8)
    return string(bytes), err
}

func CheckPasswordHash(password, hash string) bool {
    err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
    return err == nil
}