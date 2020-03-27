package yqtzs

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

//填报记录在进行销售后需要改进的地方，大数据输入还有迸发问题的解决（销售到100户）
type Clinics struct {
	ShopID   int64  `orm:"pk;auto;column(shopid)"` //店铺的ID号
	ShopName string //店铺名
	Name     string //负责人名字
	Sex      int    //负责人性别
	UId      string //负责人身份证号
	Address  string //店铺地址
	Phone1   string //联系手机号1
	Phone2   string //联系手机号2
	Ip       string //注册访问的IP地址
	Lasted   int64  //注册时间
	WShopPic string `orm:"null;type(text);size(4094304)"`
	//完整提交插入的信息处理 `orm:"type(json);null;size(8192)"`
	//jSignaturePic := this.GetString("jSignaturePic")
}

// func (this *Yqtzs) TableName() string {
// 	return models.TableName("yqtzs")
// }

// func init() {
// }

func AddClinics(recode Clinics) (rerr error, ShopID int64) {
	o := orm.NewOrm()
	pro := new(Clinics)

	pro.ShopName = recode.ShopName
	pro.Name = recode.Name
	pro.Sex = recode.Sex
	pro.UId = recode.UId
	pro.Address = recode.Address
	pro.Phone1 = recode.Phone1
	pro.Phone2 = recode.Phone2
	pro.Ip = recode.Ip
	pro.Lasted = recode.Lasted

	//var err error
	proback, err := o.Insert(pro)
	beego.Debug(proback)
	return err, proback
}

func GetClinics(id int64) (rerr error, recode Clinics) {
	o := orm.NewOrm()
	var pro Clinics
	pro.ShopID = id
	err := o.Read(&pro, "shopid")
	if nil != err {
		return err, pro
	} else {
		return err, pro
	}
}
