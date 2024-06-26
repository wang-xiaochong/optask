package userInfo

import (
	database "Example/Database"
	"Example/Model/role"
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
		res.Return(context, utils.SYS_BUSY, u)
	} else {
		err = json.Unmarshal([]byte(ustring), &u)
		res.Return(context, utils.SUCCESS, u)
	}

	// context.JSON(http.StatusOK, result)
}

func MyLogout(context *gin.Context) {
	reqIP := context.ClientIP()
	if reqIP == "::1" {
		reqIP = "127.0.0.1"
	}
	ustring, err := redis.DelKey(keys.REACT_APP_REDIS_USERINFO_ID_ + reqIP)
	if err != nil {
		fmt.Println(err)
	}
	res.Return(context, utils.SUCCESS, ustring)
	// context.JSON(http.StatusOK, result)
}

func GetAllUsers(context *gin.Context) {
	p := user.UserInfo{}
	users, err := p.GetAll(database.MysqlDB)
	if err != nil {
		fmt.Println(err)
		res.Return(context, utils.NONE_FOUND, users)
	} else {
		res.Return(context, utils.SUCCESS, users)
	}
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
	if err != nil {
		res.Return(context, utils.NONE_FOUND, user)
	} else {
		userjson, _ := json.Marshal(user)
		reqIP := context.ClientIP()
		if reqIP == "::1" {
			reqIP = "127.0.0.1"
		}
		redis.SetKey(keys.REACT_APP_REDIS_USERINFO_ID_+reqIP, string(userjson))
		res.Return(context, utils.SUCCESS, user)
		// context.JSON(http.StatusOK, result)
	}

}

func CheckAccount(context *gin.Context) {
	// var result gin.H
	account := context.Query("account")
	p := user.UserInfo{
		Account: &account,
	}
	isHasAccount, _ := p.CheckAccount(database.MysqlDB)
	if isHasAccount != false {
		res.Return(context, utils.HAS_EXIST, isHasAccount)
	} else {
		res.Return(context, utils.SUCCESS, isHasAccount)
	}
}

func GetRoleInfoByUserRoleInfo(context *gin.Context) {
	// var result gin.H
	name := context.Query("name")
	r := role.RoleInfo{}
	roleInfo, err := r.GetRoleInfoByID(name)
	if err != nil {
		res.Return(context, utils.NONE_FOUND, roleInfo)
	} else {
		res.Return(context, utils.SUCCESS, roleInfo)
	}
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
		res.Return(context, utils.LOGIN_FAIL, id)
	} else {
		res.Return(context, utils.SUCCESS, id)
	}

}

func ResetPassword(context *gin.Context) {
	var (
		l user.ResetPassword
	)
	err := context.Bind(&l)
	if err != nil {
		fmt.Println(err)
	}

	rows, err := l.ResetPassword(database.MysqlDB)
	if err != nil {
		fmt.Println(err)
		if rows == 0 {
			res.Return(context, utils.PhoneError, rows)
		} else {
			res.Return(context, utils.SUCCESS, rows)
		}
	} else {
		res.Return(context, utils.SUCCESS, rows)
	}

}

func UpdateUserInfoByID(context *gin.Context) {
	u := user.UserUpdateInfo{}
	err := context.Bind(&u)
	if err != nil {
		fmt.Println(err)
	}
	u.UpdateUserInfoByID(u, context)
	res.Return(context, utils.SUCCESS, "")
}

func UpdateUserRoleAndJob(context *gin.Context) {
	u := user.UpdateUserRoleAndJob{}
	err := context.Bind(&u)
	if err != nil {
		fmt.Println(err)
	}
	u.UpdateUserRoleAndJob(u, context)
	res.Return(context, utils.SUCCESS, "")
}

func AddUserInfo(context *gin.Context) {
	u := user.UserAddInfo{}
	err := context.Bind(&u)
	if err != nil {
		fmt.Println(err)
	}
	u.AddUserInfo(u, context)
	res.Return(context, utils.SUCCESS, "")
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
