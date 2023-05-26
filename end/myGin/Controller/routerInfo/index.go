package routerInfo

import (
	router "Example/Model/router"
	utils "Example/Utils"
	res "Example/Utils/response"

	"github.com/gin-gonic/gin"
)

func GetAllRouters(context *gin.Context) {
	r := router.RouterInfo{}
	routers := r.GetAll()
	if routers != nil {
		res.Return(context, utils.SUCCESS, routers)
	} else {
		res.Return(context, utils.NONE_FOUND, routers)
	}

}
