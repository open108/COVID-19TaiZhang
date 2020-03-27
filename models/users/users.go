package users

import (
	"fmt"
	"math/rand"
	"opms/models"
	. "opms/models/yqtzs"

	"opms/utils"
	"time"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

type Users struct {
	Id       int64         `orm:"pk;column(userid);"`
	Profile  *UsersProfile `orm:"rel(one);"`
	Username string        `orm:"unique"`
	Password string
	Avatar   string
	Status   int
}

type UsersProfile struct {
	//店铺和用户ID号
	Id     int64 `orm:"pk;column(userid);"`
	ShopID int64 `orm:"column(shopid)"` //店铺的ID号

	Username    string //用户名
	Realname    string //负责人名字
	Sex         int    //负责人性别
	Birth       string //负责人生日
	Email       string //负责人电子邮件
	Webchat     string //负责人Webchat账号
	Qq          string //负责人QQ
	Phone       string //负责人手机
	Tel         string //负责人电话
	Address     string //地址
	Emercontact string //紧急联系人
	Emerphone   string //紧急联系电话
	Departid    int64  //部门机构
	Positionid  int64  //职位
	Lognum      int    //访问次数统计
	Ip          string //最近的访问IP地址
	Lasted      int64  //最近的访问时间

	ShopName  string //店铺名
	Name      string //负责人名字
	UId       string //负责人身份证号
	ZsAddress string //店铺地址
	Phone1    string //联系手机号1
	Phone2    string //联系手机号2
	ReIp      string //注册访问的IP地址
	ReLasted  int64  //注册时间
}

func (this *Users) TableName() string {
	return models.TableName("users")
}

func init() {
	//orm.RegisterModel(new(Users), new(UsersProfile))
	orm.RegisterModel(new(Users))
	//orm.RegisterModelWithPrefix("pms_", new(Users))
	orm.RegisterModelWithPrefix("pms_", new(UsersProfile))

	orm.RegisterModelWithPrefix("pms_", new(YQTZRecode))
	orm.RegisterModelWithPrefix("pms_", new(Clinics))

}

//登录
func LoginUser(username, password string) (err error, user Users) {
	o := orm.NewOrm()
	qs := o.QueryTable(models.TableName("users"))
	cond := orm.NewCondition()

	cond = cond.And("username", username)
	pwdmd5 := utils.Md5(password)
	cond = cond.And("password", pwdmd5)
	cond = cond.And("status", 1)

	qs = qs.SetCond(cond)
	var users Users
	err = qs.Limit(1).One(&users, "userid", "username", "avatar")
	fmt.Println(err)
	if err == nil {
		o.Raw("UPDATE pms_users_profile SET lasted = ?,lognum=lognum+? WHERE userid = ?", time.Now().Unix(), 1, users.Id).Exec()
	}
	return err, users
}

//得到用户信息
func GetUser(id int64) (Users, error) {
	var user Users
	var err error
	o := orm.NewOrm()

	user = Users{Id: id}
	err = o.Read(&user)

	if err == orm.ErrNoRows {
		return user, nil
	}
	return user, err
}

func GetRealname(id int64) string {
	var err error
	var realname string

	err = utils.GetCache("GetRealname.id."+fmt.Sprintf("%d", id), &realname)
	if err != nil {
		cache_expire, _ := beego.AppConfig.Int("cache_expire")
		var user UsersProfile
		o := orm.NewOrm()
		o.QueryTable(models.TableName("users_profile")).Filter("userid", id).One(&user, "realname")
		realname = user.Realname
		utils.SetCache("GetRealname.id."+fmt.Sprintf("%d", id), realname, cache_expire)
	}
	return realname
}

func GetUserEmail(id int64) string {
	var err error
	var email string

	err = utils.GetCache("GetUserEmail.id."+fmt.Sprintf("%d", id), &email)
	if err != nil {
		cache_expire, _ := beego.AppConfig.Int("cache_expire")
		var user UsersProfile
		o := orm.NewOrm()
		o.QueryTable(models.TableName("users_profile")).Filter("userid", id).One(&user, "email")
		email = user.Email
		utils.SetCache("GetUserEmail.id."+fmt.Sprintf("%d", id), email, cache_expire)
	}
	return email
}

func GetAvatarUserid(id int64) string {
	var err error
	var avatar string

	err = utils.GetCache("GetAvatarUserid.id."+fmt.Sprintf("%d", id), &avatar)
	if err != nil {
		cache_expire, _ := beego.AppConfig.Int("cache_expire")
		var user Users
		o := orm.NewOrm()
		o.QueryTable(models.TableName("users")).Filter("userid", id).One(&user, "avatar")
		avatar = user.Avatar
		utils.SetCache("GetAvatarUserid.id."+fmt.Sprintf("%d", id), avatar, cache_expire)
	}
	if "" == avatar {
		return fmt.Sprintf("/static/img/avatar/%d.jpg", rand.Intn(5))
	}
	return avatar
}

func GetPositionsNameForUserid(id int64) string {
	var err error
	var position string

	err = utils.GetCache("GetPositionsNameForUserid.id."+fmt.Sprintf("%d", id), &position)
	if err != nil {
		cache_expire, _ := beego.AppConfig.Int("cache_expire")
		var user UsersProfile
		o := orm.NewOrm()
		o.QueryTable(models.TableName("users_profile")).Filter("userid", id).One(&user, "positionid")

		position = GetPositionsName(user.Positionid)
		utils.SetCache("GetPositionsNameForUserid.id."+fmt.Sprintf("%d", id), position, cache_expire)
	}
	return position
}

func GetDepartmentsNameForUserid(id int64) string {
	var err error
	var depart string

	err = utils.GetCache("GetDepartmentsNameForUserid.id."+fmt.Sprintf("%d", id), &depart)
	if err != nil {
		cache_expire, _ := beego.AppConfig.Int("cache_expire")
		var user UsersProfile
		o := orm.NewOrm()
		o.QueryTable(models.TableName("users_profile")).Filter("userid", id).One(&user, "departid")

		depart = GetDepartsName(user.Departid)
		utils.SetCache("GetDepartmentsNameForUserid.id."+fmt.Sprintf("%d", id), depart, cache_expire)
	}
	return depart
}

//得到用户详情信息
func GetProfile(id int64) (UsersProfile, error) {
	var pro UsersProfile
	var err error
	o := orm.NewOrm()

	pro = UsersProfile{Id: id}
	err = o.Read(&pro)

	if err == orm.ErrNoRows {
		return pro, nil
	}
	return pro, err
}

//修改个人信息
func UpdateProfile(id int64, updPro UsersProfile) error {
	var pro UsersProfile
	o := orm.NewOrm()
	err := o.Begin()

	//设置关键字
	pro = UsersProfile{Id: id}

	err = o.Read(&pro)
	if err != nil {
		_ = o.Rollback()
		return err
	}

	pro.Realname = updPro.Realname
	pro.Sex = updPro.Sex
	pro.Birth = updPro.Birth
	pro.Email = updPro.Email
	pro.Webchat = updPro.Webchat
	pro.Qq = updPro.Qq
	pro.Phone = updPro.Phone
	pro.Tel = updPro.Tel
	pro.Address = updPro.Address
	pro.Emercontact = updPro.Emercontact
	pro.Emerphone = updPro.Emerphone
	pro.Departid = updPro.Departid
	pro.Positionid = updPro.Positionid
	pro.Lognum = 1
	pro.Ip = updPro.Ip
	pro.Lasted = time.Now().Unix()

	//店铺信息
	// pro.ShopID = recode.ShopID

	pro.ShopName = updPro.ShopName
	pro.Name = updPro.Name
	pro.UId = updPro.UId
	pro.ZsAddress = updPro.ZsAddress
	pro.Phone1 = updPro.Phone1
	pro.Phone2 = updPro.Phone2

	_, err = o.Update(&pro)

	if err != nil {
		_ = o.Rollback()
		return err
	}
	var recode Clinics
	recode = Clinics{ShopID: pro.ShopID}

	err = o.Read(&recode)
	if err != nil {
		_ = o.Rollback()
		return err
	}

	recode.ShopName = updPro.ShopName
	recode.Name = updPro.Name
	recode.Sex = updPro.Sex
	recode.UId = updPro.UId
	recode.Address = updPro.ZsAddress
	recode.Phone1 = updPro.Phone
	recode.Phone2 = updPro.Phone1
	recode.Ip = updPro.ReIp
	recode.Lasted = updPro.Lasted
	_, err = o.Update(&recode)
	if err != nil {
		_ = o.Rollback()
		return err
	}

	_ = o.Commit()
	return err
}

//修改用户
func UpdateUser(id int64, updUser Users) error {
	var user Users
	o := orm.NewOrm()
	user = Users{Id: id}

	_, err := o.Update(&user, "username")
	user.Password = utils.Md5(updUser.Password)
	return err

	// user.Username = updUser.Username
	// if updUser.Password != "" {
	// 	user.Password = utils.Md5(updUser.Password)
	// 	_, err := o.Update(&user, "username", "password")
	// 	return err
	// } else {
	// 	_, err := o.Update(&user, "username")
	// 	return err
	// }
}

//修改密码
func UpdatePassword(id int64, oldPawd string, newPwd string) error {
	o := orm.NewOrm()

	user := Users{Id: id}
	err := o.Read(&user)
	if nil != err {
		return err
	} else {
		if user.Password == utils.Md5(oldPawd) {
			user.Password = utils.Md5(newPwd)
			_, err := o.Update(&user)
			return err
		} else {
			return fmt.Errorf("验证出错")
		}
	}
}

//添加个人信息
func AddProfile(updPro UsersProfile) error {
	o := orm.NewOrm()
	pro := new(UsersProfile)

	pro.Id = updPro.Id
	pro.Realname = updPro.Realname
	pro.Sex = updPro.Sex
	pro.Birth = updPro.Birth
	pro.Email = updPro.Email
	pro.Webchat = updPro.Webchat
	pro.Qq = updPro.Qq
	pro.Phone = updPro.Phone
	pro.Tel = updPro.Tel
	pro.Address = updPro.Address
	pro.Emercontact = updPro.Emercontact
	pro.Emerphone = updPro.Emerphone
	pro.Departid = updPro.Departid
	pro.Positionid = updPro.Positionid
	pro.Lognum = 1
	pro.Ip = updPro.Ip
	pro.Lasted = time.Now().Unix()
	_, err := o.Insert(pro)
	return err
}

//添加用户
func AddUserProfile(updUser Users, updPro UsersProfile) error {
	o := orm.NewOrm()
	o.Using("default")
	user := new(Users)

	//存储过程开始
	err := o.Begin()
	//需要修改成存储过程
	//添加诊所信息
	var recode Clinics
	recode.ShopName = updPro.ShopName
	recode.Name = updPro.Name
	recode.Sex = updPro.Sex
	recode.UId = updPro.UId
	recode.Address = updPro.ZsAddress
	recode.Phone1 = updPro.Phone
	recode.Phone2 = updPro.Phone1
	recode.Ip = updPro.ReIp
	recode.Lasted = updPro.Lasted
	//存储过程中不可以调用函数
	//err, recode.ShopID = AddClinics(recode)

	prorecode := new(Clinics)

	prorecode.ShopName = recode.ShopName
	prorecode.Name = recode.Name
	prorecode.Sex = recode.Sex
	prorecode.UId = recode.UId
	prorecode.Address = recode.Address
	prorecode.Phone1 = recode.Phone1
	prorecode.Phone2 = recode.Phone2
	prorecode.Ip = recode.Ip
	prorecode.Lasted = recode.Lasted

	//var err error
	recode.ShopID, err = o.Insert(prorecode)

	if err != nil {
		_ = o.Rollback()
		return err
	}
	pro := new(UsersProfile)
	pro.Id = updPro.Id
	pro.Username = updUser.Username
	pro.Realname = updPro.Realname
	pro.Sex = updPro.Sex
	pro.Birth = updPro.Birth
	pro.Email = updPro.Email
	pro.Webchat = updPro.Webchat
	pro.Qq = updPro.Qq
	pro.Phone = updPro.Phone
	pro.Tel = updPro.Tel
	pro.Address = updPro.Address
	pro.Emercontact = updPro.Emercontact
	pro.Emerphone = updPro.Emerphone
	pro.Departid = updPro.Departid
	pro.Positionid = updPro.Positionid
	pro.Lognum = 1
	pro.Ip = updPro.Ip
	pro.Lasted = time.Now().Unix()

	//店铺信息
	pro.ShopID = recode.ShopID

	pro.ShopName = updPro.ShopName
	pro.Name = updPro.Name
	pro.UId = updPro.UId
	pro.ZsAddress = updPro.ZsAddress
	pro.Phone1 = updPro.Phone1
	pro.Phone2 = updPro.Phone2
	pro.ReIp = updPro.ReIp
	pro.ReLasted = time.Now().Unix()

	//插入数据到用户表
	_, err = o.Insert(pro)

	if err == nil {
		user.Id = updUser.Id
		user.Profile = pro
		user.Username = updUser.Username
		user.Password = utils.Md5(updUser.Password)
		user.Avatar = utils.GetAvatar("")
		user.Status = 1
		_, err = o.Insert(user)
	}

	//有错误需要回滚
	if err != nil {
		_ = o.Rollback()
	} else {
		_ = o.Commit()
	}

	return err
}

//用户列表
func ListUser(condArr map[string]string, page int, offset int) (num int64, err error, user []Users) {
	o := orm.NewOrm()
	o.Using("default")
	qs := o.QueryTable(models.TableName("users"))
	cond := orm.NewCondition()
	if condArr["keywords"] != "" {
		cond = cond.AndCond(cond.And("username__icontains", condArr["keywords"]).Or("profile__realname__icontains", condArr["keywords"]))
	}
	if condArr["status"] != "" {
		cond = cond.And("status", condArr["status"])
	}
	qs = qs.SetCond(cond)
	if page < 1 {
		page = 1
	}
	if offset < 1 {
		offset, _ = beego.AppConfig.Int("pageoffset")
	}
	start := (page - 1) * offset
	qs = qs.RelatedSel()

	var users []Users
	num, err1 := qs.Limit(offset, start).All(&users)
	return num, err1, users
}

//统计数量
func CountUser(condArr map[string]string) int64 {
	o := orm.NewOrm()
	qs := o.QueryTable(models.TableName("users"))
	qs = qs.RelatedSel()
	cond := orm.NewCondition()
	if condArr["keywords"] != "" {
		cond = cond.AndCond(cond.And("username__icontains", condArr["keywords"]).Or("profile__realname__icontains", condArr["keywords"]))
	}
	if condArr["status"] != "" {
		cond = cond.And("status", condArr["status"])
	}
	num, _ := qs.SetCond(cond).Count()
	return num
}

//更改用户状态
func ChangeUserStatus(id int64, status int) error {
	o := orm.NewOrm()

	user := Users{Id: id}
	err := o.Read(&user, "userid")
	if nil != err {
		return err
	} else {
		user.Status = status
		_, err := o.Update(&user)
		return err
	}
}

//更改用户头像
func ChangeUserAvatar(id int64, avatar string) error {
	o := orm.NewOrm()

	user := Users{Id: id}
	err := o.Read(&user, "userid")
	if nil != err {
		return err
	} else {
		user.Avatar = avatar
		_, err := o.Update(&user)
		return err
	}
}

type UsersFind struct {
	Userid   int64
	Realname string
	Avatar   string
	Position string
}

//显示所有用户
func ListUserFind() (num int64, err error, user []UsersFind) {
	var users []UsersFind
	qb, _ := orm.NewQueryBuilder("mysql")
	qb.Select("upr.userid", "upr.realname", "p.name AS position", "u.avatar").From("pms_users AS u").
		LeftJoin("pms_users_profile AS upr").On("upr.userid = u.userid").
		LeftJoin("pms_positions AS p").On("p.positionid = upr.positionid").
		Where("u.status=1").
		OrderBy("p.name").
		Desc()
	sql := qb.String()
	o := orm.NewOrm()
	nums, err := o.Raw(sql).QueryRows(&users)
	return nums, err, users
}
