package user

import (
	database "Example/Database"
	redis "Example/Redis"
	keys "Example/Redis/keys"
	"Example/Utils/curd"
	"database/sql"
	"fmt"

	"github.com/gin-gonic/gin"
)

// Person 自定义Person类
type UserInfo struct {
	// Id        int    `json:"id"`
	// FirstName string `json:"first_name" form:"first_name"`
	// LastName  string `json:"last_name" form:"last_name"`
	Id       *int    `json:"id" form:"id"`                //唯一识别、主键自增
	Account  *string `json:"account" form:"account"`      //登录账号
	Password *string `json:"password" form:"password"`    //登录密码（加密）
	Avatar   *string `json:"avatar" form:"avatar"`        //头像
	Name     *string `json:"name" form:"name"`            //真实姓名
	Email    *string `json:"email" form:"email"`          //电子邮件
	Phone    *string `json:"phone" form:"phone"`          //电话
	RoleInfo *string `json:"roleInfo" form:"roleInfo"`    //对应角色ID
	Salt     *string `json:"salt"   form:"salt" `         //盐，用于加密
	Birthday *string `json:"birthday"   form:"birthday" ` //生日
	Job      *string `json:"job"   form:"job" `           //职位
}

type UserUpdateInfo struct {
	Id       *int    `json:"id" form:"id"`                //唯一识别、主键自增
	Account  *string `json:"account" form:"account"`      //登录账号
	Avatar   *string `json:"avatar" form:"avatar"`        //头像
	Name     *string `json:"name" form:"name"`            //真实姓名
	Email    *string `json:"email" form:"email"`          //电子邮件
	Phone    *string `json:"phone" form:"phone"`          //电话
	RoleInfo *string `json:"roleInfo" form:"roleInfo"`    //对应角色ID
	Birthday *string `json:"birthday"   form:"birthday" ` //生日
	Job      *string `json:"job"   form:"job" `           //职位
}

type UpdateUserRoleAndJob struct {
	Id       *int    `json:"id" form:"id"`             //唯一识别、主键自增
	RoleInfo *string `json:"roleInfo" form:"roleInfo"` //对应角色ID
	Job      *string `json:"job"   form:"job" `        //职位
}

type UserAddInfo struct {
	Account  *string `json:"account" form:"account"`   //登录账号
	Password *string `json:"password" form:"password"` //登录密码（加密）
	Name     *string `json:"name" form:"name"`         //真实姓名
	RoleInfo *string `json:"roleInfo" form:"roleInfo"` //对应角色ID
	Job      *string `json:"job"   form:"job" `        //职位
}

// Login 模型
type Login struct {
	Account  *string `  form:"account" json:"account"  `
	Password *string `  form:"password" json:"password" `
}

// ResetPassword 模型
type ResetPassword struct {
	Account  *string `  form:"account" json:"account"  `
	Password *string `  form:"password" json:"password" `
	Phone    *string `json:"phone" form:"phone"` //电话
}

func (l *Login) Login(db *sql.DB) (id int, err error) {
	row := db.QueryRow("select id from userInfo where account=?&&password=?", *&l.Account, *l.Password)
	err = row.Scan(&id)
	if err != nil {
		fmt.Println(err)
	}
	return id, err
}

func (l *ResetPassword) ResetPassword(db *sql.DB) (rows int, err error) {
	row := db.QueryRow("select id from userInfo where account=?&&phone=?", *&l.Account, *l.Phone)
	var id int
	err = row.Scan(&id)
	if err != nil {
		fmt.Println(err)
		return rows, err
	}

	stmt, err := database.MysqlDB.Prepare("update userInfo set password=? where id=?")
	if err != nil {
		fmt.Println(err)
	}

	rs, err := stmt.Exec(*l.Password, id)
	if err != nil {
		fmt.Println(err)
	}
	rowint64, err := rs.RowsAffected()
	if err != nil {
		fmt.Println(err)
	}
	rows = int(rowint64)
	defer stmt.Close()

	return rows, err
}

