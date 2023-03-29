package wiki

import (
	curd "Example/Utils/curd"
)

// Person 自定义Person类
type WikiInfo struct {
	Id          *int    `json:"id" form:"id"`                    //唯一识别、主键自增
	Title       *string `json:"title" form:"title"`              //标题
	Content     *string `json:"content"   form:"content" `       //HTML内容
	Project     *int    `json:"project" form:"project" `         //所属项目
	CreatedBy   *int    `json:"createdBy" form:"createdBy" `     //创建人
	CreatedTime *string `json:"createdTime" form:"createdTime" ` //创建时间
	UpdateInfo  *int    `json:"updateInfo" form:"updateInfo" `   //更新的信息ID
	UpdateTime  *string `json:"updateTime" form:"updateTime" `   //最新的更新时间
	Parent      *int    `json:"parent" form:"parent" `           //父级wiki
}

func (w *WikiInfo) GetAll() []map[string]interface{} {
	ret := curd.GetAll("wikiInfo")
	return ret
}
