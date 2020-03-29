<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>{{config "String" "globaltitle" ""}}</title>
{{template "inc/meta.tpl" .}}
</head><body class="sticky-header">
  <!-- main content start-->
  <div class="main-content" >
    <!-- header section start-->
    <div class="header-section">
      <!--toggle button start-->
       <h3> <center>新冠肺炎流行病学史参考问诊表</center></h3>
        </div>
    <!-- header section end-->
    <!-- page heading start-->
    <div class="page-heading">
      <center><h3>规范问诊流行病学史，实现筛查全覆盖</h3></center>
      <h4>参照执行文件：1.《中华人民共和国传染病防治法》2.《突发公共卫生事件应急条例》3.《新型冠状病毒肺炎诊疗方案（试行第五版 修正版）（国卫办医函（2020）117号，2020.2.8）》</h4>
      <ul class="breadcrumb pull-left">
        <li class="active"> 请填写用户信息 ——{{.ShopName}}</li>
      </ul>
    </div>
    <!-- page heading end-->
    <!--body wrapper start-->
    <div class="wrapper">
      <div class="row">
        <div class="col-lg-12">
          <section class="panel">
            <header class="panel-heading"> {{.title}} </header>
            <div class="panel-body">
            
              <form class="form-horizontal adminex-form" id="taizhangquickly-form"  {{if eq 0 .pro.Id}}{{else}}style='display:none;'{{end}} >

                <header><b> 基本信息 </b></header>
                <div class="form-group">
                  <label class="col-sm-2 control-label">姓名</label>
                  <div class="col-sm-10">
                    <input type="text" id = "q_uname" name="uname"  value="" class="form-control" placeholder="请填写名字">       </div>
                </div>      

                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">本人电话</label>
                  <div class="col-sm-10">
                    <input type="text" id="q_utelphone" name="utelphone" value="" class="form-control" placeholder="请输入您的电话">
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">身份证号</label>
                  <div class="col-sm-10">
                    <input type="text" id="q_Uid" name="uID" value="" class="form-control" placeholder="请输入您的身份证号">
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">检测体温</label>
                  <div class="col-sm-10">
                    <input type="text" id="q_temperature" name="temperature" value="{{.pro.Temperature}}" class="form-control"
                      placeholder="请输入检测的体温">
                    <h5>单位(摄氏度)</h5>
                  </div>
                </div>


                <div class="form-group">
                  <label class="col-lg-2 col-sm-2 control-label"></label>
                  <div class="col-lg-10" align = "left">
                    <input type="hidden" name="ShopUserID" value="{{.pro.ShopID}}">
                    <input type="hidden" name="subType" value="quicklyS">
                    <h5 class="container-fluid ">如果，您在之前填报过本系统，请填写最新的温度签名后提交数据。流行病学信息请根据实际情况调整!</span></h5>
                    <button type="submit" class="btn btn-primary">快速填报</button>
                  </div>
                </div>
                </form>
               

                <!-- 完整问卷调查表 header section end-->
                <form class="form-horizontal adminex-form" id="taizhangprofile-form">
                <div class="form-group">

                </div>
                <header><b> 问诊表 </b></header>
                <div class="form-group">

                </div>
                <div class="form-group red">
                <h4> 1. <span>普法告知：</span>请您如实告知并确认以下流行病学史属实，如果因为<span>隐瞒流行病学史</span>而导致传染病传播风险，按照《中华人民共和国传染病防治法》和《突发公共卫生事件应急条例》规定，可能<span>涉嫌违法，将承担相应的法律责任。</span>谢谢您的理解与配合！</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">告知情况</label>
                    <label class="radio-inline col-sm-2 col-sm-2">
                    <input type="radio" id = "f_pfgaozhi" name="pfgaozhi" value="1" {{if eq 1 .pro.Wpfgaozhi}}checked{{end}}>
                    已经告知 </label>
                  </div>
                </div>


                <div class="form-group">
                <h4> 2. 请问您发病前14天内是否有到过湖北省及其他疫情比较重地区的旅行史或居住史？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">旅行或居住</label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_whlxshi" name="whlxshi" value="1" {{if eq 1 .pro.Wwhlxshi}}checked{{end}} >
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_whlxshi" name="whlxshi" value="2 {{if eq 2 .pro.Wwhlxshi}}checked{{end}}">
                    否 </label>
                  </div>
                </div>

                <div class="form-group">
                <h4> 3. 请问您发病前14天内是否曾接触过来至湖北省及其他疫情比较重地区的发热患者？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">是否接触</label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_whjcfare" name="whjcfare" value="1" {{if eq 1 .pro.Wwhjcfare}}checked{{end}}>
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_whjcfare" name="whjcfare" value="2" {{if eq 2 .pro.Wwhjcfare}}checked{{end}}>
                    否 </label>
                  </div>
                </div>

                <div class="form-group">
                <h4> 4. 请问您发病前14天内是否曾接触过来至湖北省及其他疫情比较重地区的有呼吸道症状的患者？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">是否接触</label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_whjchuxingdao" name="whjchuxingdao" value="1"{{if eq 1 .pro.Wwhjchuxingdao}}checked{{end}}>
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_whjchuxingdao" name="whjchuxingdao" value="2"{{if eq 2 .pro.Wwhjchuxingdao}}checked{{end}}>
                    否 </label>
                  </div>
                </div>


                <div class="form-group">
                <h4> 5. 请问您发病前14天内是否有到其他有病例报告社区的旅行史和居住史？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">旅行或居住</label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_qtlxshi" name="qtlxshi" value="1" {{if eq 1 .pro.Wqtlxshi}}checked{{end}}>
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_qtlxshi" name="qtlxshi" value="2" {{if eq 2 .pro.Wqtlxshi}}checked{{end}}>
                    否 </label>
                  </div>
                </div>

                <div class="form-group">
                <h4> 6. 请问您发病前14天内是否曾接触过来至否有到其他有病例报告社区的发热患者？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">是否接触</label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_qtjcfare" name="qtjcfare" value="1"  {{if eq 1 .pro.Wqtjcfare}}checked{{end}}>
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_qtjcfare" name="qtjcfare" value="2"  {{if eq 2 .pro.Wqtjcfare}}checked{{end}}>
                    否 </label>
                  </div>
                </div>

                <div class="form-group">
                <h4> 7. 请问您发病前14天内是否曾接触过来至否有到其他有病例报告社区的发热患者？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">是否接触</label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_qtjchuxingdao" name="qtjchuxingdao" value="1" {{if eq 1 .pro.Wqtjchuxingdao}}checked{{end}}>
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_qtjchuxingdao" name="qtjchuxingdao" value="2" {{if eq 2 .pro.Wqtjchuxingdao}}checked{{end}}>
                    否 </label>
                  </div>
                </div>

                <div class="form-group">
                <h4> 8. 请问14天内您生活或工作的地方是否存在聚集性发病（2例及以上）？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">是否接触</label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_jjxingfabing" name="jjxingfabing" value="1" {{if eq 1 .pro.Wjjxingfabing}}checked{{end}}>
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_jjxingfabing" name="jjxingfabing" value="2" {{if eq 2 .pro.Wjjxingfabing}}checked{{end}}>
                    否 </label>
                  </div>
                </div>



                <div class="form-group">
                <h4> 9. 请问14天内您是否于新型冠状病毒感染者（病人）有过接触？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">是否接触</label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_jjxinxinghuanzhe" name="jjxinxinghuanzhe" value="1" {{if eq 1 .pro.Wjjxinxinghuanzhe}}checked{{end}}>
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" id = "f_jjxinxinghuanzhe" name="jjxinxinghuanzhe" value="2" {{if eq 2 .pro.Wjjxinxinghuanzhe}}checked{{end}}>
                    否 </label>
                  </div>
                </div>
                <header><b> 完整的个人信息 </b></header>

                <div class="form-group">
                  <label class="col-sm-2 control-label">姓名</label>
                  <div class="col-sm-10">
                    <input type="text" id = "f_uname" name="uname"  value="{{.pro.Name}}" class="form-control" placeholder="请输入您的名字">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">性别</label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                    <input type="radio" id = "f_sex" name="sex" value="1" {{if eq 1 .pro.Sex}}checked{{end}}>
                    男 </label>  
                    <label class="radio-inline">
                    <input type="radio" id = "f_sex" name="sex" value="2" {{if eq 2 .pro.Sex}}checked{{end}}>
                    女 </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">出生年月日</label>
                  <div class="col-sm-10">
                    <input type="text" id = "f_birth" name="birth"  value="{{.pro.Birth}}" class="form-control" placeholder="请填您的生日">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">身份证号</label>
                  <div class="col-sm-10">
                    <input type="text" id="f_Uid" name="uID"  value="{{.pro.UId}}" class="form-control" placeholder="请输入您的身份证号">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">现居住地址</label>
                  <div class="col-sm-10">
                    <input type="text" id="f_uaddr" name="uaddr"  value="{{.pro.Address}}" class="form-control" placeholder="请输入您的地址详细地址">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">职业</label>
                  <div class="col-sm-10">
                    <input type="text" id="f_uprofession" name="uprofession"  value="{{.pro.Professsion}}" class="form-control" placeholder="请输入您的职业">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">本人电话</label>
                  <div class="col-sm-10">
                    <input type="text" id="f_utelphone" name="utelphone"  value="{{.pro.Phone}}" class="form-control" placeholder="请输入您的电话">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">亲属电话</label>
                  <div class="col-sm-10">
                    <input type="text" id="f_uqtelphone" name="uqtelphone"  value="{{.pro.QSTel}}" class="form-control" placeholder="请输入您的亲属的电话">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">检测体温</label>
                  <div class="col-sm-10">
                    <input type="text" id="f_temperature" name="temperature"  value="{{.pro.Temperature}}" class="form-control" placeholder="请输入检测的体温">
                    <h5>单位(摄氏度)</h5>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label red">签名确认 您将对您填报的信息负责,请签字确认</label>
                  <div class="col-sm-10">
                    <div id="signature" class="signature-box"></div>
                    <h5>请在上面空白处签名</h5>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-lg-2 col-sm-2 control-label"></label>
                  <div class="col-lg-10">
                    <input type="hidden" name="ShopUserID" value="{{.pro.ShopID}}">
                    <input type="hidden" name="subType" value="baseS">
                    <input type="hidden" name="jSignaturePic" id = "jSignaturePic" value="">
                    <button type="submit" id = "submitbase" class="btn btn-primary">提 交</button>
                    <button type="button" id = "rsets" class="btn btn-primary">重 签</button>

                  </div>
                </div>
              </form>
              <!--表单 end-->
            </div>
          </section>
        </div>
      </div>
    </div>
    <!--body wrapper end-->
  </div>
  <!-- main content end-->
