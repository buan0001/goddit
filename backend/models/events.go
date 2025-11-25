package models

import (
	"time"
	// "go.mongodb.org/mongo-driver/bson/primitive"
)


type Events struct {
	ID           int64     `json:"id" db:"id"`
	Title        string    `json:"title" db:"title"`
	Body         string    `json:"body" db:"body"`
	Start        time.Time `json:"start" db:"start"`
	End          time.Time `json:"end" db:"end"`
	Organisor_id int64     `json:"organisor_id" db:"organisor_id"`
	SubID        int64     `json:"sub_id" db:"sub_id"`
}

type EventParticipations struct {
	EventID int64 `json:"event_id" db:"event_id"`
	UserID  int64 `json:"user_id" db:"user_id"`
}