package task

import (

	// "fmt"
	database "Example/Database"
	curd "Example/Utils/curd"
	"fmt"
	"time"
)

// Person 自定义Person类
type TaskInfo struct {
	Id             *int       `json:"id" form:"id"`                            //唯一识别、主键自增
	Name           *string    `json:"name" form:"name"`                        //任务名称
	Type           *string    `json:"type" form:"type"`                        //任务类型
	Status         *string    `json:"status" form:"status"`                    //状态
	Leval          *string    `json:"leval" form:"leval"`                      //优先级
	CreatedBy      *int       `json:"createdBy" form:"createdBy"`              //创建人
	CreatedTime    *time.Time `json:"createdTime" form:"createdTime"`          //创建时间
	Appoint        *int       `json:"appoint" form:"appoint"`                  //指定人
	Project        *int       `json:"project"   form:"project" `               //所属项目
	TaskUpdateInfo *int       `json:"taskUpdateInfo"   form:"taskUpdateInfo" ` //更新信息
	UpdateTime     *time.Time `json:"updateTime"   form:"updateTime" `         //最新更新时间
	EstimatedTime  *time.Time `json:"estimatedTime"   form:"estimatedTime" `   //预估时间
	ConsumeTime    *time.Time `json:"consumeTime"   form:"consumeTime" `       //已耗时间
	LeftTime       *time.Time `json:"leftTime"   form:"leftTime" `             //剩余时间
	Detail         *string    `json:"detail"   form:"detail" `                 //任务详情
	Date           *time.Time `json:"date"   form:"date" `                     //日期
	Parent         *int       `json:"parent"   form:"parent" `                 //父级任务
}

// // Login 模型
// type Login struct {
// 	Account  *string `  form:"account" json:"account"  `
// 	Password *string `  form:"password" json:"password" `
// }

// func (l *Login) Login(db *sql.DB) (id int, err error) {
// 	row := db.QueryRow("select id from userInfo where account=?&&password=?", *&l.Account, *l.Password)
// 	err = row.Scan(&id)
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	return id, err
// }

func (t *TaskInfo) GetAll() []interface{} {
	// ret := curd.GetAll("taskInfo")
	// return ret

	// sqlStr := "select t.*,p.name as project from taskInfo as t join projectInfo as p on t.project=p.id"
	// //查询数据，取所有字段
	// rows, err := database.MysqlDB.Query(sqlStr)
	// if err != nil {
	// 	fmt.Println("GetAllErr:", err)
	// }
	// ret := curd.HandleSQL(rows)
	// return ret

	sqlStr := "select t.*,p.name as project,u.name as appoint from taskInfo as t,projectInfo as p,userInfo as u where t.project=p.id and t.appoint=u.id order by t.id desc"
	//查询数据，取所有字段
	rows, err := database.MysqlDB.Query(sqlStr)
	if err != nil {
		fmt.Println("GetAllErr:", err)
	}
	ret := curd.HandleSQL(rows)

	// // 覆盖createdBy
	// sqlStr2 := "select u.name as createdBy from taskInfo as t, userInfo as u where t.createdBy=u.id"
	// rows2, err := database.MysqlDB.Query(sqlStr2)
	// if err != nil {
	// 	fmt.Println(err)
	// }
	// ret2 := curd.HandleSQL(rows2)
	// for i := 0; i < len(ret); i++ {
	// 	ret, _ := ret[i].(map[string]interface{})
	// 	ret2, _ := ret2[i].(map[string]interface{})
	// 	ret["createdBy"] = ret2["createdBy"]
	// 	// fmt.Println("isMap:", reflect.ValueOf(ret[i]).Kind() == reflect.Map)
	// }
	// fmt.Println("ret:", ret)
	return ret
}

func (t *TaskInfo) GetTasksByCreatedBy() []interface{} {
	result := curd.Find("taskInfo", "createdBy", 1)
	return result
}

// func (p *UserInfo) GetUserInfoById(db *sql.DB) (user UserInfo, err error) {
// 	row := db.QueryRow("select id,account,name,avatar,email,phone,salt from userInfo where id=?", p.Id)
// 	err = row.Scan(&user.Id, &user.Account, &user.Name, &user.Avatar, &user.Email, &user.Phone, &user.Salt)
// 	if err != nil {
// 		fmt.Println(err)
// 		return
// 	}
// 	return
// }

// func (p *UserInfo) Add(db *sql.DB) (Id int, err error) {
// 	stmt, err := db.Prepare("INSERT into person(first_name,last_name) values (?,?)")
// 	if err != nil {
// 		return
// 	}
// 	rs, err := stmt.Exec(p.FirstName, p.LastName)
// 	if err != nil {
// 		return
// 	}
// 	id, err := rs.LastInsertId()
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	Id = int(id)
// 	defer stmt.Close()
// 	return
// }

// func (p *UserInfo) Update(db *sql.DB) (rows int, err error) {
// 	stmt, err := db.Prepare("update person set first_name=?,last_name=? where id=?")
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	rs, err := stmt.Exec(p.FirstName, p.LastName, p.Id)
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	row, err := rs.RowsAffected()
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	rows = int(row)
// 	defer stmt.Close()
// 	return
// }

// func (p *UserInfo) Del(db *sql.DB) (rows int, err error) {
// 	stmt, err := db.Prepare("delete from person where id=?")
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	rs, err := stmt.Exec(p.Id)
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	row, err := rs.RowsAffected()
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// 	rows = int(row)
// 	defer stmt.Close()
// 	return
// }
