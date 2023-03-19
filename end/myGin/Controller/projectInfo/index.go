package projectinfo

import (
	project "Example/Model/project"
	utils "Example/Utils"
	res "Example/Utils/response"

	"github.com/gin-gonic/gin"
)

func GetAllProjects(context *gin.Context) {
	p := project.ProjectInfo{}
	projects := p.GetAll()
	if projects != nil {
		res.Return(context, utils.SUCCESS, projects)
	} else {
		res.Return(context, utils.ERROR, projects)
	}

}

func GetProjectByID(context *gin.Context) {
	id := context.Query("id")
	p := project.ProjectInfo{}
	project := p.GetProjectByID(id)
	if project != nil {
		res.Return(context, utils.SUCCESS, project)
	} else {
		res.Return(context, utils.ERROR, project)
	}

}
