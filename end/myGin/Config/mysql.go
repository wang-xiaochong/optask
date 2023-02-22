package Config

type MysqlConfig struct {
	Account    string
	Password   string
	RemoteIP   string
	RemotePort string
	Database   string
}

func GetMysqlConfig() *MysqlConfig {

	ret := &MysqlConfig{
		Account:    "xiaochong",
		Password:   "Lrb7MMY3AjKDGyGz",
		RemoteIP:   "43.138.81.135",
		RemotePort: "3306",
		Database:   "xiaochong",
	}
	return ret
}
