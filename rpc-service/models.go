package main

import (
	"time"

	"gorm.io/gorm"
)

type User struct {
	Uid       int            `gorm:"primaryKey;column:Uid;autoIncrement"`
	CreatedAt time.Time      `gorm:"column:CreatedAt;autoCreateTime";"<-:create"`
	UpdatedAt time.Time      `gorm:"column:UpdatedAt;autoUpdateTime"`
	DeletedAt gorm.DeletedAt `gorm:"column:DeletedAt;index"`
	Username  string         `gorm:"column:Username"`
	Password  string         `gorm:"column:Password"`
	Roles     string         `gorm:"column:Roles"`
}

func (User) TableName() string {
	return "User" // Match the exact name in MySQL
}

type UserHandler struct {
	DB *gorm.DB
}
