package yqtz

import (
	"opms/controllers"
	. "opms/models/yqtzs"
	"time"

	"github.com/astaxie/beego"
)

// type AddClinic struct {
// 	controllers.BaseController
// }

// func (this *AddClinic) Get() {

// 	var pro YQTZRecode
// 	var err error

// 	ShopUserID := this.Input().Get("ShopUserID")
// 	ShopName := this.Input().Get("ShopName")
// 	Time := this.Input().Get("Time")
// 	Name := this.Input().Get("Name")
// 	Tel := this.Input().Get("Tel")
// 	RecodeID := this.Input().Get("RecodeID")

// 	pro.Id, err = strconv.ParseInt(RecodeID, 10, 64)

// 	err, pro = GetRecodeYQTZ(pro.Id)
// 	if err != nil {

// 	}

// 	this.Data["pro"] = pro
// 	this.Data["Tel"] = Tel
// 	var itemperature float64
// 	itemperature, err = strconv.ParseFloat(pro.Temperature, 64)
// 	TemperatureClass := "springgreen"

// 	if 34.7 < itemperature && itemperature < 37.3 {
// 		TemperatureClass = "springgreen"
// 	} else {
// 		TemperatureClass = "red"
// 	}

// 	this.Data["TemperatureClass"] = TemperatureClass

// 	this.Data["Name"] = Name
// 	this.Data["Time"] = Time
// 	this.Data["ShopUserID"] = ShopUserID
// 	this.Data["ShopName"] = ShopName
// 	this.Data["ShopName"] = ShopName

// 	this.TplName = "yqtz/yqtzzs-success.tpl"
// }

//添加用户信息
type AddClinic struct {
	controllers.BaseController
}

// ?ShopUserID=2017072022
//疫情台账填报口
func (this *AddClinic) Get() {
	//修改成疫情问诊流行病学史参考问诊表
	var pro YQTZRecode
	var err error
	pro.ShopID, err = this.GetInt64("ShopUserID")
	if err != nil {
		pro.ShopID = 118
	}

	var recode Clinics
	recode.Name = "张孝维"
	// err, recode.ShopID = AddClinics(recode)

	condArr := make(map[string]string)
	condArr["status"] = "1"

	pro.Sex = 1
	pro.Temperature = "3"

	this.Data["pro"] = pro
	this.Data["ShopName"] = "金牛碧林诊所"
	this.Data["condArr"] = condArr

	this.TplName = "yqtz/yqtzzs-form.tpl"
}

func (this *AddClinic) Post() {
	//修改成新冠台账的服务系统
	//快速提交的处理
	submitType := this.GetString("subType")
	//ShopUserID := this.GetString("ShopUserID")

	var err error
	var recode YQTZRecode
	recode.ShopID, _ = this.GetInt64("ShopUserID")

	if submitType == "quicklyS" {
		//快速提交的处理
		recode.Name = this.GetString("myusername")
		id3 := this.GetString("id3")
		temperature := this.GetString("temperature")

		beego.Debug(id3, temperature)

	} else {
		//完整提交插入的信息处理 `orm:"type(json);null;size(8192)"`
		recode.WjSignaturePic = this.GetString("jSignaturePic")
		//beego.Debug(jSignaturePic)
		recode.Name = this.GetString("uname")
		// sex := this.GetString("sex")
		recode.Sex, _ = this.GetInt("sex")

		recode.Birth = this.GetString("birth")
		recode.UId = this.GetString("uID")
		recode.Address = this.GetString("uaddr")
		recode.Professsion = this.GetString("uprofession")
		recode.Phone = this.GetString("utelphone")
		recode.QSTel = this.GetString("uqtelphone")
		recode.Ip = this.Ctx.Input.IP()
		recode.Temperature = this.GetString("temperature")
		recode.Lasted = time.Now().Unix()

		// //问卷表处理
		recode.Wpfgaozhi, _ = this.GetInt("pfgaozhi")                 //pfgaozhi //普法告知
		recode.Wwhlxshi, _ = this.GetInt("whlxshi")                   // whlxshi  //武汉旅行史
		recode.Wwhjcfare, _ = this.GetInt("whjcfare")                 // whjcfare //武汉接触史（发热）
		recode.Wwhjchuxingdao, _ = this.GetInt("whjchuxingdao")       // whjchuxingdao //武汉接触史（呼吸道）
		recode.Wqtlxshi, _ = this.GetInt("qtlxshi")                   // qtlxshi  //其他疫区旅行史
		recode.Wqtjcfare, _ = this.GetInt("qtjcfare")                 // qtjcfare //其他疫区接触史（发热）
		recode.Wqtjchuxingdao, _ = this.GetInt("qtjchuxingdao")       // qtjchuxingdao //其他疫区接触史（呼吸道）
		recode.Wjjxingfabing, _ = this.GetInt("jjxingfabing")         // jjxingfabing  //聚集性发病
		recode.Wjjxinxinghuanzhe, _ = this.GetInt("jjxinxinghuanzhe") // jjxinxinghuanzhe //新冠病人接触史

		err, recode.Id = AddRecodeYQTZ(recode)
		//基本提交的处理
		if err != nil {
			this.Data["json"] = map[string]interface{}{"code": 0, "message": "填报信息有错，请您查正后再试试！"}
		} else {
			//记录输入成功返回网页下一步操作
			t := time.Unix(int64(recode.Lasted), 0)
			date := t.Format("2006-01-02 15:04:05")

			this.Data["json"] = map[string]interface{}{"code": 1, "message": "问诊完成",
				"ShopUserID": recode.ShopID, "ShopName": "金牛碧林诊所", "Time": date, "Temperature": recode.Temperature,
				"Name": recode.Name, "Tel": recode.Phone, "RecodeID": recode.Id}
			this.ServeJSON()

		}

	}

	//雪花算法ID生成
	//	id := utils.SnowFlakeId()

}
