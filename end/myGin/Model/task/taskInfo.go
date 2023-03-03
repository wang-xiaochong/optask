package task

import (
	"fmt"

	// "fmt"
	curd "Example/Utils/curd"
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

func (t *TaskInfo) GetAll() {
	// rows, err := db.Query("select * from taskInfo")
	// // fmt.Println("=========GetAll")
	// // fmt.Println(rows)
	// if err != nil {
	// 	return
	// }
	// for rows.Next() {
	// 	var taskInfo TaskInfo
	// 	rows.Scan(&userInfo.Id, &userInfo.Account, &userInfo.Name, &userInfo.Avatar, &userInfo.Email, &userInfo.Phone)
	// 	userInfos = append(userInfos, userInfo)
	// }
	// defer rows.Close()
	// return
	ret := curd.Retrieve("taskInfo", "name", "")
	fmt.Println(ret)
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
