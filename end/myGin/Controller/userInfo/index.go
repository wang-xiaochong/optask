package userInfo

import (
	database "Example/Database"
	user "Example/Model/user"
	redis "Example/Redis"
	keys "Example/Redis/keys"
	utils "Example/Utils"
	res "Example/Utils/response"
	"encoding/json"
	"fmt"
	"strconv"

	"github.com/gin-gonic/gin"
)

func GetCurrentUser(context *gin.Context) {
	var u interface{}
	reqIP := context.ClientIP()
	if reqIP == "::1" {
		reqIP = "127.0.0.1"
	}
	ustring, err := redis.GetKey(keys.REACT_APP_REDIS_USERINFO_ID_ + reqIP)
	if err != nil {
		fmt.Println(err)
	}
	err = json.Unmarshal([]byte(ustring), &u)
	res.Return(context, utils.SUCCESS, u)
	// context.JSON(http.StatusOK, result)
}

func GetAllUsers(context *gin.Context) {
	p := user.UserInfo{}
	users, err := p.GetAll(database.MysqlDB)
	if err != nil {
		fmt.Println(err)
	}
	res.Return(context, utils.SUCCESS, users)

	// context.JSON(http.StatusOK, gin.H{
	// 	"result": persons,
	// 	"count":  len(persons),
	// })
}

func GetUserInfoById(context *gin.Context) {
	// var result gin.H
	id := context.Query("id")

	Id, err := strconv.Atoi(id)
	if err != nil {
		fmt.Println(err)
	}
	p := user.UserInfo{
		Id: &Id,
	}
	user, err := p.GetUserInfoById(database.MysqlDB)
	userjson, _ := json.Marshal(user)
	reqIP := context.ClientIP()
	if reqIP == "::1" {
		reqIP = "127.0.0.1"
	}
	redis.SetKey(keys.REACT_APP_REDIS_USERINFO_ID_+reqIP, string(userjson))
	res.Return(context, utils.SUCCESS, user)
	// context.JSON(http.StatusOK, result)
}

func MyLogin(context *gin.Context) {
	var (
		l user.Login
	)
	err := context.Bind(&l)
	if err != nil {
		fmt.Println(err)
	}

	id, err := l.Login(database.MysqlDB)
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println(id)
	res.Return(context, utils.SUCCESS, id)
}

// func AddPerson(context *gin.Context) {
// 	var p model.Person
// 	err := context.Bind(&p)
// 	if err != nil {
// 		fmt.Println(err)
// 	}

// 	Id, err := p.Add(database.MysqlDB)
// 	if err != nil {
// 		fmt.Println(err)
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
// 		fmt.Println(err)
// 	}
// 	err = context.Bind(&p)
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	p.Id = Id
// 	rows, err := p.Update(database.MysqlDB)
// 	if err != nil {
// 		fmt.Println(err)
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
// 		fmt.Println(err)
// 	}
// 	p := model.Person{Id: int(Id)}
// 	rows, err := p.Del(database.MysqlDB)
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	fmt.Println("delete rows: ", rows)

// 	context.JSON(http.StatusOK, gin.H{
// 		"message": fmt.Sprintf("成功删除用户：%s", id),
// 	})
// }
