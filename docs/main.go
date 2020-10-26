package main

import (
	"log"
	"net/http"
)

var (
	docsAddr = ":8080"
)

func main()  {
	http.Handle("/docs/", http.StripPrefix("/docs/", http.FileServer(http.Dir("docs"))))
	log.Println("Cheat docs server startup...")
	http.ListenAndServe(docsAddr,nil)
}
