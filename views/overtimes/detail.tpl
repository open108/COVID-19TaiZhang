<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>{{config "String" "globaltitle" ""}}</title>
{{template "inc/meta.tpl" .}}
<style>
.panel-body .table tbody > tr > td {text-align:left;  padding: 12px;}
</style>
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
        <li> <a href="/overtime/manage">审批管理</a> </li>
        <li class="active"> 加班单详情 </li>
      </ul>
      <div class="pull-right"> <a href="javascript:history.back();" class="btn btn-default">返回</a> <a href="/overtime/approval" class="hidden-xs btn btn-default" style="padding:4px;">待审批</a> <a href="/overtime/add" class="btn btn-success">+我要加班</a> </div>
    </div>
    <div class="clearfix"></div>
    <!-- page heading end-->
    <!--body wrapper start-->
    <div class="wrapper">
      <div class="row">
        <div class="col-md-8">
          <div class="blog">
            <div class="single-blog">
              <div class="panel">
                <div class="panel-body">
                  <h1 class="text-center mtop35"><a href="#">加班单</a>
                    <button onClick="myPrint(document.getElementById('print'))" class="pull-right btn">打 印</button>
                  </h1>
                  <p class="text-center auth-row"> By <a href="/user/show/{{.overtime.Userid}}">{{getRealname .overtime.Userid}}</a> | {{getDateMH .overtime.Changed}}</p>
                  <div id="print">
                    <table class="table table-bordered" border="1">
                      <tr class="hide">
                        <th colspan="6" class="text-center">加班单</th>
                      </tr>
                      <tr>
                        <td width="72">姓名</td>
                        <td width="62">{{getRealname .overtime.Userid}}</td>
                        <td width="70">部门</td>
                        <td width="77">{{getDepartmentsName .overtime.Userid}}</td>
                        <td width="80">职位</td>
                        <td width="93">{{getPositionsName .overtime.Userid}}</td>
                      </tr>
                      <tr>
                        <td>核算方式</td>
                        <td colspan="5">{{if eq .overtime.Way 1}}调休{{else if eq .overtime.Way 2}}加班费{{end}}</td>
                      </tr>
					  <tr>
                        <td>法定假日</td>
                        <td colspan="5">{{if eq .overtime.Holiday 1}}是{{else if eq .overtime.Holiday 2}} 否{{end}}</td>
                      </tr>
                      <tr>
                        <td>事由</td>
                        <td colspan="5">{{.overtime.Reason}}</td>
                      </tr>
                      <tr>
                        <td>加班日期</td>
                        <td colspan="5">{{getDateMH .overtime.Started}}至{{getDateMH .overtime.Ended}}</td>
                      </tr>
                      <tr>
                        <td>时长</td>
                        <td colspan="5">{{.overtime.Longtime}}小时</td>
                      </tr>
                      <tr  class="hide">
                        <td>审核人</td>
                        <td colspan="5">&nbsp;</td>
                      </tr>
                      {{range $k,$v := .approvers}}
                      {{if gt $v.Status 0}}
                      <tr class="hide">
                        <td>{{$v.Realname}}</td>
                        <td>{{if eq $v.Status 1}}同意{{else if eq $v.Status 2}}拒绝{{end}}</td>
                        <td colspan="3">{{$v.Summary}}</td>
                        <td>{{getDate $v.Changed}}</td>
                      </tr>
                      {{end}}
                      {{end}}
                    </table>
                  </div>
                  <a class="btn btn-xs btn-warning" style="margin-bottom:6px;">审批人进度</a>
                  <div class="js-selectuserbox"> {{str2html (getOvertimeProcess .overtime.Id)}} </div>
                </div>
              </div>
              <div class="panel">
                <div class="panel-body">
                  <h1 class="text-center cmnt-head">审批人</h1>
                  {{range $k,$v := .approvers}}
                  {{if gt $v.Status 0}}
                  <div class="media blog-cmnt"> <a href="/user/show/{{$v.Userid}}" class="pull-left"> <img src="{{getAvatar $v.Avatar}}" class="media-object"> </a>
                    <div class="media-body">
                      <h4 class="media-heading"> <a href="/user/show/{{$v.Userid}}">{{$v.Realname}}</a> <span class="pull-right">{{getDateMH $v.Changed}}</span></h4>
                      <p class="mp-less"> {{if eq $v.Status 1}}<a class="btn btn-xs btn-success">同意</a>{{else if eq $v.Status 2}}<a class="btn btn-xs btn-danger">拒绝</a>{{end}}<br/>
                        批注：{{$v.Summary}} </p>
                    </div>
                  </div>
                  {{else}}
                  <p class="text-center fade-txt">第
                    <script>document.write({{($k)}}+1)</script>
                    位审批人还没有审批此加班条!</p>
                  {{end}}
                  {{end}} </div>
              </div>
              {{if ne .overtime.Userid .LoginUserid}}
              <div class="panel">
                <div class="panel-body">
                  <h1 class="text-center cmnt-head ">审批</h1>
                  <p class="text-center fade-txt">审批流程不可逆转</p>
                  {{if gt .checkStatus 0}}
                  <h1 class="text-center cmnt-head ">你已经审批过！</h1>
                  {{else}}
                  {{if eq .checkApproverCan 1}}
                  <form role="form" class="form-horizontal overtime-cmnt" id="overtime-approvers-form">
                    <div class="form-group">
                      <div class="col-lg-12">
                        <label class="radio-inline">
                        <input type="radio" value="1" name="status" checked>
                        同意</label>
                        <label class="radio-inline">
                        <input type="radio" name="status" value="2">
                        拒绝</label>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-lg-12">
                        <textarea class=" form-control" rows="8" placeholder="批注说明" name="summary"></textarea>
                      </div>
                    </div>
                    <p>
                      <input type="hidden" name="id" value="{{.checkApproverid}}">
                      <input type="hidden" name="overtimeid" value="{{.overtime.Id}}">
                      <button class="btn btn-primary pull-right" type="submit">提 交</button>
                    </p>
                  </form>
                  {{else}}
                  <h1 class="text-center cmnt-head ">你目前不能操作，请等待前一位审批后或前一位已经拒绝通过！</h1>
                  {{end}}
                  {{end}} </div>
              </div>
              {{end}} </div>
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
</body>
</html>
