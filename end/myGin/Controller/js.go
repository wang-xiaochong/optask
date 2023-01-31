package controller

import (
	utils "Example/Utils"
	// "fmt"
	"time"

	"github.com/gin-gonic/gin"
)

func JsUser(c *gin.Context)  {
	// fmt.Println(time.Now().UTC())
	var name = c.Query("name")
	if name == "test" {
		type Result struct {
			Name string
			Age  int
			Sex string
			ID string
		}
		var result Result = Result{
			Name: "xiaoShuai",
			Sex:  "男",
			Age:  23,
			ID: "123",
		}
		//5秒后返回结果 模拟延迟
		time.Sleep(time.Duration(5)*time.Second)
		utils.Return(c, utils.SUCCESS,result)
		return 
	} else {
		utils.Return(c, utils.NOT_EXIST,"")
		return
	}
}

func JsLesson(c *gin.Context)  {
	var ID = c.Query("id")
	if ID == "123" {

		type Result struct {
			Lesson []string
		}
		var tmp []string
		tmp = append(tmp, "语文","数学")
		var result Result = Result{
			Lesson: tmp,
		}
		utils.Return(c, utils.SUCCESS,result)
		return 
	} else {
		utils.Return(c, utils.NOT_EXIST,"")
		return
	}
}
