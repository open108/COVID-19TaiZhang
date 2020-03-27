<!DOCTYPE html>
<html lang="en">
<head>
  <script src="/static/js/jquery-ui-1.10.3.min.js"></script>
<meta charset="utf-8">
<title>{{config "String" "globaltitle" ""}}</title>
{{template "inc/meta.tpl" .}}
<link href="/static/css/table-responsive.css" rel="stylesheet">
<link href="/static/css/jquery-ui-1.10.3.css"  rel="stylesheet" />
</head><body class="sticky-header">
<section> 
 {{template "inc/left.tpl" .}}
  <!-- main content start-->
  <div class="main-content" >
    <!-- header section start-->
    <div class="header-section">
      <!--toggle button start-->
      <a class="toggle-btn"><i class="fa fa-bars"></i></a>
      <!--toggle button end-->

      </div>
    <!-- header section end-->
    <!-- page heading start-->
    <div class="page-heading">
      <h3> {{.ShopName}} </h3>
      <ul class="breadcrumb pull-left">
        <li> <a href="/checkwork/all">来访人员</a> </li>
        <li class="active"> 来访人员记录 </li>
      </ul>
    </div>
    <div class="clearfix"></div>
    <!-- page heading end-->
    <!--body wrapper start-->
    <div class="wrapper">
      <div class="row">
        <div class="col-md-8">
          <div class="row">
            <div class="col-md-12">
              <div class="panel">
                <header class="panel-heading"> 来访人员名单<span class="tools pull-right">
                  <!-- <button onClick="myPrint(document.getElementById('print'))" class="btn btn-warning" style="margin-top: -4px;">打 印</button> -->
                  <!-- <select class="form-control" id="ym" style="width: 124px;display: inline;"> -->

                <form action="/checkwork/manage" method="get">
                  <input type="text" name="date" id="default-date-picker" value="" class="form-control"
                    style="width: 124px;display: inline;" placeholder="输入查询的日期">
                  <button onClick="" class="btn btn-warning" style="margin-top: -4px;">查询</button>
                </form>



                  </select>
                  </span> </header>
                <div class="panel-body" style="min-height:186px;" id="print">
                  <table class="table table-bordered table-striped table-condensed" border="1">
                    <thead>
                      <tr>
                        <th>姓名</th>
                        <th>电话</th>
                        <th>时间</th>
                        <th>体温</th>
                      </tr>
                    </thead>
                    <tbody>
                    
                    {{range $k,$v := .checkworks}}
                    <tr>
                      <td><a href="/yqtz/add/success?RecodeID={{$v.Id}}">{{$v.Name}}</a></td>
                      <td>{{$v.Phone}}</td>
                      <td>{{$v.TimeFmt}}</td>
                      <td>{{$v.Temperature}}</td>
                    </tr>
                    {{else}}
                    <tr>
                      <td colspan="4">无记录可看</td>
                    </tr>
                    {{end}}
                    </tbody>
                    
                  </table>
                 </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="panel">
            <div class="panel-body">
              <div class="blog-post">
                <h3>{{.date}} 小计:</h3>
                <ul>
                  <li>人次统计: {{.countCheckworks}} 人次</li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--body wrapper end-->
    <!--footer section start-->
    {{template "inc/foot-info.tpl" .}}
    <!--footer section end-->
  </div>
  <!-- main content end-->
</section>
{{template "inc/foot.tpl" .}}
<script src="/static/js/jquery-ui-1.10.3.min.js"></script>
<script src="/static/js/datepicker-zh-CN.js"></script>


<!-- 查询日期的组件 -->
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
