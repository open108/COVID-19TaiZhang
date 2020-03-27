package knowledges

import (
	"fmt"
	"opms/controllers"
	. "opms/models/knowledges"
	. "opms/models/messages"
	"opms/utils"
)

type AddCommentController struct {
	controllers.BaseController
}

func (this *AddCommentController) Post() {
	knowid, _ := this.GetInt64("knowid")
	if knowid <= 0 {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "参数出错"}
		this.ServeJSON()
		return
	}
	content := this.GetString("comment")
	if "" == content {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "请填写评论内容"}
		this.ServeJSON()
		return
	}

	var err error
	var comment KnowledgesComment
	comment.Id = utils.SnowFlakeId()
	comment.Userid = this.BaseController.UserUserId
	comment.Knowid = knowid
	comment.Content = content

	err = AddKnowledgeComment(comment)

	if err == nil {
		//消息通知
		knowledge, _ := GetKnowledge(knowid)
		var msg Messages
		msg.Id = utils.SnowFlakeId()
		msg.Userid = this.BaseController.UserUserId
		msg.Touserid = knowledge.Userid
		msg.Type = 1
		msg.Subtype = 11
		msg.Title = knowledge.Title
		msg.Url = "/knowledge/" + fmt.Sprintf("%d", knowid)
		// 拦截消息提醒
		// AddMessages(msg)
		this.Data["json"] = map[string]interface{}{"code": 1, "message": "评价添加成功"}
	} else {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "添加失败"}
	}

	// this.Data["json"] = map[string]interface{}{"code": 1, "message": "评价添加成功"}

	this.ServeJSON()
}

type AjaxLaudController struct {
	controllers.BaseController
}

func (this *AjaxLaudController) Post() {
	knowid, _ := this.GetInt64("knowid")
	if knowid <= 0 {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "参数出错"}
		this.ServeJSON()
		return
	}

	laudexit, _ := GetKnowledgeLaud(knowid)
	if laudexit.Userid == this.BaseController.UserUserId {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "已经点过赞"}
		this.ServeJSON()
	}

	var err error
	var laud KnowledgesLaud
	laud.Id = utils.SnowFlakeId()
	laud.Userid = this.BaseController.UserUserId
	laud.Knowid = knowid

	err = AddKnowledgeLaud(laud)

	if err == nil {
		//消息通知
		knowledge, _ := GetKnowledge(knowid)
		var msg Messages
		msg.Id = utils.SnowFlakeId()
		msg.Userid = this.BaseController.UserUserId
		msg.Touserid = knowledge.Userid
		msg.Type = 2
		msg.Subtype = 21
		msg.Title = knowledge.Title
		msg.Url = "/knowledge/" + fmt.Sprintf("%d", knowid)
		AddMessages(msg)
		this.Data["json"] = map[string]interface{}{"code": 1, "message": "点赞成功"}
	} else {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "点赞失败"}
	}
	this.ServeJSON()
}
