package taskInfo

import (
	// database "Example/Database"
	// user "Example/Model/user"
	// redis "Example/Redis"
	// keys "Example/Redis/keys"
	task "Example/Model/task"
	utils "Example/Utils"
	res "Example/Utils/response"
	"fmt"

	// "encoding/json"
	// "fmt"
	// "strconv"

	"github.com/gin-gonic/gin"
)

// func GetCurrentUser(context *gin.Context) {
// 	var u interface{}
// 	reqIP := context.ClientIP()
// 	if reqIP == "::1" {
// 		reqIP = "127.0.0.1"
// 	}
// 	ustring, err := redis.GetKey(keys.REACT_APP_REDIS_USERINFO_ID_ + reqIP)
// 	if err != nil {
// 		fmt.Println(err)
// 		res.Return(context, utils.SYS_BUSY, u)
// 	} else {
// 		err = json.Unmarshal([]byte(ustring), &u)
// 		res.Return(context, utils.SUCCESS, u)
// 	}

// 	// context.JSON(http.StatusOK, result)
// }

// func MyLogout(context *gin.Context) {
// 	reqIP := context.ClientIP()
// 	if reqIP == "::1" {
// 		reqIP = "127.0.0.1"
// 	}
// 	ustring, err := redis.DelKey(keys.REACT_APP_REDIS_USERINFO_ID_ + reqIP)
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	res.Return(context, utils.SUCCESS, ustring)
// 	// context.JSON(http.StatusOK, result)
// }

// func GetAllUsers(context *gin.Context) {
// 	p := user.UserInfo{}
// 	users, err := p.GetAll(database.MysqlDB)
// 	if err != nil {
// 		fmt.Println(err)
// 		res.Return(context, utils.ERROR, users)
// 	} else {
// 		res.Return(context, utils.SUCCESS, users)
// 	}
// 	// context.JSON(http.StatusOK, gin.H{
// 	// 	"result": persons,
// 	// 	"count":  len(persons),
// 	// })
// }

func GetAllTasks(context *gin.Context) {
	t := task.TaskInfo{}
	fmt.Println("===")
	tasks := t.GetAll()
	// for i := 0; i < len(tasks); i++ {
	// 	 tasksNew[i] := new(task.TaskInfo)
	// 	//  getProjectNameByID(tasks[i].Project)
	// }

	if tasks != nil {
		res.Return(context, utils.SUCCESS, tasks)
	} else {
		res.Return(context, utils.ERROR, tasks)
	}
}

// func GetTasksByCreatedBy(context *gin.Context) {
// 	t := task.TaskInfo{}
// 	tasks := t.GetTasksByCreatedBy()
// 	if tasks != nil {
// 		res.Return(context, utils.SUCCESS, tasks)
// 	} else {
// 		res.Return(context, utils.ERROR, tasks)
// 	}

// }

func GetTaskByID(context *gin.Context) {
	id := context.Query("id")
	t := task.TaskInfo{}
	task := t.GetTaskByID(id)
	if task != nil {
		res.Return(context, utils.SUCCESS, task)
	} else {
		res.Return(context, utils.ERROR, task)
	}

}

func GetTaskByProjectID(context *gin.Context) {
	id := context.Query("id")
	t := task.TaskInfo{}
	task := t.GetTaskByProjectID(id)
	if task != nil {
		res.Return(context, utils.SUCCESS, task)
	} else {
		res.Return(context, utils.ERROR, task)
	}
}

func GetTasksByCreatedBy(context *gin.Context) {
	createdBy := context.Query("createdBy")
	t := task.TaskInfo{}
	task := t.GetTasksByCreatedBy(createdBy)
	if task != nil {
		res.Return(context, utils.SUCCESS, task)
	} else {
		res.Return(context, utils.ERROR, task)
	}
}

func GetTasksByAppoint(context *gin.Context) {
	appoint := context.Query("appoint")
	t := task.TaskInfo{}
	task := t.GetTasksByAppoint(appoint)
	if task != nil {
		res.Return(context, utils.SUCCESS, task)
	} else {
		res.Return(context, utils.ERROR, task)
	}
}

func UpdateContent(context *gin.Context) {
	t := task.TaskUpdateInfo{}
	err := context.Bind(&t)
	if err != nil {
		fmt.Println("Controller:UpdateContent", err)
	}
	t.UpdateContent(t)
	res.Return(context, utils.SUCCESS, "")
}

// func GetUserInfoById(context *gin.Context) {
// 	// var result gin.H
// 	id := context.Query("id")

// 	Id, err := strconv.Atoi(id)
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	p := user.UserInfo{
// 		Id: &Id,
// 	}
// 	user, err := p.GetUserInfoById(database.MysqlDB)
// 	if err != nil {
// 		res.Return(context, utils.ERROR, user)
// 	} else {
// 		userjson, _ := json.Marshal(user)
// 		reqIP := context.ClientIP()
// 		if reqIP == "::1" {
// 			reqIP = "127.0.0.1"
// 		}
// 		redis.SetKey(keys.REACT_APP_REDIS_USERINFO_ID_+reqIP, string(userjson))
// 		res.Return(context, utils.SUCCESS, user)
// 		// context.JSON(http.StatusOK, result)
// 	}

// }

// func MyLogin(context *gin.Context) {
// 	var (
// 		l user.Login
// 	)
// 	err := context.Bind(&l)
// 	if err != nil {
// 		fmt.Println(err)
// 	}

// 	id, err := l.Login(database.MysqlDB)
// 	if err != nil {
// 		fmt.Println(err)
// 		res.Return(context, utils.LOGIN_FAIL, id)
// 	} else {
// 		res.Return(context, utils.SUCCESS, id)
// 	}

// }

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
