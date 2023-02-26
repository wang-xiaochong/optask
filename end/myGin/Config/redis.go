package Config

type RedisConfig struct {
	Password     string
	RemoteIP     string
	RemotePort   string
	DialDatabase int
}

func GetRedisConfig() *RedisConfig {

	ret := &RedisConfig{
		RemoteIP:     "43.138.81.135",
		RemotePort:   "6379",
		DialDatabase: 1,
		Password:     "sdl@admin",
	}
	return ret
}
