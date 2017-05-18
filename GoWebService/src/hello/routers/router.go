package routers

import (
	"hello/controllers"
	"github.com/astaxie/beego"
	// "fmt"
)

func init() {
    beego.Router("/", &controllers.MainController{})
    beego.Router("/getUser", &controllers.MyController{})
    // beego.Router("/getUser/:id", &controllers.MyController{}, "get:GetUser")
    beego.Router("/getAllUser", &controllers.MyController{}, "get:GetAllUser")
    // beego.Router("/save", &controllers.MyController{}, "get:SaveTestUser")
}
