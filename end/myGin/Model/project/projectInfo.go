package project

import (
	database "Example/Database"
	curd "Example/Utils/curd"
	"fmt"
	"strings"
)

// Person 自定义Person类
type ProjectInfo struct {
	Id       *int    `json:"id" form:"id"`              //唯一识别、主键自增
	Name     *string `json:"name" form:"name"`          //项目名称
	Parent   *int    `json:"parent"   form:"parent" `   //父级项目
	Status   *string `json:"status" form:"status" `     //项目状态
	UserInfo *string `json:"userInfo" form:"userInfo" ` //项目组成员
	Desc     *string `json:"desc" form:"desc" `         //项目简介
}

func (p *ProjectInfo) GetAll() []map[string]interface{} {
	ret := curd.GetAll("projectInfo")
	return ret
}

// func (p *ProjectInfo) GetProjectByID(id string) []map[string]interface{} {
// 	result := curd.Find("projectInfo", "id", id)
// 	return result
// }

func (p *ProjectInfo) GetProjectByID(id string) interface{} {
	sqlStr := "select * from projectInfo where id=?"
	//查询数据，取所有字段
	rows, err := database.MysqlDB.Query(sqlStr, id)
	if err != nil {
		fmt.Println(err)
	}
	ret := curd.HandleSQL(rows)
	// 查找userInfo
	if ret != nil && ret[0]["userInfo"] != nil {
		// map转string
		userInfo := fmt.Sprintf("%v", ret[0]["userInfo"])
		// string按逗号切割转成数组
		userInfoArry := strings.Split(userInfo, ",")
		// var userInfoRet []MyUserInfo.UserInfo
		sqlStr := "select id,name,avatar from userInfo where id=" + userInfoArry[0]
		// var tempID;
		for i := 1; i < len(userInfoArry); i++ {
			sqlStr = sqlStr + " or id=" + userInfoArry[i]
		}
		// fmt.Println(sqlStr)
		rows, err := database.MysqlDB.Query(sqlStr)
		if err != nil {
			fmt.Println(err)
		}
		ret[0]["userInfo"] = curd.HandleSQL(rows)
	}

	return ret[0]
}
