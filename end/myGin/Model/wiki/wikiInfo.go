package wiki

import (
	database "Example/Database"
	curd "Example/Utils/curd"
	"fmt"
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

type WikiInfoUpdate struct {
	Id         *int    `json:"id" form:"id"`                  //唯一识别、主键自增
	Title      *string `json:"title" form:"title"`            //标题
	Content    *string `json:"content"   form:"content" `     //HTML内容
	Project    *int    `json:"project" form:"project" `       //所属项目
	UpdateInfo *int    `json:"updateInfo" form:"updateInfo" ` //更新的信息ID
	UpdateTime *string `json:"updateTime" form:"updateTime" ` //最新的更新时间
	Parent     *int    `json:"parent" form:"parent" `         //父级wiki
}

func (w *WikiInfo) GetAll() []map[string]interface{} {
	ret := curd.GetAll("wikiInfo", "id", "desc")

	// 覆盖createrdBy
	for i := 0; i < len(ret); i++ {
		// fmt.Println("ret:", ret[i])
		sqlStr2 := "select u.name as createdBy from userInfo as u where u.id=?"
		rows2, err := database.MysqlDB.Query(sqlStr2, ret[i]["createdBy"])
		if err != nil {
			fmt.Println(err)
		}
		ret2 := curd.HandleSQL(rows2)
		ret[i]["createdBy"] = ret2[0]["createdBy"]
	}
	return ret
}

func (w *WikiInfo) GetWikiByID(id string) map[string]interface{} {
	sqlStr := "select * from wikiInfo where id=?"
	//查询数据，取所有字段
	rows, err := database.MysqlDB.Query(sqlStr, id)
	if err != nil {
		fmt.Println(err)
	}
	ret := curd.HandleSQL(rows)
	return ret[0]
}

func (w *WikiInfoUpdate) UpdateContent(wu WikiInfoUpdate) (rows int, err error) {
	stmt, err := database.MysqlDB.Prepare("update wikiInfo set content=?,title=?,updateTime=?,updateInfo=? where id=?")
	if err != nil {
		fmt.Println(err)
	}
	rs, err := stmt.Exec(*wu.Content, *wu.Title, *wu.UpdateTime, *wu.UpdateInfo, *wu.Id)
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
