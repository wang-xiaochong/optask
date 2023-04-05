package curd

import (
	database "Example/Database"
	"database/sql"
	"encoding/json"
	"fmt"

	// "strings"
	"time"
	// "github.com/gin-gonic/gin"
)

// Change 键值对分离
// func Change(c *gin.Context, data []byte) (key []interface{}, value []interface{}) {
// 	Data := string(data)
// 	temp1 := strings.SplitN(Data, "{",2)
// 	temp :=strings.SplitN(temp1[1], "}",2)
// 	parts := strings.SplitN(temp[0], ",",-1)
// 	for _,v := range parts{
// 		key = append(key, strings.SplitN(v, "\"",-1)[1])
// 		value = append(value, strings.SplitN(v, ":",-1)[1] )
// 	}
// 	return key,value
// }

func HandleSQL(rows *sql.Rows) []map[string]interface{} {
	//返回所有列
	cols, _ := rows.Columns()
	//这里表示一行所有列的值，用[]byte表示
	vals := make([]interface{}, len(cols))
	//这里表示一行填充数据
	scans := make([]interface{}, len(vals))
	//这里scans引用vals，把数据填充到[]byte里
	for k := range vals {
		scans[k] = &vals[k]
	}
	var result []map[string]interface{}
	for rows.Next() {
		//填充数据
		rows.Scan(scans...)
		//每行数据
		row := make(map[string]interface{})
		//把vals中的数据复制到row中
		for k, v := range vals {
			if v == nil {
				row[cols[k]] = nil
			} else {
				switch val := (*scans[k].(*interface{})).(type) {
				case byte:
					row[cols[k]] = val
					break
				case []byte:
					v := string(val)
					switch v {
					case "\x00": // 处理数据类型为bit的情况
						row[cols[k]] = 0
					case "\x01": // 处理数据类型为bit的情况
						row[cols[k]] = 1
					default:
						row[cols[k]] = v
						break
					}
					break
				case time.Time:
					if val.IsZero() {
						row[cols[k]] = nil
					} else {
						row[cols[k]] = val.Format("2006-01-02 15:04:05")
					}
					break
				default:
					row[cols[k]] = v
				}
			}
			/*接收到后都为string型
			key := cols[k];
			//这里把[]byte数据转成string
			 fmt.Println("type",reflect.TypeOf(v),string(v))
			 row[key] = string(v);
			*/
		}
		//放入结果集
		// fmt.Println(row)
		// result[i] = row;
		str, err := json.Marshal(row)
		if err != nil {
			fmt.Println(err)
		}
		// result = append(result, string(str))
		var ret map[string]interface{}
		err = json.Unmarshal([]byte(str), &ret)
		if err != nil {
			fmt.Println(err)
		}
		result = append(result, ret)
		// result = append(result, string(str))
	}
	return result
}

func GetAll(collection string, args ...string) []map[string]interface{} {
	ret := Retrieve(collection, "id", "", args)
	return ret
}

// Retrieve 单字段模糊搜索
func Retrieve(collection string, searchKey string, value string, args []string) []map[string]interface{} {
	var sort = ""
	if args != nil {
		sort = "order by " + args[0] + " " + args[1]
	}
	sqlStr := "select * from " + collection + " where " + searchKey + " like ?"
	if sort != "" {
		sqlStr = sqlStr + " " + sort
	}
	sqlStr = sqlStr + ";"
	//查询数据，取所有字段
	rows, _ := database.MysqlDB.Query(sqlStr, "%"+value+"%")
	ret := HandleSQL(rows)
	return ret
}

// Find 单字段精确搜索
func Find(collection string, searchKey string, value interface{}) []map[string]interface{} {
	sqlStr := "select * from " + collection + " where " + searchKey + " =?;"
	//查询数据，取所有字段
	rows, _ := database.MysqlDB.Query(sqlStr, value)
	ret := HandleSQL(rows)
	return ret
}

