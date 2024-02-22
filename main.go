package main

import (
	"encoding/xml"

	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()
	router.GET("/:name", IndexHandler)
	router.Run()
}

func IndexHandler(c *gin.Context) {
	name := c.Params.ByName("name")

	c.JSON(200, gin.H{
		"message": "Hello " + name,
	})
}

type Person struct {
	XMLName   xml.Name `xml:"person"`
	FirstName string   `xml:"first_name"`
	LastName  string   `xml:"last_name"`
}
