package user

// Role 模型
type RoleInfo struct {
	Id          int    `json:"id" `
	Name        string `bson:"name"               json:"name" binding:"required" form:"name"`
	Apis        []int  `bson:"apis"               json:"apis" form:"apis"`
	Description string `bson:"description"        json:"description" form:"description"`
}
