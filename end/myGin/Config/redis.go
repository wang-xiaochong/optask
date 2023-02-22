package Config

type RedisConfig struct {
	Password     string
	RemoteIP     string
	RemotePort   string
	DialDatabase int
}

func GetRedisConfig() *RedisConfig {

	ret := &RedisConfig{
		RemoteIP:     "localhost",
		RemotePort:   "6379",
		DialDatabase: 1,
	}
	return ret
}
