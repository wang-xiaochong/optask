package wikiInfo

import (
	// database "Example/Database"
	// user "Example/Model/user"
	// redis "Example/Redis"
	// keys "Example/Redis/keys"
	wiki "Example/Model/wiki"
	utils "Example/Utils"
	res "Example/Utils/response"

	// "encoding/json"
	// "fmt"
	// "strconv"

	"github.com/gin-gonic/gin"
)

func GetAllWikis(context *gin.Context) {
	w := wiki.WikiInfo{}
	wikis := w.GetAll()
	// for i := 0; i < len(tasks); i++ {
	// 	 tasksNew[i] := new(task.TaskInfo)
	// 	//  getProjectNameByID(tasks[i].Project)
	// }

	if wikis != nil {
		res.Return(context, utils.SUCCESS, wikis)
	} else {
		res.Return(context, utils.ERROR, wikis)
	}
}
