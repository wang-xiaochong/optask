package role

import (
	database "Example/Database"
	"Example/Utils/curd"
	"fmt"
)

// Role 模型
type RoleInfo struct {
	Id         *int    `json:"id" form:"id"`
	Name       *string `json:"name" form:"name"`
	RouterInfo *string `json:"routerInfo" form:"routerInfo"`
	Desc       *string `json:"desc" form:"desc"`
}

func (r *RoleInfo) GetRoleInfoByID(name string) (ret map[string]interface{}, err error) {
	sqlStr := "select * from roleInfo where name=?"
	//查询数据，取所有字段
	rows, err := database.MysqlDB.Query(sqlStr, name)
	if err != nil {
		fmt.Println(err)
	}
	ret = curd.HandleSQL(rows)[0]
	return
}
