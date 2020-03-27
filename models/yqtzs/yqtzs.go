package yqtzs

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

//填报记录在进行销售后需要改进的地方，大数据输入还有迸发问题的解决（销售到100户）
type YQTZRecode struct {
	Id          int64  `orm:"pk;auto;column(recodeid)"` //自己增长的记录ID
	ShopID      int64  `orm:"column(shop_id)"`          //店铺的ID号
	Name        string //名字
	Sex         int    //性别
	Birth       string //出生日期
	UId         string //身份证号
	Address     string //住居地址现在
	Professsion string //职业
	Phone       string //本人手机号
	QSTel       string //亲属电话
	Temperature string //检测的体温
	Ip          string //访问的IP地址
	Lasted      int64  //时间
	TimeFmt     string //时间

	Wpfgaozhi         int    `orm:"column(pfgaozhi)"` //普法告知
	Wwhlxshi          int    //武汉旅行史
	Wwhjcfare         int    //武汉接触史（发热）
	Wwhjchuxingdao    int    //武汉接触史（呼吸道）
	Wqtlxshi          int    //其他疫区旅行史
	Wqtjcfare         int    //其他疫区接触史（发热）
	Wqtjchuxingdao    int    //其他疫区接触史（呼吸道）
	Wjjxingfabing     int    //聚集性发病
	Wjjxinxinghuanzhe int    //新冠病人接触史
	WjSignaturePic    string `orm:"null;size(8192)"`
	//完整提交插入的信息处理 `orm:"type(json);null;size(8192)"`
	//jSignaturePic := this.GetString("jSignaturePic")
}

// func (this *YQTZRecode) TableName() string {
// 	return models.TableName("y_q_t_z_recode")
// }

// func init() {
// 	orm.RegisterModel(new(YQTZRecode))
// }
// From(models.TableName("y_q_t_z_recode") + " r").

func ListYQTZAll(condArr map[string]string) (num int64, err error, checkwork []YQTZRecode) {
	qb, _ := orm.NewQueryBuilder("mysql")
	qb.Select("r.recodeid", "r.name", "r.phone", "r.lasted", "r.temperature", "r.time_fmt").
		From("pms_y_q_t_z_recode" + " r").
		Where("r.shop_id=?")

	if condArr["date"] != "" {
		qb.And("FROM_UNIXTIME(r.lasted,'%Y-%m-%d')='" + condArr["date"] + "'")
	}
	if condArr["keyword"] != "" {
		qb.And("r.name='" + condArr["keyword"] + "'")
	}

	// qb.GroupBy("FROM_UNIXTIME(ck.created,'%Y-%m-%d')")
	// qb.OrderBy("ck.created").Desc()

	sql := qb.String()
	beego.Debug(sql)
	o := orm.NewOrm()

	var checkworks []YQTZRecode
	nums, errs := o.Raw(sql, condArr["shopid"]).QueryRows(&checkworks)
	return nums, errs, checkworks
}

func AddRecodeYQTZ(recode YQTZRecode) (rerr error, recodeid int64) {
	o := orm.NewOrm()
	pro := new(YQTZRecode)

	pro.ShopID = recode.ShopID
	pro.Name = recode.Name
	pro.Sex = recode.Sex
	pro.Birth = recode.Birth
	pro.UId = recode.UId
	pro.Address = recode.Address
	pro.Professsion = recode.Professsion
	pro.Phone = recode.Phone
	pro.QSTel = recode.QSTel
	pro.Temperature = recode.Temperature
	pro.Ip = recode.Ip
	pro.Lasted = recode.Lasted
	pro.TimeFmt = recode.TimeFmt

	pro.Wpfgaozhi = recode.Wpfgaozhi                 //pfgaozhi //普法告知
	pro.Wwhlxshi = recode.Wwhlxshi                   // whlxshi  //武汉旅行史
	pro.Wwhjcfare = recode.Wwhjcfare                 // whjcfare //武汉接触史（发热）
	pro.Wwhjchuxingdao = recode.Wwhjchuxingdao       // whjchuxingdao //武汉接触史（呼吸道）
	pro.Wqtlxshi = recode.Wqtlxshi                   // qtlxshi  //其他疫区旅行史
	pro.Wqtjcfare = recode.Wqtjcfare                 // qtjcfare //其他疫区接触史（发热）
	pro.Wqtjchuxingdao = recode.Wqtjchuxingdao       // qtjchuxingdao //其他疫区接触史（呼吸道）
	pro.Wjjxingfabing = recode.Wjjxingfabing         // jjxingfabing  //聚集性发病
	pro.Wjjxinxinghuanzhe = recode.Wjjxinxinghuanzhe // jjxinxinghuanzhe //新冠病人接触史

	pro.WjSignaturePic = recode.WjSignaturePic //签名图片
	//var err error
	proback, err := o.Insert(pro)
	beego.Debug(proback)
	return err, proback
}

func GetRecodeYQTZ(id int64) (rerr error, recode YQTZRecode) {
	o := orm.NewOrm()

	pro := YQTZRecode{Id: id}
	err := o.Read(&pro, "recodeid")
	if nil != err {
		return err, pro
	} else {
		return err, pro
	}
}
