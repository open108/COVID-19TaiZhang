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
       <h3> <center><green>新冠肺炎流行病学史问诊完成</green></center></h3>
        </div>
    <!-- header section end-->
    <!-- page heading start-->
    <div class="page-heading">
      <ul class="breadcrumb ">
        <li class="active">反馈信息</li>
      </ul>
      <h3>&ensp;问诊地址：{{.ShopName}}</h3>
      <h4>&ensp;&ensp;完成时间:{{.pro.TimeFmt}}</h4>
        <li class="active">  已经完成问诊，谢谢您的合作！</li>
    </div>
    <!-- page heading end-->
    <!--body wrapper start-->
    <div class="wrapper">
      <div class="row">
        <div class="col-lg-12">
          <section class="panel">
            <header class="panel-heading"> {{.title}} </header>
            <div class="panel-body">
              <form class="form-horizontal adminex-form" id="taizhangquickly-form">

                  <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label red">您将对您填报的信息负责,签字为</label>
                  <div class="col-sm-10">
                    <img  width=100% height="100%" alt="" id = "qianming" src = "">
                    <h5 id = 'Temperature' class = "{{.TemperatureClass}}">检测的体温:{{.pro.Temperature}}摄氏度</h5>
                   <h5 id = 'Name' class = "springgreen">名字:{{.pro.Name}}</h5>
                    <h5 id = 'Phone' class = "springgreen">手机号:{{.pro.Phone}}</h5>
                    <h5 id = 'QSTel' class = "springgreen">亲属电话:{{.pro.QSTel}}</h5>
                    <h5 id = 'UId' class = "springgreen">身份证号:{{.pro.UId}}</h5>
                    <h5 id = 'Address' class = "springgreen">住居地址现在:{{.pro.Address}}</h5>
                    <h5 id = 'Professsion' class = "springgreen">职业:{{.pro.Professsion}}</h5>
                    <h5 id = 'Birth' class = "springgreen">出生日期:{{.pro.Birth}}</h5>
                    <h5 id = 'Sex' class = "springgreen">性别:{{if eq 1 .pro.Sex}}男{{else}}女{{end}}</h5>
                  </div>
                </div>

                <header><b> 流行病学史信息 </b></header>
                <div class="form-group col-sm-10" >
                  <label class="col-sm-2 control-label">
                  <h5 class = "springgreen"> 1. 本人{{.pro.Name}},我在{{.ShopName}}进行了相关普法教育。
                  并且，如实告知并确认以下流行病学史属实，知道如果因为隐瞒流行病学史而导致传染病传播风险，
                  按照《中华人民共和国传染病防治法》和《突发公共卫生事件应急条例》规定，可能涉嫌违法，
                  将承担相应的法律责任。</h5> 
                  <h5 {{if eq 1 .pro.Wwhlxshi}} class = "red " {{end}}> 2. 我发病前14天内{{if eq 1 .pro.Wwhlxshi}}有{{else}}无{{end}}到过湖北省及其他疫情比较重地区的旅行史或居住史。</h5> 
                  <h5 {{if eq 1 .pro.Wwhjcfare}} class = "red " {{end}}> 3. 我发病前14天内{{if eq 1 .pro.Wwhjcfare}}有{{else}}没{{end}}曾接触过来至湖北省及其他疫情比较重地区的发热患者。</h5> 
                  
                  <h5 {{if eq 1 .pro.Wwhjchuxingdao}} class = "red " {{end}}> 4. 我发病前14天内{{if eq 1 .pro.Wwhjchuxingdao}}有{{else}}没{{end}}曾接触过来至湖北省及其他疫情比较重地区的有呼吸道症状的患者。</h5> 
                  <h5 {{if eq 1 .pro.Wqtlxshi}} class = "red " {{end}}> 5. 我发病前14天内{{if eq 1 .pro.Wqtlxshi}}有{{else}}无{{end}}到其他有病例报告社区的旅行史和居住史。</h5> 
                  
                  <h5 {{if eq 1 .pro.Wqtjcfare}} class = "red " {{end}}> 6. 我发病前14天内{{if eq 1 .pro.Wqtjcfare}}有{{else}}没{{end}}曾接触过来至否有到其他有病例报告社区的发热患者。</h5> 
                  <h5 {{if eq 1 .pro.Wqtjchuxingdao}} class = "red " {{end}}> 7. 我发病前14天内{{if eq 1 .pro.Wqtjchuxingdao}}有{{else}}没{{end}}曾接触过来至否有到其他有病例报告社区的发热患者。</h5> 
                  <h5 {{if eq 1 .pro.Wjjxingfabing}} class = "red " {{end}}> 8. 14天内我生活或工作的地方{{if eq 1 .pro.Wjjxingfabing}}{{else}}不{{end}}存在聚集性发病（2例及以上）。</h5> 
                  <h5 {{if eq 1 .pro.Wjjxinxinghuanzhe}} class = "red " {{end}}> 9. 14天内我{{if eq 1 .pro.Wjjxinxinghuanzhe}}有{{else}}没{{end}}于新型冠状病毒感染者（病人）有过接触。</h5> 
 
                  </label>
                </div>      


                <div class="form-group">
                  <label class="col-lg-2 col-sm-2 control-label">请点返回，返回上级页面...</label>
                  <div class="col-lg-10" align = "left">
                    <button type="button" class="btn btn-primary" onclick="javascript :history.back(-1);">返回</button>
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
 <div id="signature" class = "signature-box" ></div>


{{template "inc/foot.tpl" .}}
<script src="/static/js/jquery-ui-1.10.3.min.js"></script>
<script src="/static/js/datepicker-zh-CN.js"></script>

<script language="JavaScript" type="text/javascript" src="/static/js/jSignature.min.js"></script>
<script language="JavaScript" type="text/javascript" src="/static/js/plugins/jSignature.CompressorBase30.js"></script>
<script language="JavaScript" type="text/javascript" src="/static/js/plugins/jSignature.CompressorSVG.js"></script>
<script language="JavaScript" type="text/javascript" src="/static/js/plugins/jSignature.UndoButton.js"></script>

 <script type="text/javascript">

 $(document).ready(function() {
  $("#signature").jSignature();
  $("#signature").jSignature("setData","data:" + {{.pro.WjSignaturePic}});
  var datapair = $("#signature").jSignature("getData", "image");
  $("#qianming").attr('src','data:' + datapair[0] + "," + datapair[1]);
  $("#signature").attr('style','display:none;');
  
 });
 </script>
 
 </body>
</html>
