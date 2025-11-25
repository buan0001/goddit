package models

import "time"

type Post struct {
	ID        int64      `json:"id" db:"id"`
	Title     string     `json:"title" db:"title"`
	Body      string     `json:"body" db:"body"`
	Upvotes   int        `json:"upvotes" db:"upvotes"`
	Downvotes int        `json:"downvotes" db:"downvotes"`
	Created   time.Time  `json:"created" db:"created"`
	Updated   time.Time  `json:"updated" db:"updated"`
	UserID    int64      `json:"user_id" db:"user_id"`
	User      *SQLUser      `json:"user,omitempty" db:"-"`
	SubID     int64      `json:"sub_id" db:"sub_id"`
	Sub       *Subgoddit `json:"subgoddit,omitempty" db:"-"`
}
