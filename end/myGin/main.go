package main

import (
	database "Example/Database"
	redis "Example/Redis"
	utils "Example/Utils"
	router "Example/router"
	"fmt"
)

func init() {
	redis.GetRedisPool()
	utils.InitValidator() //验证
	// database.GetMongoDB()
	database.GetMysqlDB()
}
func main() {
	r := router.SetupRouter()
	//r.Use(middleware.MiddleWare())    //全局中间件
	router.InitRouter(r)
	if err := r.Run(":9090"); err != nil {
		fmt.Printf("startup service failed, err:%v\n", err)
	}
}
