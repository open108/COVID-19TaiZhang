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
      <h4>&ensp;&ensp;完成时间:{{.Time}}</h4>
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
                  <label class="col-lg-2 col-sm-2 control-label">您已经完成调查，需要继续填报,请点继续...</label>
                  <div class="col-lg-10" align = "left">
                    <button type="submit" class="btn btn-primary" onclick="javascript :history.back(-1);">继续填报</button>
                  </div>
                </div>

                <header><b> 更多基本信息 </b></header>
                <div class="form-group">
                  <label class="col-sm-2 control-label">手机号码</label>
                  <div class="col-sm-10">
                    <label type="text" class="form-control">{{.Tel}}</label>      </div>
                </div>      

                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">名字</label>
                  <div class="col-sm-10">
                    <label type="text" class="form-control">{{.Name}}</label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 col-sm-2 control-label">检测体温</label>
                  <div class="col-sm-10">
                    <label type="text" class="form-control">{{.Temperature}}(摄氏度)</label>
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
