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
            <!--
              <form class="form-horizontal adminex-form" id="taizhangquickly-form">

                <header><b> 基本信息 </b></header>
                <div class="form-group">
                  <label class="col-sm-2 control-label">手机号码</label>
                  <div class="col-sm-10">
                    <input type="text" name="myusername"  value="{{.user.Username}}" class="form-control" placeholder="请填写手机号">       </div>
                </div>      

                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">身份证号后三位</label>
                  <div class="col-sm-10">
                    <input type="text" name="id3"  value="" class="form-control" placeholder="身份证号后三位">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">检测体温</label>
                  <div class="col-sm-10">
                    <input type="text" name="temperature"  value="" class="form-control" placeholder="请输入检测的体温">
                    <h5>单位(摄氏度)</h5>
                  </div>
                </div>


                <div class="form-group">
                  <label class="col-lg-2 col-sm-2 control-label"></label>
                  <div class="col-lg-10" align = "left">
                    <input type="hidden" name="ShopUserID" value="{{.pro.ShopID}}">
                    <input type="hidden" name="subType" value="quicklyS">
                    <h5 class="container-fluid ">如果，您在之前填报过本系统，可以通过电话号和身份证号后三位快速填报帮您补全个人信息。但是,<span>流行病学信息请根据实际情况调整!</span></h5>
                    <button type="submit" class="btn btn-primary">快速填报</button>
                  </div>
                </div>
                </form>
                -->

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
                    <input type="radio" name="pfgaozhi" value="1" >
                    已经告知 </label>
                  </div>
                </div>


                <div class="form-group">
                <h4> 2. 请问您发病前14天内是否有到过湖北省及其他疫情比较重地区的旅行史或居住史？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">旅行或居住</label>
                    <label class="radio-inline">
                    <input type="radio" name="whlxshi" value="1">
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" name="whlxshi" value="2">
                    否 </label>
                  </div>
                </div>

                <div class="form-group">
                <h4> 3. 请问您发病前14天内是否曾接触过来至湖北省及其他疫情比较重地区的发热患者？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">是否接触</label>
                    <label class="radio-inline">
                    <input type="radio" name="whjcfare" value="1">
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" name="whjcfare" value="2">
                    否 </label>
                  </div>
                </div>

                <div class="form-group">
                <h4> 4. 请问您发病前14天内是否曾接触过来至湖北省及其他疫情比较重地区的有呼吸道症状的患者？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">是否接触</label>
                    <label class="radio-inline">
                    <input type="radio" name="whjchuxingdao" value="1">
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" name="whjchuxingdao" value="2">
                    否 </label>
                  </div>
                </div>


                <div class="form-group">
                <h4> 5. 请问您发病前14天内是否有到其他有病例报告社区的旅行史和居住史？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">旅行或居住</label>
                    <label class="radio-inline">
                    <input type="radio" name="qtlxshi" value="1">
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" name="qtlxshi" value="2">
                    否 </label>
                  </div>
                </div>

                <div class="form-group">
                <h4> 6. 请问您发病前14天内是否曾接触过来至否有到其他有病例报告社区的发热患者？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">是否接触</label>
                    <label class="radio-inline">
                    <input type="radio" name="qtjcfare" value="1">
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" name="qtjcfare" value="2">
                    否 </label>
                  </div>
                </div>

                <div class="form-group">
                <h4> 7. 请问您发病前14天内是否曾接触过来至否有到其他有病例报告社区的发热患者？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">是否接触</label>
                    <label class="radio-inline">
                    <input type="radio" name="qtjchuxingdao" value="1">
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" name="qtjchuxingdao" value="2">
                    否 </label>
                  </div>
                </div>

                <div class="form-group">
                <h4> 8. 请问14天内您生活或工作的地方是否存在聚集性发病（2例及以上）？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">是否接触</label>
                    <label class="radio-inline">
                    <input type="radio" name="jjxingfabing" value="1">
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" name="jjxingfabing" value="2">
                    否 </label>
                  </div>
                </div>



                <div class="form-group">
                <h4> 9. 请问14天内您是否于新型冠状病毒感染者（病人）有过接触？</h4>
                  <div class="col-sm-10">
                    <label class="col-sm-2 col-sm-2 control-label">是否接触</label>
                    <label class="radio-inline">
                    <input type="radio" name="jjxinxinghuanzhe" value="1" >
                    是 </label>
                    <label class="radio-inline">
                    <input type="radio" name="jjxinxinghuanzhe" value="2">
                    否 </label>
                  </div>
                </div>
                <header><b> 完整的个人信息 </b></header>

                <div class="form-group">
                  <label class="col-sm-2 control-label">姓名</label>
                  <div class="col-sm-10">
                    <input type="text" name="uname"  value="" class="form-control" placeholder="请输入您的名字">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">性别</label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                    <input type="radio" name="sex" value="1" {{if eq 1 .pro.Sex}}checked{{end}}>
                    男 </label>
                    <label class="radio-inline">
                    <input type="radio" name="sex" value="2" {{if eq 2 .pro.Sex}}checked{{end}}>
                    女 </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">出生年月日</label>
                  <div class="col-sm-10">
                    <input type="text" name="birth" id="default-date-picker"  value="{{.pro.Birth}}" class="form-control" placeholder="请填您的生日">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">身份证号</label>
                  <div class="col-sm-10">
                    <input type="text" name="uID"  value="" class="form-control" placeholder="请输入您的身份证号">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">现居住地址</label>
                  <div class="col-sm-10">
                    <input type="text" name="uaddr"  value="" class="form-control" placeholder="请输入您的地址详细地址">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">职业</label>
                  <div class="col-sm-10">
                    <input type="text" name="uprofession"  value="" class="form-control" placeholder="请输入您的职业">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">本人电话</label>
                  <div class="col-sm-10">
                    <input type="text" name="utelphone"  value="" class="form-control" placeholder="请输入您的电话">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">亲属电话</label>
                  <div class="col-sm-10">
                    <input type="text" name="uqtelphone"  value="" class="form-control" placeholder="请输入您的亲属的电话">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">检测体温</label>
                  <div class="col-sm-10">
                    <input type="text" name="temperature"  value={{.pro.Temperature}} class="form-control" placeholder="请输入检测的体温">
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
 <script type="text/javascript">

 $(document).ready(function() {
   $("#signature").jSignature();

  document.getElementById("rsets").onclick=function(){
   $("#signature").jSignature('reset');
};

  document.getElementById("submitbase").onclick=function(){
    document.getElementById("jSignaturePic").value = $("#signature").jSignature("getData", "base30");
};

 });
 </script>
 
 <!-- 日期填表 -->
<script>
$(function(){
	$('#default-date-picker').datepicker('option', $.datepicker.regional['zh-CN']); 	
	$('#default-date-picker').datepicker({
        dateFormat: 'yy-mm-dd',
		changeMonth: true,
		changeYear: true,
		yearRange:'-60:+0'
    });
})
</script>
</body>
</html>
