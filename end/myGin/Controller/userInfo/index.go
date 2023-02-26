package userInfo

import (
	database "Example/Database"
	user "Example/Model/user"
	utils "Example/Utils"
	res "Example/Utils/response"
	"log"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func GetAllUsers(context *gin.Context) {
	p := user.UserInfo{}
	users, err := p.GetAll(database.MysqlDB)
	if err != nil {
		log.Fatalln(err)
	}
	res.Return(context, utils.SUCCESS, users)

	// context.JSON(http.StatusOK, gin.H{
	// 	"result": persons,
	// 	"count":  len(persons),
	// })
}

func GetUserInfoById(context *gin.Context) {
	var result gin.H
	id := context.Query("id")

	Id, err := strconv.Atoi(id)
	if err != nil {
		log.Fatalln(err)
	}
	p := user.UserInfo{
		Id: Id,
	}
	user, err := p.Get(database.MysqlDB)
	res.Return(context, utils.SUCCESS, user)
	context.JSON(http.StatusOK, result)
}

// func AddPerson(context *gin.Context) {
// 	var p model.Person
// 	err := context.Bind(&p)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}

// 	Id, err := p.Add(database.MysqlDB)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	fmt.Println(Id)
// 	name := p.FirstName + " " + p.LastName
// 	context.JSON(http.StatusOK, gin.H{
// 		"message": fmt.Sprintf(" %s 成功创建", name),
// 	})

// }

// func UpdatePerson(context *gin.Context) {
// 	var (
// 		p      model.Person
// 		buffer bytes.Buffer
// 	)

// 	id := context.Query("id")
// 	Id, err := strconv.Atoi(id)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	err = context.Bind(&p)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	p.Id = Id
// 	rows, err := p.Update(database.MysqlDB)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	fmt.Println(rows)
// 	buffer.WriteString(p.FirstName)
// 	buffer.WriteString(" ")
// 	buffer.WriteString(p.LastName)
// 	name := buffer.String()

// 	context.JSON(http.StatusOK, gin.H{
// 		"message": fmt.Sprintf("成功更新到%s", name),
// 	})
// }

// func DeletePerson(context *gin.Context) {
// 	id := context.Query("id")

// 	Id, err := strconv.ParseInt(id, 10, 10)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	p := model.Person{Id: int(Id)}
// 	rows, err := p.Del(database.MysqlDB)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	fmt.Println("delete rows: ", rows)

// 	context.JSON(http.StatusOK, gin.H{
// 		"message": fmt.Sprintf("成功删除用户：%s", id),
// 	})
// }
