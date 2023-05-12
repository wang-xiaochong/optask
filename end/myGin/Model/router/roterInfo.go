package router

import (
	curd "Example/Utils/curd"
)

// Person 自定义Person类
type RouterInfo struct {
	Id          *int    `json:"id" form:"id"`                    //唯一识别、主键自增
	Name        *string `json:"name" form:"name"`                //路由名称
	Component   *string `json:"component"   form:"component" `   //前端对应界面入口路径
	Path        *string `json:"path" form:"path" `               //页面访问路径
	Description *string `json:"description" form:"description" ` //描述
}

func (r *RouterInfo) GetAll() []map[string]interface{} {
	ret := curd.GetAll("routerInfo")
	return ret
}
