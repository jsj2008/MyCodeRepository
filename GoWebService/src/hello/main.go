// package main

// import (
// 	_ "hello/routers"
// 	"github.com/astaxie/beego"
// )

// func main() {
// 	beego.Run()
// }

package main

import (
	//_ "hello/routers"
	//"github.com/garyburd/redigo/redis"
	// "github.com/astaxie/beego"
	"fmt"
	//"packageName"
	// "hello/models"
	"time"
	// ""
	//"reflect"
	// "encoding/json"

)

//var (
//	// 定义常量
//	RedisClient     *redis.Pool
//	REDIS_HOST string
//	REDIS_DB   int
//)

//var pool = newPoll()
//
//func newPoll() *redis.Pool {
//	return &redis.Pool {
//		MaxIdle: 80,
//		MaxActive: 12000,
//		Dial: func() (redis.Conn, error) {
//			return redis.Dial("tcp", "127.0.0.1:6379")
//			},
//		}
//	}
//
//	func test() {
//		conn := pool.Get()
//		defer conn.Close()
//
//		pong, _ := redis.String(conn.Do("PING"))
//		fmt.Println(pong)
//	}
//
//
//
//	type MyStruct struct {
//		Name string
//	}
//
//	func (s *MyStruct) getName() string{
//		return s.Name
//	}
//
//	func sum(a []int, c chan int) {
//		total := 0
//		for _, v := range a {
//			total += v
//		}
//    c <- total  // send total to c
//}
//
//func prin(ch chan int, index int) {
//	fmt.Println("pre",index)
//	// fmt.Println(int64(index));
//	ch <- index
//	// fmt.Println(index);
//	fmt.Println("after",index)
//}
//
//var (
//	mySaticValue chan string
//)
//
//func newUniqueIDService() <-chan string {
//	if mySaticValue == nil {
//		mySaticValue = make(chan string)
//	}
//
//	go func() {
//		var counter int64 = 0
//		for {
//			mySaticValue <- fmt.Sprintf("%x", counter)
//			counter += 1
//		}
//		}()
//		return mySaticValue
//	}
//	func trace(s string) { fmt.Println("entering:", s) }
//	func untrace(s string) { fmt.Println("leaving:", s) }
//	func a() {
//		trace("a")
//		defer untrace("a")
//		fmt.Println("in a")
//	}
//
//	func b() {
//		trace("b")
//		defer untrace("b")
//		fmt.Println("in b")
//		a()
//	}
//
//	func nameChange(m *myPackage.M) {
//		m.Name = "changed"
//	}
//
//	//func myMainFunc() {
//	//	fmt.Println("1")
//	//}
//
//	type humen struct {}
//
//	func (h *humen)say() {
//		fmt.Println("saying")
//	}
//
//	type Men interface {
//		say()
//	}
//
//	func getInterface(arr interface{}) []interface{} {
//		v := reflect.ValueOf(arr)
//		if v.Kind() != reflect.Slice {
//			panic("toslice arr not slice")
//		}
//		l := v.Len()
//		ret := make([]interface{}, l)
//		for i := 0; i < l; i++ {
//			ret[i] = v.Index(i).Interface()
//		}
//		return ret
//	}
//
//	func getChange(a []interface{}) interface{} {
//		return a
//	}
//
//	type myStruct struct {
//		Name string
//		A int
//		age int
//	}
//
//func changevalue(m myStruct) {
//	m.Name = "change"
//}
//
//func getStructs() []myStruct {
//	// ms:=[3]myStruct{}
//	ms:=make([]myStruct, 10, 10 )
//	ms[0] = myStruct{Name:"name1", A:1}
//	ms[1] = myStruct{Name:"name2", A:2}
//return ms
//}

var c = make(chan int, 3)

func f() {
	fmt.Println("hello")
	c <- 0
	fmt.Println("world")
}

