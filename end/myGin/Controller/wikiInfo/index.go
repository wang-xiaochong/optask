package wikiInfo

import (
	// database "Example/Database"
	// user "Example/Model/user"
	// redis "Example/Redis"
	// keys "Example/Redis/keys"
	wiki "Example/Model/wiki"
	utils "Example/Utils"
	res "Example/Utils/response"
	"fmt"

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

func GetWikiByID(context *gin.Context) {
	id := context.Query("id")
	w := wiki.WikiInfo{}
	wikis := w.GetWikiByID(id)
	if wikis != nil {
		res.Return(context, utils.SUCCESS, wikis)
	} else {
		res.Return(context, utils.ERROR, wikis)
	}

}

func UpdateContent(context *gin.Context) {
	// fmt.Println("context", context)
	// fmt.Println("context", context.Request.Body)
	w := wiki.WikiInfoUpdate{}
	err := context.Bind(&w)
	if err != nil {
		fmt.Println(err)
	}
	w.UpdateContent(w)
	res.Return(context, utils.SUCCESS, "")
	// if wikis != nil {
	// 	res.Return(context, utils.SUCCESS, "")
	// } else {
	// 	res.Return(context, utils.ERROR, "")
	// }
	// fmt.Println("update", l)

}
