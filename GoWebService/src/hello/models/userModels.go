package models

import (
"fmt"
"strings"
)


const userNameKey = "userName"
const pwdKey = "pwdKey"


type User struct {
	UserName string 
	Pwd string 
}

func getLink() (error, *RedisClient) {
	err, redisClient := GetRedisClient("127.0.0.1:6379")
	if  err != nil {
		fmt.Println(err)
		return err, nil
	}
	return nil, redisClient
}

func SaveUser(user User) bool{
	_, redisClient := getLink()
	if redisClient == nil {
		fmt.Println("redisClient is nill")
		return false
	}

	userMap := make(map[string]string)
	userMap[userNameKey] = user.UserName
	userMap[pwdKey]= user.Pwd
	userKey := user.UserName
	err := redisClient.HMSet(userKey, userMap)
	if err!=nil {
		fmt.Println(err)
		return false
	}
	return true
}

func SaveTestUser() bool{
	_, redisClient := getLink()
	if redisClient == nil {
		fmt.Println("redisClient is nill")
		return false
	}

	// userMap01 := make(map[string]string)
	// userMap01[userNameKey] = "User01"
	// userMap01[pwdKey] = "Pwd01"

	// userMap02 := make(map[string]string)
	// userMap02[userNameKey] = "User02"
	// userMap02[pwdKey] = "Pwd02"

	// userMaps := make(map[string]map[string]string)
	// userMaps[userMap01[userNameKey]] = userMap01
	// userMaps[userMap02[userNameKey]] = userMap02

	// err := redisClient.HMSet("UserMapId", userMaps)
	// if err!=nil {
	// 	fmt.Println(err)
	// 	return false
	// }
	return true
}

func ValidateUser(user User) bool {
	_, redisClient := getLink()
	if redisClient == nil {
		fmt.Println("redisClient is nill")
		return false
	}
	userKey := user.UserName
	values, err := redisClient.HMGet(userKey, userNameKey, pwdKey)
	if err != nil {
		fmt.Println(err)
		return false
	}

	if strings.EqualFold(values[0].(string), user.Pwd) {
		return true
	}

	return false
}

func GetUser(id string) string {
	_, redisClient := getLink()
	if redisClient == nil {
		fmt.Println("redisClient is nill")
		return "failed"
	}

	values, err := redisClient.HMGet(id, pwdKey)
	if err != nil {
		fmt.Println(err)
		return "failed"
	}

	if values == nil || values[0] == nil {
		fmt.Println("value is nil")
		return "failed"
	} 

	// fmt.Println(id)
	fmt.Println(values[0].(string))




	return values[0].(string)
}

func GetAllUser() []User {
	// _, redisClient := getLink()
	// if redisClient == nil {
	// 	fmt.Println("redisClient is nill")
	// 	return nil
	// }

	// values, err := redisClient.HMGet(id)
	// if err != nil {
	// 	fmt.Println(err)
	// 	return nil
	// }

	// if values == nil || values[0] == nil {
	// 	fmt.Println("value is nil")
	// 	return nil
	// } 

	// // fmt.Println(id)
	// // fmt.Println(values[0].(string))

	// ms:=make([]User, len(values), len(values))
	// for i := 0; i < count; i++ {
	//  	ms[i] = values[i]
	// }

	// return ms
	return nil
}