func main() {
	for i := 0; i < 10; i++ {
		go f()
	}
	time.Sleep(1 * time.Second)

	for i := 0; i < 10; i++ {
		<-c
	}

	time.Sleep(1 * time.Second)

	fmt.Println("end")
	// ms:=[]int {}
	// ms:=make([]int, 10, 10)

	// 		var ms1 []int
	// 		ms2 := []int{1, 2}
	// 		ms1 = ms2
	// 		ms2[0] = 0

	// fmt.Println(reflect.TypeOf(ms1))
	// fmt.Println(ms1)

	// fmt.Println(reflect.TypeOf(ms2))
	// fmt.Println(ms2)

	// slice := []int{10, 20, 30}
	// slice := make([]int, 3, 3)
	// slice[0] = 10
	// fmt.Println(slice[0])
	// fmt.Println(slice[1])
	// fmt.Println(slice[2])
	// newSlice := append(slice, 40)
	// slice[0] = 20
	// fmt.Println(slice[0])
	// fmt.Println(slice[1])
	// fmt.Println(slice[2])
	// fmt.Println(newSlice[0])
	// fmt.Println(newSlice[1])
	// fmt.Println(newSlice[2])
	// fmt.Println(cap(newSlice))


	// ms:=make([]myStruct, 10, 10)
	// 		ms:=getStructs()

	// value, _ := json.Marshal(ms)
	// fmt.Println(string(value))

	// // changevalue(m)
	// // fmt.Println(m.Name)

	// value , _  := json.Marshal(m)
	// fmt.Println(string(value))
	// fmt.Println(m)


	// var redisClient RedisClient
	// err, redisClient := models.GetRedisClient("127.0.0.1:6379")
	// if  err != nil {
	// 	fmt.Println(err)
	// }
	// myMap := make(map[string]string)
	// myMap["userName"] = "nameA"
	// myMap["password"] = "pwdA"

	// // fmt.Println(myMap)

	// if err := redisClient.HMSet("UserA", myMap); err != nil {
	// 	fmt.Println(err)
	// }

	// if value, err := redisClient.HMGet("UserA", "userName", "password"); err!=nil {
	// 	fmt.Println(err)
	// } else {
	// 	fmt.Println(reflect.TypeOf(value))
	// }
	// beego.Run()


	// myMainFunc()

	// beego.Run("127.0.0.1:5555")


	// m := &myPackage.M{Name: "111"}
	// nameChange(m)
	// // m.Name = "123"
	// myPackage.P("13")
	// m.P()


	// b()
	// var v int
	// for i := 0; i < 5; i++ {
	//     v = 1
	//     fmt.Println(v)
	//     v = 5
	// }

	// var myValue int
	// myValue = 1

	// if myValue {
	// 	fmt.Println("yes")
	// } else {
	// 	fmt.Println("no")
	// }

	// 	fmt.Println("\u00FF")
	// myPackage.P()

	// id := newUniqueIDService()
	// for i := 5; i < 10; i++ {
	// 	fmt.Println(<-id)
	// }

	// id2 := newUniqueIDService()
	// for i := 5; i < 10; i++ {
	// 	fmt.Println(<-id2)
	// }
}

// func main() {

// 	// a := []int{7, 2, 8, -9, 4, 0}
//  //    c := make(chan int)
//  //    go sum(a[:len(a)/2], c)
//  //    go sum(a[len(a)/2:], c)
//  //    x, y := <-c, <-c  // receive from c
//  //    fmt.Println(x, y, x + y)

// 	// me := MyStruct{}
// 	// me.Name = "333"
// 	// fmt.Println(me.getName())
// 	chs := make([]chan int, 10)
// 	// ch := make(chan int)

// 	for i := 0; i < 10; i++ {
// 		chs[i] = make(chan int)
// 		go prin(chs[i], i)
// 	}

// // <- chs[1]

// 	for index, ch := range(chs) {
// 	// fmt.Println(index)
// 		// fmt.Println("1234")
// 		fmt.Println(index, <- ch)
// 	// <- ch
// 	}

// 	fmt.Println("end")

// 	time.Sleep(1)
// 	fmt.Println("sleep end")

// 	// test();

// 	// 从配置文件获取redis的ip以及db
// // 	REDIS_HOST = beego.AppConfig.String("redis.host")
// // 	REDIS_DB, _ = beego.AppConfig.Int("redis.db")

// // 	REDIS_HOST = "127.0.0.1:6379"
// // 	REDIS_DB = 1

// // 	fmt.Println("123")
// // 	fmt.Println(REDIS_HOST)
// // 	fmt.Println(REDIS_DB)
// // 	// REDIS_HOST = 6379
// // 	// REDIS_DB = redis
// // 	// 建立连接池

// // 	fmt.Println("1")

// // 	rs, err := redis.Dial("tcp", REDIS_HOST)
// // // 操作完后自动关闭

// // 	fmt.Println("2")
// // 	defer rs.Close()
// // // 若连接出错，则打印错误信息，返回
// // 	if err != nil {
// // 		fmt.Println(err)
// // 		fmt.Println("redis connect error")
// // 		return
// // 	}
// // 	fmt.Println("success")
// // // 选择db
// // 	rs.Do("SELECT", REDIS_DB)

// // 	key := "aaa"
// // 	value := "a"
// // // 操作redis时调用Do方法，第一个参数传入操作名称（字符串），然后根据不同操作传入key、value、数字等
// // // 返回2个参数，第一个为操作标识，成功则为1，失败则为0；第二个为错误信息
// // 	n, err := rs.Do("SETNX", key, value)
// // // 若操作失败则返回
// // 	if err != nil {
// // 		fmt.Println(err)
// // 		return
// // 	}
// // // 返回的n的类型是int64的，所以得将1或0转换成为int64类型的再比较
// // 	if n == int64(1) {
// //     // 设置过期时间为24小时
// // 		n, _ := rs.Do("EXPIRE", key, 24*3600)
// // 		if n == int64(1) {
// // 			fmt.Println("success")
// // 		}
// // 	} else if n == int64(0) {
// // 		fmt.Println("the key has already existed")
// // 	}
// }


