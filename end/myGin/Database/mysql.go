package database

// 导入模块
import (
	// "bytes"
	"database/sql"
	"fmt"
	"log"

	// "fmt"

	// "net/http"
	// "strconv"

	// "github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
)

// 保留数据库链接
var MysqlDB *sql.DB

func InitMySql() *sql.DB {
	var err error
	MysqlDB, err := sql.Open("mysql", "xiaochong:Lrb7MMY3AjKDGyGz@tcp(43.138.81.135:3306)/xiaochong?parseTime=true")
	fmt.Println("=========InitMySql")
	if err != nil {
		log.Fatal(err.Error())
	}
	//defer db.Close()
	err = MysqlDB.Ping()

	if err != nil {
		log.Fatal(err.Error())
	}
	return MysqlDB
}

func GetMysqlDB() *sql.DB {
	fmt.Println("=========GetMysqlDB")
	if MysqlDB == nil {
		MysqlDB = InitMySql()
		return MysqlDB
	} else {
		return MysqlDB
	}
}

// func TestMysql(db *sql.DB) {
// 	rows, err := db.Query("select * from person")
// 	if err != nil {
// 		return
// 	}
// 	defer rows.Close()
// 	var persons []Person
// 	for rows.Next() {
// 		var person Person
// 		rows.Scan(&person.Id, &person.FirstName, &person.LastName)
// 		persons = append(persons, person)
// 	}
// 	fmt.Println(persons)
// }

// func main() {
//test(db)
//创建路由引擎
// router := gin.Default()

// //查询,返回所有对象和对象个数
// router.GET("/persons", func(context *gin.Context) {
// 	p := Person{}
// 	persons, err := p.getAll(MysqlDB)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	context.JSON(http.StatusOK, gin.H{
// 		"result": persons,
// 		"count":  len(persons),
// 	})
// })
// //根据id查询
// router.GET("/person/:id", func(context *gin.Context) {
// 	var result gin.H
// 	id := context.Param("id")

// 	Id, err := strconv.Atoi(id)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	p := Person{
// 		Id: Id,
// 	}
// 	person, err := p.get(db)
// 	if err != nil {
// 		result = gin.H{
// 			"result": nil,
// 			"count":  0,
// 		}
// 	} else {
// 		result = gin.H{
// 			"result": person,
// 			"count":  1,
// 		}
// 	}
// 	context.JSON(http.StatusOK, result)
// })
// //创建person
// router.POST("/person", func(context *gin.Context) {
// 	var p Person
// 	err := context.Bind(&p)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}

// 	Id, err := p.add(db)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	fmt.Println(Id)
// 	name := p.FirstName + " " + p.LastName
// 	context.JSON(http.StatusOK, gin.H{
// 		"message": fmt.Sprintf(" %s 成功创建", name),
// 	})
// })
// //更新update
// router.PUT("/person/:id", func(context *gin.Context) {
// 	var (
// 		p      Person
// 		buffer bytes.Buffer
// 	)

// 	id := context.Param("id")
// 	Id, err := strconv.Atoi(id)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	err = context.Bind(&p)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	p.Id = Id
// 	rows, err := p.update(db)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	fmt.Println(rows)
// 	buffer.WriteString(p.FirstName)
// 	buffer.WriteString(" ")
// 	buffer.WriteString(p.LastName)
// 	name := buffer.String()

// 	context.JSON(http.StatusOK, gin.H{
// 		"message": fmt.Sprintf("成功更新到%s", name),
// 	})
// })
// //删除person
// router.DELETE("/person/:id", func(context *gin.Context) {
// 	id := context.Param("id")

// 	Id, err := strconv.ParseInt(id, 10, 10)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	p := Person{Id: int(Id)}
// 	rows, err := p.del(db)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
// 	fmt.Println("delete rows: ", rows)

// 	context.JSON(http.StatusOK, gin.H{
// 		"message": fmt.Sprintf("成功删除用户：%s", id),
// 	})
// })
// router.Run(":9090")
// }
