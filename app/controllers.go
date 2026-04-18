package main

import (
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func Get(service UserClient) gin.HandlerFunc {
	return func(c *gin.Context) {
		uid, err := strconv.Atoi(c.Param("uid"))
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err})
		}
		var user UserDTO

		user, err = service.GetUser(uid)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err})
			return
		}

		c.JSON(http.StatusOK, gin.H{"user": user})
	}
}

func Patch(service UserClient) gin.HandlerFunc {
	return func(c *gin.Context) {
		password := c.Query("password")
		uid, err := strconv.Atoi(c.Query("uid"))
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err})
			return
		}
		if err = service.PatchUser(password, uid); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err})
			return
		}
		c.JSON(http.StatusAccepted, gin.H{"accepted": true})
	}
}

func Delete(service UserClient) gin.HandlerFunc {
	return func(c *gin.Context) {
		uid, err := strconv.Atoi(c.Param("uid"))
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err})
			return
		}
		if rows, err := service.DeleteUser(uid); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err})
			return
		} else {
			c.JSON(http.StatusAccepted, gin.H{"rows affected": rows})
		}

	}
}

func Post(service UserClient) gin.HandlerFunc {
	return func(c *gin.Context) {
		var user User
		if err := c.ShouldBindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		if rows, err := service.PostUser(user); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err})
			return
		} else {
			c.JSON(http.StatusAccepted, gin.H{"rows affected": rows})
		}
	}
}

// TODO: to refactor all functions below

func GetAll(service UserClient) gin.HandlerFunc {
	return func(c *gin.Context) {

		if users, err := service.GetAllUsers(); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err})
			return
		} else {
			c.JSON(http.StatusOK, gin.H{"users": users})
		}

	}
}
