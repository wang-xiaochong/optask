package controller

import (
	database "Example/Database"
	model "Example/Model"
	"bytes"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func Persons(context *gin.Context) {
	p := model.Person{}
	persons, err := p.GetAll(database.MysqlDB)
	if err != nil {
		log.Fatalln(err)
	}
	context.JSON(http.StatusOK, gin.H{
		"result": persons,
		"count":  len(persons),
	})
}

func GetPersonByID(context *gin.Context) {
	var result gin.H
	id := context.Query("id")

	Id, err := strconv.Atoi(id)
	if err != nil {
		log.Fatalln(err)
	}
	p := model.Person{
		Id: Id,
	}
	person, err := p.Get(database.MysqlDB)
	if err != nil {
		result = gin.H{
			"result": nil,
			"count":  0,
		}
	} else {
		result = gin.H{
			"result": person,
			"count":  1,
		}
	}
	context.JSON(http.StatusOK, result)
}

func AddPerson(context *gin.Context) {
	var p model.Person
	err := context.Bind(&p)
	if err != nil {
		log.Fatalln(err)
	}

	Id, err := p.Add(database.MysqlDB)
	if err != nil {
		log.Fatalln(err)
	}
	fmt.Println(Id)
	name := p.FirstName + " " + p.LastName
	context.JSON(http.StatusOK, gin.H{
		"message": fmt.Sprintf(" %s 成功创建", name),
	})

}

func UpdatePerson(context *gin.Context) {
	var (
		p      model.Person
		buffer bytes.Buffer
	)

	id := context.Query("id")
	Id, err := strconv.Atoi(id)
	if err != nil {
		log.Fatalln(err)
	}
	err = context.Bind(&p)
	if err != nil {
		log.Fatalln(err)
	}
	p.Id = Id
	rows, err := p.Update(database.MysqlDB)
	if err != nil {
		log.Fatalln(err)
	}
	fmt.Println(rows)
	buffer.WriteString(p.FirstName)
	buffer.WriteString(" ")
	buffer.WriteString(p.LastName)
	name := buffer.String()

	context.JSON(http.StatusOK, gin.H{
		"message": fmt.Sprintf("成功更新到%s", name),
	})
}

func DeletePerson(context *gin.Context) {
	id := context.Query("id")

	Id, err := strconv.ParseInt(id, 10, 10)
	if err != nil {
		log.Fatalln(err)
	}
	p := model.Person{Id: int(Id)}
	rows, err := p.Del(database.MysqlDB)
	if err != nil {
		log.Fatalln(err)
	}
	fmt.Println("delete rows: ", rows)

	context.JSON(http.StatusOK, gin.H{
		"message": fmt.Sprintf("成功删除用户：%s", id),
	})
}
