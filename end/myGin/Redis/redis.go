package redis

import (
	redisConfig "Example/Config"
	"fmt"
	"time"

	"github.com/gomodule/redigo/redis"
)

var redisPool *redis.Pool

// Setup redis库初始化
func Setup() *redis.Pool {
	redisPool = &redis.Pool{
		MaxIdle:     3,
		MaxActive:   8,
		IdleTimeout: 240 * time.Second,

		Dial: func() (redis.Conn, error) {
			var redisConfig = redisConfig.GetRedisConfig()
			var redisString = fmt.Sprintf("%v:%v", redisConfig.RemoteIP, redisConfig.RemotePort)
			c, err := redis.Dial("tcp", redisString, redis.DialDatabase(redisConfig.DialDatabase), redis.DialPassword(redisConfig.Password)) //本地无密码连接
			// c, err := redis.Dial("tcp", "localhost:6379", redis.DialDatabase(1)) //本地无密码连接
			// c, err := redis.Dial("tcp", "82.156.109.119:6379", redis.DialDatabase(1), redis.DialPassword("sdl@admin"))
			if err != nil {
				// fmt.Println("Redis连接失败")
				return nil, err
			} else {
				// fmt.Println("Redis连接成功")
			}
			return c, err
		},
	}
	return redisPool
}

// GetRedisPool 获取库连接
func GetRedisPool() *redis.Pool {
	if redisPool == nil {
		redisPool = Setup()
	}
	return redisPool
}

// SetKey 设置键值
func SetKey(key string, value string) error {
	var Conn = GetRedisPool().Get()
	defer Conn.Close()
	_, err := Conn.Do("set", key, value, "ex", 24*60*60)

	return err

}

// GetKey 获取键值
func GetKey(key string) (ret string, err error) {
	var Conn = GetRedisPool().Get()
	defer Conn.Close()
	ret, err = redis.String(Conn.Do("get", key))
	return ret, err
}

// DelKey 删除键值
func DelKey(key string) (ret bool, err error) {
	var Conn = GetRedisPool().Get()
	defer Conn.Close()
	// ret, err = redis.String(Conn.Do("del", key))
	ret, err = redis.Bool(Conn.Do("del", key))
	if err != nil {
		fmt.Println("err:", err)
	}
	return ret, err
}
