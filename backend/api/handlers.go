package api

import (
	"net/http"
	"fmt"
	"goddit/backend/db"
	"goddit/backend/service"
	

	"github.com/gin-gonic/gin"
)

var services = make(map[string]*service.UserService)

func InitializeAPI(db db.Database) {
	initServices(db)

	router := gin.Default()
	api := router.Group("/api")
	
	api.GET("/test", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "API is working. Yay!"})
	})
	api.POST("/login", LoginHandler(db))
	api.POST("/signup", SignupHandler(db))

    router.Run("0.0.0.0:8080")
}

func initServices(db db.Database) {
	services["userService"] = service.NewUserService(db)
}

func LoginHandler(db db.Database) gin.HandlerFunc {
	return func(c *gin.Context) {
		var req struct {
			Username string `json:"username"`
			Password string `json:"password"`
		}
		if err := c.ShouldBindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
			return
		}

		user, err := services["userService"].AuthenticateUser(req.Username, req.Password)

		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Authentication failed"})
			return
		}

		c.JSON(http.StatusOK, gin.H{"message": "Login successful", "user_id": user.ID})
	}
}

func SignupHandler(db db.Database) gin.HandlerFunc {
	return func(c *gin.Context) {
		var req struct {
            Username string `json:"username"`
            Email    string `json:"email"`
            Password string `json:"password"`
        }

		if err := c.ShouldBindJSON(&req); err != nil {
            c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
            return
        }


        userID, err := services["userService"].CreateUser(req.Username, req.Email, req.Password)
        if err != nil {
			fmt.Println("Error creating user:", err)
            c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create user"})
            return
        }

        c.JSON(http.StatusOK, gin.H{"message": "User created successfully", "user_id": userID})
	}
}