package router

import (
	controller "Example/Controller"
	projectInfo "Example/Controller/projectInfo"
	taskInfo "Example/Controller/taskInfo"
	userInfo "Example/Controller/userInfo"
	utils "Example/Utils"

	"github.com/gin-gonic/gin"
)

// InitRouter 加入路由访问路径
func InitRouter(e *gin.Engine) {
	e.Use(utils.CORS(utils.Options{Origin: "*"}))
	pre := e.Group("/api")

	user := pre.Group("/user")
	{
		user.GET("/getCurrentUser", userInfo.GetCurrentUser)
		user.GET("/getAllUserInfo", userInfo.GetAllUsers)
		user.GET("/getUserInfoById", userInfo.GetUserInfoById)
		user.POST("/login", userInfo.MyLogin)
		user.POST("/logout", userInfo.MyLogout)
		// user.POST("/add", controller.AddPerson)
		// user.PUT("/update", controller.UpdatePerson)
		// user.DELETE("/delete", controller.DeletePerson)

	}
	task := pre.Group("/task")
	{
		task.GET("/getAllTaskInfo", taskInfo.GetAllTasks)
		task.GET("/getTasksByCreatedBy", taskInfo.GetTasksByCreatedBy)
		task.GET("/getTaskInfoByID", taskInfo.GetTaskByID)
		// myTask.GET("/getAllTaskInfo",con)
		// person.GET("/person", controller.GetPersonByID)
		// person.POST("/add", controller.AddPerson)
		// person.PUT("/update", controller.UpdatePerson)
		// person.DELETE("/delete", controller.DeletePerson)

	}
	project := pre.Group("/project")
	{
		project.GET("/getAllProjectInfo", projectInfo.GetAllProjects)
	}

	person := pre.Group("/person")
	{
		person.GET("/persons", controller.Persons)
		person.GET("/person", controller.GetPersonByID)
		person.POST("/add", controller.AddPerson)
		person.PUT("/update", controller.UpdatePerson)
		person.DELETE("/delete", controller.DeletePerson)

	}
	// 中间件拦截示例
	pre.GET("/cookie", utils.SetCK)
	// pre.GET("/home", middleware.AuthMiddleWare(), controller.Home)
	// pre.GET("/home2", middleware.JWTAuthMiddleware(), middleware.TokenCheck(), controller.Home2)
}

// SetupRouter 初始化路
func SetupRouter() *gin.Engine {
	r := gin.Default()
	return r
}
