package project

import (
	curd "Example/Utils/curd"
)

// Person 自定义Person类
type ProjectInfo struct {
	Id     *int    `json:"id" form:"id"`            //唯一识别、主键自增
	Name   *string `json:"name" form:"name"`        //项目名称
	Parent *int    `json:"parent"   form:"parent" ` //父级项目
	Status *string `json:"status" form:"status" `   //项目状态
}

func (p *ProjectInfo) GetAll() []map[string]interface{} {
	ret := curd.GetAll("projectInfo")
	return ret
}
