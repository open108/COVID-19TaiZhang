package yqtz

import (
	"opms/controllers"
	. "opms/models/yqtzs"
	"strconv"
	"time"

	"github.com/astaxie/beego"
)

type AddRecodeSuccess struct {
	controllers.BaseController
}

func (this *AddRecodeSuccess) Get() {

	var pro YQTZRecode
	var err error

	RecodeID := this.Input().Get("RecodeID")

	pro.Id, err = strconv.ParseInt(RecodeID, 10, 64)
	err, pro = GetRecodeYQTZ(pro.Id)
	if err != nil {

	}

	var clinic Clinics
	err, clinic = GetClinics(pro.ShopID)
	if err != nil {

	}

	this.Data["pro"] = pro

	//温度不正常的处理
	var itemperature float64
	itemperature, err = strconv.ParseFloat(pro.Temperature, 64)
	TemperatureClass := "springgreen"

	if 34.7 < itemperature && itemperature < 37.3 {
		TemperatureClass = "springgreen"
	} else {
		TemperatureClass = "red"
	}

	this.Data["TemperatureClass"] = TemperatureClass

	this.Data["ShopName"] = clinic.ShopName

	this.TplName = "yqtz/yqtzzs-success.tpl"
}

//添加用户信息
type AddRecode struct {
	controllers.BaseController
}

// ?ShopUserID=2017072022
//疫情台账填报口
func (this *AddRecode) Get() {
	//修改成疫情问诊流行病学史参考问诊表
	var pro YQTZRecode
	//var err error
	ShopID, err := this.GetInt64("ShopUserID")

	//赋默认值
	pro.Sex = 1
	pro.Temperature = "3"

	if err != nil {
		pro.ShopID = 9
	} else {
		pro.ShopID = ShopID
	}
	//识别是否填充
	RecodeID := this.GetString("ReocdeID")
	if RecodeID != "" {
		pro.Id, err = strconv.ParseInt(RecodeID, 10, 64)
		if err == nil {
			err, pro = GetRecodeYQTZ(pro.Id)
			if err == nil {
				//查询库中的数据补全
				Temperature := this.GetString("Temperature")
				pro.Temperature = Temperature

				pro.WjSignaturePic = ""
				pro.Ip = ""
			}
		} else {

		}
		pro.ShopID = ShopID
	}

	//动态获取诊所名字
	var clinic Clinics
	err, clinic = GetClinics(pro.ShopID)
	if err != nil {
		pro.ShopID = 9
		_, clinic = GetClinics(pro.ShopID)
	}

	this.Data["pro"] = pro
	this.Data["ShopName"] = clinic.ShopName
	this.TplName = "yqtz/yqtzzs-form.tpl"
}

func (this *AddRecode) Post() {
	//修改成新冠台账的服务系统
	//快速提交的处理
	submitType := this.GetString("subType")
	//ShopUserID := this.GetString("ShopUserID")

	var err error
	var recode YQTZRecode
	recode.ShopID, _ = this.GetInt64("ShopUserID")
	// var clinic Clinics
	// err, clinic = GetClinics(pro.ShopID)
	// if err != nil {
	// 	pro.ShopID = 9
	// 	_, clinic = GetClinics(pro.ShopID)
	// }

	if submitType == "quicklyS" {
		var pro YQTZRecode

		//快速提交的处理
		pro.Name = this.GetString("uname")
		pro.UId = this.GetString("uID")
		pro.Phone = this.GetString("utelphone")

		Temperature := this.GetString("temperature")

		uid, err := GetRecodeYQTZID(pro)
		if err == nil && uid > 0 {
			this.Data["json"] = map[string]interface{}{"code": 1, "message": "您的信息自动完成填充，请核查信息并且，签字确认！",
				"ShopUserID": recode.ShopID, "Temperature": Temperature, "ReocdeID": uid}

		} else {
			this.Data["json"] = map[string]interface{}{"code": 0, "message": "您没有填报过，请填报完整信息！"}
		}
		beego.Debug(recode, pro, uid, err)
		this.ServeJSON()
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
		recode.TimeFmt = time.Unix(int64(recode.Lasted), 0).Format("2006-01-02 15:04")

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
			// t := time.Unix(int64(recode.Lasted), 0)
			// date := t.Format("2006-01-02 15:04:05")

			this.Data["json"] = map[string]interface{}{"code": 1, "message": "问诊完成",
				"RecodeID": recode.Id}
			this.ServeJSON()

		}

	}

	//雪花算法ID生成
	//	id := utils.SnowFlakeId()

}
