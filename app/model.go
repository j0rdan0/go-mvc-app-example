package main

import (
	"time"

	"gorm.io/gorm"
)

type User struct {
	Uid       int            `gorm:"primaryKey;column:Uid;autoIncrement" json:"Uid" `
	CreatedAt time.Time      `gorm:"column:CreatedAt;autoCreateTime" json:"CreatedAt"`
	UpdatedAt time.Time      `gorm:"column:UpdatedAt;autoUpdateTime" json:"UpdatedAt"`
	DeletedAt gorm.DeletedAt `gorm:"column:DeletedAt;index" json:"DeletedAt"`
	Username  string         `gorm:"column:Username" json:"Username" binding:"required"`
	Password  string         `gorm:"column:Password" json:"Password" binding:"required"`
	Roles     string         `gorm:"column:Roles" json:"Roles"`
}
type UserDTO struct {
	Uid      int    `json:"Uid"`
	Username string `json:"Username"`
	Roles    string `json:"Roles"`
	Password string `json:"Password"`
}

type UserClient interface {
	GetUser(int) (UserDTO, error)
	PatchUser(string, int) error
	DeleteUser(uid int) (int, error)
	PostUser(User) (int, error)
	GetAllUsers() ([]UserDTO, error)
}
