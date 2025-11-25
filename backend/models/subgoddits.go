package models

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	"time"
)

type Subgoddit struct {
	ID          int64     `json:"id" db:"id"`
	Title       string    `json:"title" db:"title"`
	Description string    `json:"description" db:"description"`
	Subscribers int       `json:"subscribers" db:"subscribers"`
	Created     time.Time `json:"created" db:"created"`
}

type Subscriptions struct {
	SubID           int64     `json:"sub_id" db:"sub_id"`
	UserID          int64     `json:"user_id" db:"user_id"`
	SubscribedSince time.Time `json:"subscribed_since" db:"subscribed_since"`
}

type MongoSubscription struct {
	Subgoddit       Subgoddit          `json:"sub_id" bson:"sub_id"`
	SubscribedSince primitive.DateTime `json:"subscribed_since" bson:"subscribed_since"`
}
