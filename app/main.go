package main

import (
	"log"

	"github.com/gin-gonic/gin"

	_ "github.com/go-sql-driver/mysql"

	_ "github.com/joho/godotenv/autoload"
)

func main() {
	router := gin.Default()

	// for CORS shit, to allow PATCH
	router.Use(func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		// Ensure PATCH and DELETE are explicitly allowed
		c.Writer.Header().Set("Access-Control-Allow-Methods", "GET, POST, PATCH, DELETE, OPTIONS")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization")

		// Handle the OPTIONS preflight request
		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(204) // Return 204 No Content to tell browser it's okay
			return
		}

		c.Next()
	})

	client, err := RPCClient()
	if err != nil {
		log.Fatalf("failed creating RPC client, err: %s\n", err)
	}
	defer client.Close()

	userService := RPCUserClient{Client: client}

	router.Static("/cwd", "./")
	router.GET("/user/:uid", Get(&userService)) // will be fixed after implementing the rest of the controller methods
	router.GET("/user/all", GetAll(&userService))
	router.PATCH("/user", Patch(&userService))
	router.DELETE("/user/:uid", Delete(&userService))
	router.POST("/user", Post(&userService))
	router.Run(":3000")
}
