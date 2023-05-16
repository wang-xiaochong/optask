package task

import (

	// "fmt"
	database "Example/Database"
	curd "Example/Utils/curd"
	"fmt"
	"time"

	"github.com/gin-gonic/gin"
)

// Person 自定义Person类
type TaskInfo struct {
	Id             *int       `json:"id" form:"id"`                            //唯一识别、主键自增
	Name           *string    `json:"name" form:"name"`                        //任务名称
	Type           *string    `json:"type" form:"type"`                        //任务类型
	Status         *string    `json:"status" form:"status"`                    //状态
	Leval          *string    `json:"leval" form:"leval"`                      //优先级
	CreatedBy      *string    `json:"createdBy" form:"createdBy"`              //创建人
	CreatedTime    *time.Time `json:"createdTime" form:"createdTime"`          //创建时间
	EndTime        *time.Time `json:"endTime" form:"endTime"`                  //创建时间
	Appoint        *string    `json:"appoint" form:"appoint"`                  //指定人
	Project        *string    `json:"project"   form:"project" `               //所属项目
	TaskUpdateInfo *int       `json:"taskUpdateInfo"   form:"taskUpdateInfo" ` //更新信息
	UpdateTime     *time.Time `json:"updateTime"   form:"updateTime" `         //最新更新时间
	EstimatedTime  *int       `json:"estimatedTime"   form:"estimatedTime" `   //预估时间
	ConsumeTime    *int       `json:"consumeTime"   form:"consumeTime" `       //已耗时间
	LeftTime       *int       `json:"leftTime"   form:"leftTime" `             //剩余时间
	Detail         *string    `json:"detail"   form:"detail" `                 //任务详情
	Parent         *string    `json:"parent"   form:"parent" `                 //父级任务
}

type TaskUpdateInfo struct {
	Id            *int    `json:"id" form:"id"`                          //唯一识别、主键自增
	Name          *string `json:"name" form:"name"`                      //任务名称
	Type          *string `json:"type" form:"type"`                      //任务类型
	Status        *string `json:"status" form:"status"`                  //状态
	Leval         *string `json:"leval" form:"leval"`                    //优先级
	CreatedBy     *string `json:"createdBy" form:"createdBy"`            //创建人
	CreatedTime   *string `json:"createdTime" form:"createdTime"`        //创建时间
	EndTime       *string `json:"endTime" form:"endTime"`                //创建时间
	Appoint       *string `json:"appoint" form:"appoint"`                //指定人
	Project       *string `json:"project"   form:"project" `             //所属项目
	UpdateTime    *string `json:"updateTime"   form:"updateTime" `       //最新更新时间
	EstimatedTime *int    `json:"estimatedTime"   form:"estimatedTime" ` //预估时间
	ConsumeTime   *int    `json:"consumeTime"   form:"consumeTime" `     //已耗时间
	LeftTime      *int    `json:"leftTime"   form:"leftTime" `           //剩余时间
	Detail        *string `json:"detail"   form:"detail" `               //任务详情
	Parent        *string `json:"parent"   form:"parent" `               //父级任务
}

type TaskInfoUpdate struct {
	Id         *int    `json:"id" form:"id"`                    //唯一识别、主键自增
	Name       *string `json:"name" form:"name"`                //任务名称
	Type       *string `json:"type" form:"type"`                //任务类型
	Status     *string `json:"status" form:"status"`            //状态
	CreatedBy  *string `json:"createdBy" form:"createdBy"`      //创建人
	Appoint    *string `json:"appoint" form:"appoint"`          //指定人
	UpdateTime *string `json:"updateTime"   form:"updateTime" ` //最新更新时间
	Project    *string `json:"project"   form:"project" `       //所属项目
}

type TaskAddInfo struct {
	Name    *string `json:"name" form:"name"`        //任务名称
	Type    *string `json:"type" form:"type"`        //任务类型
	Status  *string `json:"status" form:"status"`    //状态
	Leval   *string `json:"leval" form:"leval"`      //优先级
	Project *string `json:"project" form:"project" ` //所属项目
}