</section>
{{template "inc/foot.tpl" .}}
<script src="/static/js/jquery-ui-1.10.3.min.js"></script>
<script src="/static/js/datepicker-zh-CN.js"></script>


<!-- 数字签名 -->
<script language="JavaScript" type="text/javascript" src="/static/js/jSignature.min.js"></script>
<script language="JavaScript" type="text/javascript" src="/static/js/jquery.cookie.js"></script>
 <script type="text/javascript">


  
 $(document).ready(function() {
   $("#signature").jSignature();
  try {
    cookvalue = $.cookie('f_uname');
    if (cookvalue != null){
      $("#q_uname").attr('value', cookvalue);
    }
    else{
      $("#taizhangquickly-form").attr('style', 'display:none;');
    }

    cookvalue = $.cookie('f_Uid');
    if (cookvalue != null) {
      $("#q_Uid").attr('value', cookvalue);
    }
    else {
      $("#taizhangquickly-form").attr('style', 'display:none;');
    }

    cookvalue = $.cookie('f_utelphone');
    if (cookvalue != null) {
      $("#q_utelphone").attr('value', cookvalue);
    }
    else {
     $("#taizhangquickly-form").attr('style', 'display:none;');
    }


   } catch (er) {
   }
  //  $.cookie('the_uID', 'runoob2', { expires: 7, path: '/' });
  //  name2 = $.cookie('name2');
  //  $("#f_Uid").value(name2);
  //  $("#taizhangquickly-form").attr('style', 'display:none;');


  document.getElementById("rsets").onclick=function(){
   $("#signature").jSignature('reset');
};

  document.getElementById("submitbase").onclick=function(){
    //基本信息缓存
    if (document.getElementById("f_uname").value != ""){
      $.cookie('f_uname', document.getElementById("f_uname").value, { expires: 90 }, { domain: 'mamios.com' });
    }
    
    if (document.getElementById("f_Uid").value != "") {
    $.cookie('f_Uid', document.getElementById("f_Uid").value, { expires: 90 }, { domain: 'mamios.com' });
    }

    if (document.getElementById("f_utelphone").value != "") {
    $.cookie('f_utelphone', document.getElementById("f_utelphone").value, { expires: 90 }, { domain: 'mamios.com' });
    }
    //签名提交
    document.getElementById("jSignaturePic").value = $("#signature").jSignature("getData", "base30");
};

 });
 </script>
 
 <!-- 日期填表 -->
<script>
$(function(){
	$('#f_birth').datepicker('option', $.datepicker.regional['zh-CN']); 	
	$('#f_birth').datepicker({
    dateFormat: 'yy-mm-dd',
		changeMonth: true,
		changeYear: true,
		yearRange:'-60:+0'
    });
})
</script>
</body>
</html>
