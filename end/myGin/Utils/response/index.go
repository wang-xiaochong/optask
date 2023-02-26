package response

import (
	utils "Example/Utils"

	"github.com/gin-gonic/gin"
)

// type Res struct {
// 	Code int
// 	Msg  string
// 	Data interface{}
// }

// func Success(res interface{}) Res {
// 	fmt.Println(res)
// 	return Res{
// 		Code: SUCCESS,
// 		Msg:  GetMsg(SUCCESS),
// 		Data: res,
// 	}
// }
// func Fail(errCode int, err error) Res {
// 	return Res{
// 		Code: errCode,
// 		Msg:  GetMsg(errCode),
// 		Data: err.Error(),
// 	}
// }

// Return 返回信息
func Return(c *gin.Context, code int, data interface{}) {
	var success = true
	if code != 1000 {
		success = false
	}

	c.JSON(200, gin.H{
		// "code": code,
		"success": success,
		"msg":     utils.GetMsg(code),
		"data":    data,
	})
}
