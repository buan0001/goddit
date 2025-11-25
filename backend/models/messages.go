package models

import (
	"go.mongodb.org/mongo-driver/bson/primitive"
	"time"
)

type MessageChain struct {
	ID int64 `json:"id" db:"id"`
}

type BaseMessage struct {
	Body   string    `json:"body"`
	SentAt time.Time `json:"sent_at"`
}

type MessageChainParticipants struct {
	ChainID int64 `json:"chain_id" db:"chain_id"`
	UserID  int64 `json:"user_id" db:"user_id"`
}

type Message struct {
	BaseMessage
	ID       int64         `json:"id" db:"id"`
	ChainID  int64         `json:"chain_id" db:"chain_id"`
	Sender   *SQLUser      `json:"sender,omitempty"`
	SenderID int64         `json:"sender_id" db:"sender_id"`
}

// MongoDB representations

type MessageUser struct {
	ID       primitive.ObjectID `json:"id" bson:"_id"`
	Username string             `json:"username" bson:"username"`
}

type MongoMessage struct {
	BaseMessage
	ID     primitive.ObjectID `json:"id" bson:"_id"`
	Sender MessageUser        `json:"sender" bson:"sender"`
}

type MongoMessageChain struct {
	ID           primitive.ObjectID   `json:"id" bson:"_id"`
	Participants []primitive.ObjectID `json:"participants" bson:"participants"`
	Messages     []MongoMessage       `json:"messages" bson:"messages"`
}
