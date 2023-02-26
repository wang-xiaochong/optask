package user

import (
	"database/sql"
	"fmt"
)

// Person 自定义Person类
type UserInfo struct {
	// Id        int    `json:"id"`
	// FirstName string `json:"first_name" form:"first_name"`
	// LastName  string `json:"last_name" form:"last_name"`
	Id       *int    `json:"id" form:"id"`             //唯一识别、主键自增
	Account  *string `json:"account" form:"account"`   //登录账号
	Password *string `json:"password" form:"password"` //登录密码（加密）
	Avatar   *string `json:"avatar" form:"avatar"`     //头像
	Name     *string `json:"name" form:"name"`         //真实姓名
	Email    *string `json:"email" form:"email"`       //电子邮件
	Phone    *int    `json:"phone" form:"phone"`       //电话
	RoleInfo *int    `json:"roleInfo" form:"roleInfo"` //对应角色ID
	Salt     *string `json:"salt"   form:"salt" `      //盐，用于加密
}

// Login 模型
type Login struct {
	Account  *string `  form:"account" json:"account"  `
	Password *string `  form:"password" json:"password" `
}

func (l *Login) Login(db *sql.DB) (id int, err error) {
	row := db.QueryRow("select id from userInfo where account=?&&password=?", *&l.Account, *l.Password)
	err = row.Scan(&id)
	if err != nil {
		fmt.Println(err)
		return
	}
	return
}

func (p *UserInfo) GetAll(db *sql.DB) (userInfos []UserInfo, err error) {
	rows, err := db.Query("select id,account,name,avatar,email,phone from userInfo")
	// fmt.Println("=========GetAll")
	fmt.Println(rows)
	if err != nil {
		return
	}
	for rows.Next() {
		var userInfo UserInfo
		rows.Scan(&userInfo.Id, &userInfo.Account, &userInfo.Name, &userInfo.Avatar, &userInfo.Email, &userInfo.Phone)
		userInfos = append(userInfos, userInfo)
	}
	defer rows.Close()
	return
}

func (p *UserInfo) GetUserInfoById(db *sql.DB) (user UserInfo, err error) {
	row := db.QueryRow("select id,account,name,avatar,email,phone,salt from userInfo where id=?", p.Id)
	err = row.Scan(&user.Id, &user.Account, &user.Name, &user.Avatar, &user.Email, &user.Phone, &user.Salt)
	if err != nil {
		fmt.Println(err)
		return
	}
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
