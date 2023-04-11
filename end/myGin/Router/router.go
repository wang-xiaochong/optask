package router

import (
	controller "Example/Controller"
	projectInfo "Example/Controller/projectInfo"
	routerInfo "Example/Controller/routerInfo"
	taskInfo "Example/Controller/taskInfo"
	userInfo "Example/Controller/userInfo"
	wikiInfo "Example/Controller/wikiInfo"
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
		user.POST("/updateUserInfoByID", userInfo.UpdateUserInfoByID)
		user.GET("/getRoleInfoByUserRoleInfo", userInfo.GetRoleInfoByUserRoleInfo)
		// user.POST("/add", controller.AddPerson)
		// user.PUT("/update", controller.UpdatePerson)
		// user.DELETE("/delete", controller.DeletePerson)

	}
	task := pre.Group("/task")
	{
		task.GET("/getAllTaskInfo", taskInfo.GetAllTasks)
		task.GET("/getTasksByCreatedBy", taskInfo.GetTasksByCreatedBy)
		task.GET("/getTasksByAppoint", taskInfo.GetTasksByAppoint)
		task.GET("/getTaskInfoByID", taskInfo.GetTaskByID)
		task.GET("/getTaskInfoByProjectID", taskInfo.GetTaskByProjectID)
		task.POST("/update", taskInfo.UpdateContent)
		// myTask.GET("/getAllTaskInfo",con)
		// person.GET("/person", controller.GetPersonByID)
		// person.POST("/add", controller.AddPerson)
		// person.PUT("/update", controller.UpdatePerson)
		// person.DELETE("/delete", controller.DeletePerson)

	}
	wiki := pre.Group("/wiki")
	{
		wiki.GET("/getAllWikiInfo", wikiInfo.GetAllWikis)
		wiki.GET("/getWikiInfoByID", wikiInfo.GetWikiByID)
		wiki.GET("/getWikiInfoByProjectID", wikiInfo.GetWikiByProjectID)
		wiki.POST("/update", wikiInfo.UpdateContent)
		wiki.POST("/updateWikiInfoByID", wikiInfo.UpdateWikiInfoByID)
	}
	project := pre.Group("/project")
	{
		project.GET("/getAllProjectInfo", projectInfo.GetAllProjects)
		project.GET("/getProjectInfoByID", projectInfo.GetProjectByID)
	}

	myRouter := pre.Group("/router")
	{
		myRouter.GET("/getAllRouterInfo", routerInfo.GetAllRouters)
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
