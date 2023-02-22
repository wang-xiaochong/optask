package database

// 导入模块
import (
	sqlConfig "Example/Config"
	"database/sql"
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql"
)

// 保留数据库链接
var MysqlDB *sql.DB

func InitMySql() *sql.DB {
	var mysqlConfig = sqlConfig.GetMysqlConfig()
	var err error

	var sqlString = fmt.Sprintf("%v:%v@tcp(%v:%v)/%v?parseTime=true", mysqlConfig.Account, mysqlConfig.Password, mysqlConfig.RemoteIP, mysqlConfig.RemotePort, mysqlConfig.Database)
	MysqlDB, err := sql.Open("mysql", sqlString)
	if err != nil {
		fmt.Println("Mysql连接失败")
		log.Fatal(err.Error())
	}
	//defer db.Close()
	err = MysqlDB.Ping()

	if err != nil {
		fmt.Println("Mysql连接失败")
		log.Fatal(err.Error())
	} else {
		fmt.Println("Mysql连接成功")
	}
	return MysqlDB
}

func GetMysqlDB() *sql.DB {
	if MysqlDB == nil {
		MysqlDB = InitMySql()
		return MysqlDB
	} else {
		return MysqlDB
	}
}
