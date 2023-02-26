package api

// API 模型
type API struct {
	ID          string `bson:"id"  json:"id"`
	Name        string `bson:"name" json:"name" form:"name"  binding:"required"`
	URL         string `bson:"url"  json:"url" form:"url" binding:"required"`
	Method      string `bson:"method" json:"method" form:"method" binding:"required"`
	IsValid     string `bson:"is_valid" json:"is_valid" form:"isValid" `
	Type        string `bson:"type" json:"type" form:"type" `
	Description string `bson:"description" json:"description" form:"description"`
}

// KEY 模型
type KEY struct {
	ID  string `bson:"id" json:"id"`
	Key string `bson:"key" json:"key" form:"key"`
}

// APIGroup 模型
type APIGroup struct {
	ID          string `json:"id"`
	Name        string `json:"name" binding:"required" form:"name"`
	Apis        []API  `json:"apis" form:"apis"`
	Description string `json:"description"  form:"description"`
}
