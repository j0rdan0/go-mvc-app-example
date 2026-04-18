package main

import (
	"errors"
	"fmt"
	"os"

	_ "github.com/joho/godotenv/autoload"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

func InitDb() (*gorm.DB, error) {
	dsn := fmt.Sprintf("root:%s@tcp(127.0.0.1:3306)/mockOS?parseTime=true", os.Getenv("SQL_PASS"))
	if db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{PrepareStmt: true}); err != nil {
		return nil, err
	} else {
		return db, nil
	}
}

func (u *UserHandler) GetAll(_ int, users *[]User) error {
	return u.DB.Find(users).Error

}

func (u *UserHandler) Get(uid int, user *User) error {
	return u.DB.First(user, uid).Error
}

func (u *UserHandler) Post(user *User, rows *int) error {
	var count int64
	if res := u.DB.Model(&User{}).Where("username = ?", user.Username).Count(&count); res.Error != nil {
		*rows = 0
		return res.Error
	} else {
		if count > 0 {
			// user already exists
			*rows = 0
			return errors.New("user already exists")
		}
	}

	res := u.DB.Create(user)
	*rows = int(res.RowsAffected)
	return res.Error
}

func (u *UserHandler) Update(user *User, _ *User) error {
	if user != nil {
		return u.DB.Model(user).Updates(user).Error
	}
	return errors.New("received nil user")

}

func (u *UserHandler) Delete(uid int, rows *int) error {
	res := u.DB.Delete(&User{}, uid)
	*rows = int(res.RowsAffected)
	return res.Error
}
