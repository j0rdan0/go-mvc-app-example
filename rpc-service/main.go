package main

import (
	"fmt"
	"log"
	"net"
	"net/http"
	"net/rpc"
)

func main() {

	db, err := InitDb()
	if err != nil {
		log.Fatalf("initialization failed, err: %s\n", err)

	}

	// setup RPC
	user := &UserHandler{db}
	if err := rpc.Register(user); err != nil {
		log.Fatalf("failed registering object, err: %s\n", err)
	}
	rpc.HandleHTTP()

	loggingMiddleware := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("Received RPC request from: %s | Path: %s", r.RemoteAddr, r.URL.Path)
		// Pass the request to the default ServeMux (where RPC is registered)
		http.DefaultServeMux.ServeHTTP(w, r)
	})

	listner, err := net.Listen("tcp", ":8080")
	if err != nil {
		log.Fatalf("listen error: %s\n", err)

	}
	fmt.Println("started listener on port :8080 ")
	if err = http.Serve(listner, loggingMiddleware); err != nil {
		log.Fatalln(err)
	}

}