func (t *TaskInfo) GetAll() []map[string]interface{} {
	ret := curd.GetAll("taskInfo", "id", "desc")
	return ret

	// sqlStr := "select t.*,p.name as project from taskInfo as t join projectInfo as p on t.project=p.id"
	// //查询数据，取所有字段
	// rows, err := database.MysqlDB.Query(sqlStr)
	// if err != nil {
	// 	fmt.Println("GetAllErr:", err)
	// }
	// ret := curd.HandleSQL(rows)
	// return ret

	// sqlStr := "select t.*,p.name as project,u.name as appoint from taskInfo as t,projectInfo as p,userInfo as u where t.project=p.id and t.appoint=u.id order by t.id desc"
	//查询数据，取所有字段
	// rows, err := database.MysqlDB.Query(sqlStr)
	// if err != nil {
	// 	fmt.Println("GetAllErr:", err)
	// }
	// ret := curd.HandleSQL(rows)
	// 覆盖createrdBy
	// for i := 0; i < len(ret); i++ {
	// 	// fmt.Println("ret:", ret[i])
	// 	sqlStr2 := "select u.name as createdBy from userInfo as u where u.id=?"
	// 	rows2, err := database.MysqlDB.Query(sqlStr2, ret[i]["createdBy"])
	// 	if err != nil {
	// 		fmt.Println(err)
	// 	}
	// 	ret2 := curd.HandleSQL(rows2)
	// 	ret[i]["createdBy"] = ret2[0]["createdBy"]
	// 	// fmt.Println("ret2:", ret[i])
	// 	if ret[i]["taskUpdateInfo"] != nil {
	// 		ret[i]["taskUpdateInfo"] = getTaskUpdateInfo(ret[i]["taskUpdateInfo"])
	// 	}
	// }

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
	// return ret
}

func (t *TaskInfo) GetTasksByCreatedBy(createdBy string) []map[string]interface{} {
	result := curd.Find("taskInfo", "createdBy", createdBy)
	return result
	// sqlStr := "select t.*,p.name as project,u.name as createdBy from taskInfo as t,projectInfo as p,userInfo as u where t.createdBy=? and t.project=p.id and t.createdBy=u.id"
	// //查询数据，取所有字段
	// rows, err := database.MysqlDB.Query(sqlStr, createdBy)
	// if err != nil {
	// 	fmt.Println(err)
	// }
	// ret := curd.HandleSQL(rows)

	// for i := 0; i < len(ret); i++ {
	// 	// fmt.Println("ret:", ret[i])
	// 	sqlStr2 := "select u.name as appoint from userInfo as u where u.id=?"
	// 	rows2, err := database.MysqlDB.Query(sqlStr2, ret[i]["appoint"])
	// 	if err != nil {
	// 		fmt.Println(err)
	// 	}
	// 	ret2 := curd.HandleSQL(rows2)
	// 	ret[i]["appoint"] = ret2[0]["appoint"]
	// 	// fmt.Println("ret2:", ret[i])
	// 	if ret[i]["taskUpdateInfo"] != nil {
	// 		ret[i]["taskUpdateInfo"] = getTaskUpdateInfo(ret[i]["taskUpdateInfo"])
	// 	}
	// }
	// return ret
}

func (t *TaskInfo) GetTasksByAppoint(appoint string) []map[string]interface{} {
	result := curd.Find("taskInfo", "appoint", appoint)
	return result
	// sqlStr := "select t.*,p.name as project,u.name as appoint from taskInfo as t,projectInfo as p,userInfo as u where t.appoint=? and t.project=p.id and t.appoint=u.id"
	// //查询数据，取所有字段
	// rows, err := database.MysqlDB.Query(sqlStr, appoint)
	// if err != nil {
	// 	fmt.Println(err)
	// }
	// ret := curd.HandleSQL(rows)
	// 覆盖createrdBy
	// for i := 0; i < len(ret); i++ {
	// 	// fmt.Println("ret:", ret[i])
	// 	sqlStr2 := "select u.name as createdBy from userInfo as u where u.id=?"
	// 	rows2, err := database.MysqlDB.Query(sqlStr2, ret[i]["createdBy"])
	// 	if err != nil {
	// 		fmt.Println(err)
	// 	}
	// 	ret2 := curd.HandleSQL(rows2)
	// 	ret[i]["createdBy"] = ret2[0]["createdBy"]
	// 	// fmt.Println("ret2:", ret[i])
	// 	if ret[i]["taskUpdateInfo"] != nil {
	// 		ret[i]["taskUpdateInfo"] = getTaskUpdateInfo(ret[i]["taskUpdateInfo"])
	// 	}
	// }

	// return ret
}

func (t *TaskInfo) GetTaskByProjectID(name string) []map[string]interface{} {
	result := curd.Find("taskInfo", "project", name)
	return result
}

func getTaskUpdateInfo(id interface{}) interface{} {
	// ret := 1
	var sqlStr string
	sqlStr = "select * from taskUpdateInfo where id=?"
	rows, err := database.MysqlDB.Query(sqlStr, id)
	if err != nil {
		fmt.Println(err)
	}
	ret := curd.HandleSQL(rows)
	if ret[0]["taskUpdateInfo"] != nil {
		ret[0]["taskUpdateInfo"] = getTaskUpdateInfo(ret[0]["taskUpdateInfo"])
	}

	return ret[0]
}

