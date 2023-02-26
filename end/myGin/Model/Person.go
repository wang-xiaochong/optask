package model

import (
	"database/sql"
	"fmt"
)

// Person 自定义Person类
type Person struct {
	Id        int    `json:"id"`
	FirstName string `json:"first_name" form:"first_name"`
	LastName  string `json:"last_name" form:"last_name"`
}

func (p *Person) GetAll(db *sql.DB) (persons []Person, err error) {
	rows, err := db.Query("select id,first_name,last_name from person")
	// fmt.Println("=========GetAll")
	fmt.Println(rows)
	if err != nil {
		return
	}
	for rows.Next() {
		var person Person
		rows.Scan(&person.Id, &person.FirstName, &person.LastName)
		persons = append(persons, person)
	}
	defer rows.Close()
	return
}

func (p *Person) Get(db *sql.DB) (person Person, err error) {
	row := db.QueryRow("SELECT id,first_name,last_name from person where id=?", p.Id)
	err = row.Scan(&person.Id, &person.FirstName, &person.LastName)
	if err != nil {
		return
	}
	return
}

func (p *Person) Add(db *sql.DB) (Id int, err error) {
	stmt, err := db.Prepare("INSERT into person(first_name,last_name) values (?,?)")
	if err != nil {
		return
	}
	rs, err := stmt.Exec(p.FirstName, p.LastName)
	if err != nil {
		return
	}
	id, err := rs.LastInsertId()
	if err != nil {
		fmt.Println(err)
	}
	Id = int(id)
	defer stmt.Close()
	return
}

func (p *Person) Update(db *sql.DB) (rows int, err error) {
	stmt, err := db.Prepare("update person set first_name=?,last_name=? where id=?")
	if err != nil {
		fmt.Println(err)
	}
	rs, err := stmt.Exec(p.FirstName, p.LastName, p.Id)
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

func (p *Person) Del(db *sql.DB) (rows int, err error) {
	stmt, err := db.Prepare("delete from person where id=?")
	if err != nil {
		fmt.Println(err)
	}
	rs, err := stmt.Exec(p.Id)
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

// func a(){
// 	p:=Person{}
// }
