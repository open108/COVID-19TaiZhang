package users

import (
	"fmt"
	"opms/controllers"
	. "opms/models/users"
	"opms/utils"
	"strconv"
	"strings"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/utils/pagination"
)

//用户管理
type ManageDepartmentController struct {
	controllers.BaseController
}

func (this *ManageDepartmentController) Get() {
	//权限检测
	if !strings.Contains(this.GetSession("userPermission").(string), "department-manage") {
		this.Abort("401")
	}
	page, err := this.GetInt("p")
	status := this.GetString("status")
	keywords := this.GetString("keywords")
	if err != nil {
		page = 1
	}

	offset, err1 := beego.AppConfig.Int("pageoffset")
	if err1 != nil {
		offset = 15
	}

	condArr := make(map[string]string)
	condArr["status"] = status
	condArr["keywords"] = keywords

	countDepart := CountDeparts(condArr)

	paginator := pagination.SetPaginator(this.Ctx, offset, countDepart)
	_, _, depart := ListDeparts(condArr, page, offset)

	this.Data["paginator"] = paginator
	this.Data["condArr"] = condArr
	this.Data["depart"] = depart
	this.Data["countDepart"] = countDepart

	this.TplName = "users/department.tpl"
}

//部门状态
type AjaxStatusDepartmentController struct {
	controllers.BaseController
}

func (this *AjaxStatusDepartmentController) Post() {
	//权限检测
	if !strings.Contains(this.GetSession("userPermission").(string), "department-edit") {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "无权设置"}
		this.ServeJSON()
		return
	}
	id, _ := this.GetInt64("id")
	if id <= 0 {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "请选择部门"}
		this.ServeJSON()
		return
	}
	status, _ := this.GetInt("status")
	if status <= 0 || status >= 3 {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "请选择操作状态"}
		this.ServeJSON()
		return
	}

	err := ChangeDepartStatus(id, status)

	if err == nil {
		this.Data["json"] = map[string]interface{}{"code": 1, "message": "部门状态更改成功"}
	} else {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "部门状态更改失败"}
	}
	this.ServeJSON()
}

//部门添加
type AddDepartmentController struct {
	controllers.BaseController
}

func (this *AddDepartmentController) Get() {
	//权限检测
	if !strings.Contains(this.GetSession("userPermission").(string), "department-add") {
		this.Abort("401")
	}
	this.TplName = "users/department-form.tpl"
}

func (this *AddDepartmentController) Post() {
	//权限检测
	if !strings.Contains(this.GetSession("userPermission").(string), "department-add") {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "无权设置"}
		this.ServeJSON()
		return
	}
	name := this.GetString("name")
	if "" == name {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "请填写名称"}
		this.ServeJSON()
		return
	}
	desc := this.GetString("desc")

	var dep Departs
	dep.Id = utils.SnowFlakeId()
	dep.Name = name
	dep.Desc = desc
	err := AddDeparts(dep)

	if err == nil {
		this.Data["json"] = map[string]interface{}{"code": 1, "message": "部门添加成功"}
	} else {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "部门添加失败"}
	}
	this.ServeJSON()
}

//部门编辑
type EditDepartmentController struct {
	controllers.BaseController
}

func (this *EditDepartmentController) Get() {
	//权限检测
	if !strings.Contains(this.GetSession("userPermission").(string), "department-edit") {
		this.Abort("401")
	}
	idstr := this.Ctx.Input.Param(":id")
	id, err := strconv.Atoi(idstr)
	dep, err := GetDeparts(int64(id))
	if err != nil {
		this.Abort("404")
	}
	this.Data["dep"] = dep
	this.TplName = "users/department-form.tpl"
}

func (this *EditDepartmentController) Post() {
	//权限检测
	if !strings.Contains(this.GetSession("userPermission").(string), "department-edit") {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "无权设置"}
		this.ServeJSON()
		return
	}
	id, _ := this.GetInt64("id")
	if id <= 0 {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "参数出错"}
		this.ServeJSON()
		return
	}
	_, err := GetDeparts(id)
	if err != nil {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "部门不存在"}
		this.ServeJSON()
		return
	}

	name := this.GetString("name")
	if "" == name {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "请填写名称"}
		this.ServeJSON()
		return
	}
	desc := this.GetString("desc")

	var dep Departs
	dep.Name = name
	dep.Desc = desc

	err = UpdateDeparts(id, dep)

	if err == nil {
		this.Data["json"] = map[string]interface{}{"code": 1, "message": "信息修改成功", "id": fmt.Sprintf("%d", id)}
	} else {
		this.Data["json"] = map[string]interface{}{"code": 0, "message": "信息修改失败"}
	}
	this.ServeJSON()
}