func (t *TaskInfo) GetTaskByID(id string) interface{} {
	result := curd.Find("taskInfo", "id", id)
	return result[0]

	// sqlStr := "select t.*,p.name as project,u.name as createdBy from taskInfo as t,projectInfo as p,userInfo as u where t.id=? and t.project=p.id and t.createdBy=u.id"
	// //查询数据，取所有字段
	// rows, err := database.MysqlDB.Query(sqlStr, id)
	// if err != nil {
	// 	fmt.Println(err)
	// }
	// ret := curd.HandleSQL(rows)

	// // 查找appoint
	// sqlStr2 := "select u.name as appoint from userInfo as u where u.id=?"
	// rows2, err := database.MysqlDB.Query(sqlStr2, ret[0]["appoint"])
	// if err != nil {
	// 	fmt.Println(err)
	// }
	// ret2 := curd.HandleSQL(rows2)
	// ret[0]["appoint"] = ret2[0]["appoint"]

	// if ret[0]["taskUpdateInfo"] != nil {
	// 	ret[0]["taskUpdateInfo"] = getTaskUpdateInfo(ret[0]["taskUpdateInfo"])
	// }

	// // fmt.Println("ret", ret)
	// // fmt.Println("ret2", ret2)

	// return ret[0]
}

func (tu *TaskUpdateInfo) UpdateContent(t TaskUpdateInfo) (rows int, err error) {
	// sqlStr2 := "select id from userInfo as u where u.name=?"
	// rows2, err := database.MysqlDB.Query(sqlStr2, t.CreatedBy)
	// if err != nil {
	// 	fmt.Println("ModelErr:", err)
	// }
	// ret2 := curd.HandleSQL(rows2)
	// var createdById = ret2[0]["id"]

	// sqlStr3 := "select id from userInfo as u where u.name=?"
	// rows3, err := database.MysqlDB.Query(sqlStr3, t.Appoint)
	// if err != nil {
	// 	fmt.Println(err)
	// }
	// ret3 := curd.HandleSQL(rows3)
	// var appointId = ret3[0]["id"]

	// sqlStr4 := "select id from projectInfo as p where p.name=?"
	// rows4, err := database.MysqlDB.Query(sqlStr4, t.Project)
	// if err != nil {
	// 	fmt.Println(err)
	// }
	// ret4 := curd.HandleSQL(rows4)
	// var projectId = ret4[0]["id"]

	stmt, err := database.MysqlDB.Prepare("update taskInfo set name=?,type=?,status=?,leval=?,createdBy=?,createdTime=?,endTime=?,appoint=?,project=?,updateTime=?,estimatedTime=?,consumeTime=?,leftTime=?,detail=? where id=?")
	if err != nil {
		fmt.Println("ModealSqlErr:", err)
	}
	// fmt.Println(*t.Name, *t.Type, *t.Status, *t.Leval, createdById, *t.CreatedTime, appointId, projectId, *t.UpdateTime, *t.Detail, *t.Id)

	// rs, err := stmt.Exec(*t.Name, *t.Type, *t.Status, *t.Leval, createdById, *t.CreatedTime, *t.EndTime, appointId, projectId, *t.UpdateTime, *t.EstimatedTime, *t.ConsumeTime, *t.LeftTime, *t.Detail, *t.Id)
	rs, err := stmt.Exec(*t.Name, *t.Type, *t.Status, *t.Leval, *t.CreatedBy, *t.CreatedTime, *t.EndTime, t.Appoint, t.Project, *t.UpdateTime, *t.EstimatedTime, *t.ConsumeTime, *t.LeftTime, *t.Detail, *t.Id)

	if err != nil {
		fmt.Println("sqlUpdateErr:", err)
	}
	row, err := rs.RowsAffected()
	if err != nil {
		fmt.Println("ModealSqlErr:", err)
	}
	// fmt.Println("ModealSqlErr:", err)
	rows = int(row)
	defer stmt.Close()
	return
}

func (q *TaskAddInfo) AddWikiInfo(t TaskAddInfo, context *gin.Context) (Id int, err error) {
	stmt, err := database.MysqlDB.Prepare("insert into taskInfo(name,type,status,leval,project) values (?,?,?,?,?)")
	if err != nil {
		fmt.Println(err)
	}
	rs, err := stmt.Exec(*t.Name, *t.Type, *t.Status, *t.Leval, *t.Project)
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

func (tu *TaskInfoUpdate) UpdateTaskInfo(t TaskInfoUpdate) (rows int, err error) {

	stmt, err := database.MysqlDB.Prepare("update taskInfo set name=?,type=?,status=?,createdBy=?,appoint=?,updateTime=?,project=? where id=?")
	if err != nil {
		fmt.Println("ModealSqlErr:", err)
	}
	rs, err := stmt.Exec(*t.Name, *t.Type, *t.Status, *t.CreatedBy, *t.Appoint, *t.UpdateTime, *t.Project, *t.Id)
	if err != nil {
		fmt.Println("sqlUpdateErr:", err)
	}
	row, err := rs.RowsAffected()
	if err != nil {
		fmt.Println("ModealSqlErr:", err)
	}
	// fmt.Println("ModealSqlErr:", err)
	rows = int(row)
	defer stmt.Close()
	return
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
