<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>{{config "String" "globaltitle" ""}}</title>
{{template "inc/meta.tpl" .}}
</head>
<body class="sticky-header">
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
    <!--body wrapper start-->
    <div class="wrapper">
      <div class="row">
        <div class="jumbotron text-center" style="background-color:transparent;">
          <h2>让项目管理更加轻便！</h2>
		<br/><br/>
			<a style="font-size:38px;" href="/checkwork/manage">开启管理之旅</a>
			<br/><br/>
			<a href="http://www.mamios.com" target="_blank">曼苗科技官网</a> &middot; 
			
        </div>
      </div>
    </div>
    <!--body wrapper end-->
  </div>
  <!-- main content end-->
</section>
{{template "inc/foot.tpl" .}}
</body>
</html>
