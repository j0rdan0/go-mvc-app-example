package main

import (
	"net/rpc"
)

type RPCUserClient struct {
	Client *rpc.Client
}

func RPCClient() (*rpc.Client, error) {

	return rpc.DialHTTP("tcp", "localhost:8080")
}

func ToDTO(user *User) UserDTO {
	return UserDTO{Username: user.Username, Password: user.Password, Uid: user.Uid}
}

func (r *RPCUserClient) GetUser(uid int) (UserDTO, error) {
	var (
		user    User
		userDTO UserDTO
	)
	if err := r.Client.Call("UserHandler.Get", uid, &user); err != nil {
		return userDTO, err
	}
	userDTO = ToDTO(&user)
	return userDTO, nil

}

func (r *RPCUserClient) DeleteUser(uid int) (int, error) {
	var rows int
	err := r.Client.Call("UserHandler.Delete", uid, &rows)

	return rows, err
}

func (r *RPCUserClient) PatchUser(password string, uid int) error {
	var user User
	if err := r.Client.Call("UserHandler.Get", uid, &user); err != nil {
		return err
	}
	user.Password = password

	return r.Client.Call("UserHandler.Update", &user, nil)
}

func (r *RPCUserClient) PostUser(user User) (int, error) {
	var rows int
	err := r.Client.Call("UserHandler.Post", &user, &rows)
	return rows, err
}

func (r *RPCUserClient) GetAllUsers() ([]UserDTO, error) {
	var users []User

	if err := r.Client.Call("UserHandler.GetAll", 0, &users); err != nil {
		return nil, err
	}

	var usersDTO []UserDTO

	for _, user := range users {
		usersDTO = append(usersDTO, ToDTO(&user))
	}

	return usersDTO, nil
}
