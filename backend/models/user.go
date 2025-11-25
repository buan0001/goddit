package models

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type UserRoles struct {
	User  string
	Admin string
}

type User struct {
	ID        any       `json:"id" bson:"id"`
	Username  string    `json:"username" bson:"username"`
	Email     string    `json:"email" bson:"email"`
	Password  string    `json:"password" bson:"password"`
	Role      UserRoles `json:"role" bson:"role"`
	Disabled  bool      `json:"disabled" bson:"disabled"`
	CreatedAt string    `json:"created_at" bson:"created_at"`
	Karma     int       `json:"karma" bson:"karma"`
}

type SQLUser struct {
	User
	ID int `json:"id"`
}

type Purchases struct {
	AmountPaid   float64 `json:"amount_paid" db:"amount_paid"`
	GoldRecieved int     `json:"gold_recieved" db:"gold_recieved"`
	UserID       int64   `json:"user_id" db:"user_id"`
}

type MongoUser struct {
	User
	ID            primitive.ObjectID       `json:"id" bson:"_id"`
	Subscriptions []map[string]interface{} `json:"subscriptions" bson:"subscriptions"`
}