// CreateOne 增加一条数据,相同字段值不可重复增加
// func CreateOne(c *gin.Context,collection string,reqData interface{},searchKey string,value string)  {
// 	//  格式转换  interface ==> []byte
// 	data, err := json.Marshal(reqData)
// 	if err != nil {
// 		fmt.Println(err.Error())
// 	}
// 	sqlStr := "select id from " + collection + " where " + searchKey + "=?;"
// 	// 判断是否存在
// 	rows := database.GetMysqlDB().QueryRow(sqlStr,value);
// 	var id int64
// 	rows.Scan(&id)
// 	if id >0 {
// 	Return(c,HAS_EXIST,nil)
//     return
// 	}
// 	// 键值分离
// 	vtemp1,vtemp2 := Change(c,data)
// 	// fmt.Print(vtemp1,vtemp2)
// 	//拼装sql语句
// 	sqlStr = "insert into " + collection + "("
// 	var strTemp1 string
// 	var strTemp2 string
// 	for _,v := range vtemp1{
// 		strTemp1 = strTemp1 + fmt.Sprintf("%v", v) + ","
// 	}
// 	strTemp1 = strTemp1[:len(strTemp1)-1]
// 	sqlStr = sqlStr + strTemp1 + ") " + "values " + "("
// 	for _,v := range vtemp2{
// 		strTemp2 = strTemp2 + fmt.Sprintf("%v", v) + ","
// 	}
// 	strTemp2 = strTemp2[:len(strTemp2)-1]
// 	sqlStr = sqlStr + strTemp2 + ")"
// 	// fmt.Println(sqlStr)
// 	// sqlStr := "insert into user(name,sex) values ('feifei',2)"
// 	// 插入到数据库
// 	ret, err := database.GetMysqlDB().Exec(sqlStr)
// 	if err != nil {
// 		Return(c,EXCEPTION,err.Error())
// 		fmt.Printf("insert failed %v\n", err)
// 		return
// 	}
// 	//如果是插入操作，可以拿到插入数据的id
// 	id, err = ret.LastInsertId()
// 	if err != nil {
// 		fmt.Printf("get id failed %v\n", err)
// 		return
// 	}
// 	// var info interface{}
// 	// json.Unmarshal(data, &info)
// 	Return(c,SUCCESS,nil)
// 	// fmt.Println("insert successful, id:", id)
// }

// UpdateOne 根据ID进行单个更新接口
// func UpdateOne(c *gin.Context,collection string,reqData interface{},searchKey string,value int64 )  {
// 	// 格式转换  interface ==> []byte
// 	data, err := json.Marshal(reqData)
// 	if err != nil {
// 		fmt.Println(err.Error())
// 	}
// 	// 拼接sql语句
// 	sqlStr := "update "  + collection + " set "

// 	vtemp1,vtemp2 := Change(c,data)
// 	fmt.Println(sqlStr)

// 	var strTemp1 string
// 	for _,v := range vtemp1{
// 		strTemp1 = strTemp1 + fmt.Sprintf("%v", v) + "=?, "
// 	}
// 	strTemp1 = strTemp1[:len(strTemp1)-2]
// 	sqlStr = sqlStr + strTemp1 + " where " + searchKey + "=?"

// 	for k,v := range vtemp2{
// 		t := strings.SplitN(fmt.Sprintf("%v", v), "\"",-1)
// 		if len(t[0]) == 0 {
// 			t[0]=t[1]
// 		}
// 		vtemp2[k] = t[0]
// 	}
// 	vtemp2 = append(vtemp2, value)
// 	// sqlStr := "update "  + collection + " set " + sex=0 where id > 2"
// 	ret, err := database.GetMysqlDB().Exec(sqlStr,vtemp2...)
// 	if err != nil {
// 		fmt.Printf("update failed %v\n", err)
// 		Return(c,PARA_ERROR,err)
// 		return
// 	}
// 	// RowsAffected获取更新了几行
// 	_, err = ret.RowsAffected()
// 	if err != nil {
// 		fmt.Printf("get n failed %v\n", err)
// 		return
// 	}
// 	Return(c,SUCCESS,nil)
// }

// DeleteOne 删除单个数据
// func DeleteOne(c *gin.Context,collection string,searchKey string,value int64 )  {
// 	sqlStr := "delete from " + collection + " where id =?"
// 	ret, err := database.GetMysqlDB().Exec(sqlStr, value)
// 	if err != nil {
// 		fmt.Printf("delete failed %v\n", err)
// 		Return(c,ERROR,err)
// 		return
// 	}
// 	_, err = ret.RowsAffected()
// 	if err != nil {
// 		fmt.Printf("get n failed %v\n", err)
// 		return
// 	}
// 	Return(c,SUCCESS,nil)
// 	// fmt.Printf("删除了%d行数据", n)
// }
