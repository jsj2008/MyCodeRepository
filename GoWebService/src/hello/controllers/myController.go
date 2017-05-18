package controllers

import (
	"github.com/astaxie/beego"
	. "hello/models"
	"fmt"
	"encoding/json"
)

type MyJsonData struct {
	Name string
	Age int
}

type  MyController struct {
	beego.Controller
}

func (this *MyController) Get() {
	// this.Ctx.WriteString("hes")
	myData := &MyJsonData{Name : "name", Age : 100}

	// var jsonString string
	value, _ := json.Marshal(myData)
	this.Data["json"] = string(value)
	this.ServeJSON()
	fmt.Println(string(value))
}

func getAll() []User {
	users:=make([]User, 2, 2)
	users[0] = User{UserName:"name1", Pwd:"100"}
	users[1] = User{UserName:"name2", Pwd:"100"}
	return users
}

func (this *MyController) GetUser() {
	// id := this.GetString(":id")
	// this.Ctx.WriteString(id)
	// fmt.Println(models.GetUser(id))

	// var myData myJsonData
	myData := getAll()

	// var jsonString string
	value, _ := json.Marshal(myData)
	this.Data["json"] = string(value)
	this.ServeJSON()
	fmt.Println(string(value))
	// if err != nil {
	// 	this.Data["json"] = string(value)
	// 	this.ServeJSON()
	// }

}

// func (this *MyController) SaveTestUser {
// 	SaveTestUser()
// }

func (this *MyController) GetAllUser() {
	myData := GetAllUser()
	value, _ := json.Marshal(myData)
	this.Data["json"] = string(value)
	this.ServeJSON()
}





