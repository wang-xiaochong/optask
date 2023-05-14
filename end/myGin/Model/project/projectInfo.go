package project

import (
	database "Example/Database"
	curd "Example/Utils/curd"
	"fmt"

	"github.com/gin-gonic/gin"
)

// Person 自定义Person类
type ProjectInfo struct {
	Id          *int    `json:"id" form:"id"`                    //唯一识别、主键自增
	Name        *string `json:"name" form:"name"`                //项目名称
	Parent      *string `json:"parent"   form:"parent" `         //父级项目
	Status      *string `json:"status" form:"status" `           //项目状态
	UserInfo    *string `json:"userInfo" form:"userInfo" `       //项目组成员
	Description *string `json:"description" form:"description" ` //项目简介
}

// Person 自定义Person类
type ProjectAddInfo struct {
	Name        *string `json:"name" form:"name"`                //项目名称
	Parent      *string `json:"parent"   form:"parent" `         //父级项目
	Status      *string `json:"status" form:"status" `           //项目状态
	Description *string `json:"description" form:"description" ` //项目简介
}

// Person 自定义Person类
type ProjectUpdateInfo struct {
	Id          *int    `json:"id" form:"id"`                    //唯一识别、主键自增
	Name        *string `json:"name" form:"name"`                //项目名称
	Status      *string `json:"status" form:"status" `           //项目状态
	UserInfo    *string `json:"userInfo" form:"userInfo" `       //项目组成员
	Description *string `json:"description" form:"description" ` //项目简介
}

func (p *ProjectInfo) GetAll() []map[string]interface{} {
	ret := curd.GetAll("projectInfo")
	return ret
}

// func (p *ProjectInfo) GetProjectByID(id string) []map[string]interface{} {
// 	result := curd.Find("projectInfo", "id", id)
// 	return result
// }

func (p *ProjectInfo) GetProjectByID(name string) interface{} {
	sqlStr := "select * from projectInfo where name=?"
	//查询数据，取所有字段
	rows, err := database.MysqlDB.Query(sqlStr, name)
	if err != nil {
		fmt.Println(err)
	}
	ret := curd.HandleSQL(rows)
	// 查找userInfo
	// if ret != nil && ret[0]["userInfo"] != nil {
	// 	// map转string
	// 	userInfo := fmt.Sprintf("%v", ret[0]["userInfo"])
	// 	// string按逗号切割转成数组
	// 	userInfoArry := strings.Split(userInfo, ",")
	// 	// var userInfoRet []MyUserInfo.UserInfo
	// 	sqlStr := "select id,name,avatar from userInfo where id=" + userInfoArry[0]
	// 	// var tempID;
	// 	for i := 1; i < len(userInfoArry); i++ {
	// 		sqlStr = sqlStr + " or id=" + userInfoArry[i]
	// 	}
	// 	// fmt.Println(sqlStr)
	// 	rows, err := database.MysqlDB.Query(sqlStr)
	// 	if err != nil {
	// 		fmt.Println(err)
	// 	}
	// 	ret[0]["userInfo"] = curd.HandleSQL(rows)
	// }

	return ret[0]
}

func (w *ProjectAddInfo) AddProjectInfo(u ProjectAddInfo, context *gin.Context) (Id int, err error) {
	stmt, err := database.MysqlDB.Prepare("insert into projectInfo(name,status,parent,description) values (?,?,?,?)")
	if err != nil {
		fmt.Println(err)
	}
	rs, err := stmt.Exec(*u.Name, *u.Status, *u.Parent, *u.Description)
	if err != nil {
		fmt.Println(err)
	}
	id, err := rs.LastInsertId()
	if err != nil {
		fmt.Println(err)
	}
	Id = int(id)
	defer stmt.Close()
	return
}

func (w *ProjectUpdateInfo) UpdateUserInfoByID(p ProjectUpdateInfo, context *gin.Context) (rows int, err error) {
	stmt, err := database.MysqlDB.Prepare("update projectInfo set name=?,status=?,userInfo=?,description=? where id=?")
	if err != nil {
		fmt.Println(err)
	}
	rs, err := stmt.Exec(*p.Name, *p.Status, *p.UserInfo, *p.Description, *p.Id)
	if err != nil {
		fmt.Println(err)
	}
	row, err := rs.RowsAffected()
	if err != nil {
		fmt.Println(err)
	}
	rows = int(row)
	defer stmt.Close()
	return
}
