package project

import (
	curd "Example/Utils/curd"
)

// Person 自定义Person类
type ProjectInfo struct {
	Id     *int    `json:"id" form:"id"`            //唯一识别、主键自增
	Name   *string `json:"name" form:"name"`        //项目名称
	Parent *int    `json:"parent"   form:"parent" ` //父级项目
}

func (p *ProjectInfo) GetAll() []interface{} {
	// sqlStr := "select * from projectInfo"
	// //查询数据，取所有字段
	// rows, err := database.MysqlDB.Query(sqlStr)
	// if err != nil {
	// 	fmt.Println("GetAllErr:", err)
	// }
	// ret := curd.HandleSQL(rows)
	ret := curd.GetAll("projectInfo")
	return ret
}
