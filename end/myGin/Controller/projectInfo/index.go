package projectinfo

import (
	project "Example/Model/project"
	utils "Example/Utils"
	res "Example/Utils/response"
	"fmt"

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
	name := context.Query("name")
	p := project.ProjectInfo{}
	project := p.GetProjectByID(name)
	if project != nil {
		res.Return(context, utils.SUCCESS, project)
	} else {
		res.Return(context, utils.ERROR, project)
	}

}

func AddProjectInfo(context *gin.Context) {

	p := project.ProjectAddInfo{}
	err := context.Bind(&p)
	if err != nil {
		fmt.Println(err)
	}

	p.AddProjectInfo(p, context)
	res.Return(context, utils.SUCCESS, "")
}

func UpdateProjectInfoByID(context *gin.Context) {
	u := project.ProjectUpdateInfo{}
	err := context.Bind(&u)
	if err != nil {
		fmt.Println(err)
	}
	u.UpdateUserInfoByID(u, context)
	res.Return(context, utils.SUCCESS, "")
}