// func (p *UserInfo) GetAll(db *sql.DB) (userInfos []UserInfo, err error) {
// 	rows, err := db.Query("select id,account,name,avatar,email,phone,roleInfo,salt,birthday,job from userInfo")
// 	if err != nil {
// 		return
// 	}
// 	for rows.Next() {
// 		var userInfo UserInfo
// 		rows.Scan(&userInfo.Id, &userInfo.Account, &userInfo.Name, &userInfo.Avatar, &userInfo.Email, &userInfo.Phone, &userInfo.RoleInfo, &userInfo.Salt, &userInfo.Birthday, &userInfo.Job)
// 		userInfos = append(userInfos, userInfo)
// 	}
// 	defer rows.Close()
// 	return
// }

func (p *UserInfo) GetAll(db *sql.DB) (ret []map[string]interface{}, err error) {
	ret = curd.GetAll("userInfo", "id", "desc")
	// 覆盖roleInfo
	// for i := 0; i < len(ret); i++ {
	// 	// fmt.Println("ret:", ret[i])
	// 	sqlStr2 := "select r.name as roleInfo from roleInfo as r where r.id=?"
	// 	rows2, err := database.MysqlDB.Query(sqlStr2, ret[i]["roleInfo"])
	// 	if err != nil {
	// 		fmt.Println(err)
	// 	}
	// 	ret2 := curd.HandleSQL(rows2)
	// 	ret[i]["roleInfo"] = ret2[0]["roleInfo"]
	// }
	return
}

func (p *UserInfo) GetUserInfoById(db *sql.DB) (user UserInfo, err error) {
	row := db.QueryRow("select id,account,name,avatar,email,phone,salt,roleInfo,birthday,job from userInfo where id=?", p.Id)
	err = row.Scan(&user.Id, &user.Account, &user.Name, &user.Avatar, &user.Email, &user.Phone, &user.Salt, &user.RoleInfo, &user.Birthday, &user.Job)
	if err != nil {
		fmt.Println(err)
		return
	}
	return
}

func (p *UserInfo) CheckAccount(db *sql.DB) (isHasAccount bool, err error) {
	// fmt.Println("p.Account:", *p.Account)
	row := db.QueryRow("select name from userInfo where account=?", *p.Account)
	err = row.Scan(&p.Name)
	if err != nil {
		// fmt.Println(err)
		isHasAccount = false
		return
	}
	isHasAccount = true
	return
}

func (w *UpdateUserRoleAndJob) UpdateUserRoleAndJob(u UpdateUserRoleAndJob, context *gin.Context) (rows int, err error) {

	stmt, err := database.MysqlDB.Prepare("update userInfo set roleInfo=?,job=? where id=?")
	if err != nil {
		fmt.Println(err)
	}

	rs, err := stmt.Exec(*u.RoleInfo, *u.Job, *u.Id)
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

func (w *UserUpdateInfo) UpdateUserInfoByID(u UserUpdateInfo, context *gin.Context) (rows int, err error) {

	// fmt.Println("=======")
	stmt, err := database.MysqlDB.Prepare("update userInfo set account=?,name=?,avatar=?,email=?,phone=?,roleInfo=?,birthday=?,job=? where id=?")
	if err != nil {
		fmt.Println(err)
	}

	rs, err := stmt.Exec(*u.Account, *u.Name, *u.Avatar, *u.Email, *u.Phone, *u.RoleInfo, *u.Birthday, *u.Job, *u.Id)
	if err != nil {
		fmt.Println(err)

	}
	row, err := rs.RowsAffected()
	if err != nil {
		fmt.Println(err)
	}
	rows = int(row)
	defer stmt.Close()

	reqIP := context.ClientIP()
	if reqIP == "::1" {
		reqIP = "127.0.0.1"
	}
	_, err = redis.DelKey(keys.REACT_APP_REDIS_USERINFO_ID_ + reqIP)
	if err != nil {
		fmt.Println(err)
	}
	return
}

func (w *UserAddInfo) AddUserInfo(u UserAddInfo, context *gin.Context) (Id int, err error) {
	stmt, err := database.MysqlDB.Prepare("insert into userInfo(account,password,name,roleInfo,job) values (?,?,?,?,?)")
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println("========1")
	rs, err := stmt.Exec(*u.Account, *u.Password, *u.Name, *u.RoleInfo, *u.Job)
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
