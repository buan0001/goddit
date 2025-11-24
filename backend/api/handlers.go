package api

import (
	"net/http"
	"strconv"
	
	"goddit/backend/models"
	"goddit/backend/db"

	"github.com/gin-gonic/gin"
	
)

func InitializeAPI(database db.Database) {
	router := gin.Default()
	api := router.Group("/api")
    router.Run("localhost:8080")
}