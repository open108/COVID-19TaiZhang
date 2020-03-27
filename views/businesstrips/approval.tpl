<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>{{config "String" "globaltitle" ""}}</title>
{{template "inc/meta.tpl" .}}
<link href="/static/css/table-responsive.css" rel="stylesheet">
</head><body class="sticky-header">
<section> {{template "inc/left.tpl" .}}
  <!-- main content start-->
  <div class="main-content" >
    <!-- header section start-->
    <div class="header-section">
      <!--toggle button start-->
      <a class="toggle-btn"><i class="fa fa-bars"></i></a>
      <!--toggle button end-->
      <!--search start-->
      <!--search end-->
      {{template "inc/user-info.tpl" .}} </div>
    <!-- header section end-->
    <!-- page heading start-->
    <div class="page-heading">
      <h3> 审批管理 {{template "inc/checkwork-nav.tpl" .}}</h3>
      <ul class="breadcrumb pull-left">
        <li> <a href="/user/show/{{.LoginUserid}}">OPMS</a> </li>
        <li> <a href="/businesstrip/approval">审批管理</a> </li>
        <li class="active"> 出差审批 </li>
      </ul>
      <div class="pull-right"> <a href="/businesstrip/manage" class="btn btn-success" style="padding:4px;">出差</a> <a href="/businesstrip/approval?filter=wait" class="btn btn-default {{if eq .condArr.filter "wait"}}active{{end}}" style="padding:4px;">待审批</a> <a href="/businesstrip/approval?filter=over" class="hidden-xs  btn btn-default {{if eq .condArr.filter "over"}}active{{end}}" style="padding:4px;">已审核</a> </div>
    </div>
    <!-- page heading end-->
    <!--body wrapper start-->
    <div class="wrapper">
      <div class="row">
        <div class="col-sm-12">
          <section class="panel">
            <header class="panel-heading"> 出差 / 总数：{{.countBusinesstrip}}<span class="tools pull-right"><a href="javascript:;" class="fa fa-chevron-down"></a> </span> </header>
            <div class="panel-body">
              <table class="table table-hover general-table">
                <thead>
                  <tr>
                    <th> 出差人</th>
                    <th class="hidden-phone">申请日期</th>
                    <th>天数</th>
                    <th>结果</th>
                    <th>进度</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <tbody>
                
                {{range $k,$v := .businesstrips}}
                <tr>
                  <td><a href="/user/show/{{$v.Userid}}" style="color:#65CEA7">{{getRealname $v.Userid}}</a> </td>
                  <td class="hidden-phone">{{getDate $v.Changed}}</td>
                  <td>{{$v.Days}}天 </td>
                  <td> {{if eq $v.Status 1}} <span class="label label-success label-mini">同意</span> {{else if eq $v.Status 2}} <span class="label label-danger label-mini">拒绝</span>{{else}}<span class="label label-warning label-mini">等待中</span> {{end}} </td>
                  <td><div class="js-selectuserbox"> {{str2html (getBusinesstripProcess $v.Id)}} </div></td>
                  <td><a href="/businesstrip/approval/{{$v.Id}}"> 审批 </a> </td>
                </tr>
                {{else}}
                <tr>
                  <td colspan="7">数据暂时为空</td>
                </tr>
                {{end}}
                </tbody>
                
              </table>
              {{template "inc/page.tpl" .}} </div>
          </section>
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
</body>
</html>
