package roleInfo

import (
	role "Example/Model/role"
	utils "Example/Utils"
	res "Example/Utils/response"

	"github.com/gin-gonic/gin"
)

func GetAllRoles(context *gin.Context) {
	r := role.RoleInfo{}
	roles := r.GetAll()
	if roles != nil {
		res.Return(context, utils.SUCCESS, roles)
	} else {
		res.Return(context, utils.NONE_FOUND, roles)
	}

}
