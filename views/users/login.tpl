<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>{{config "String" "globaltitle" ""}}</title>
{{template "inc/meta.tpl" .}}
<style>
.form-signin .help-block{color:#a94442;}
</style>
</head><body class="login-body">
<div class="container">
  <form class="form-signin" id="login-form">
    <div class="form-signin-heading text-center">
      <h1 class="sign-title">台账登录</h1>
      <img src="/static/img/logo.png" alt="疫情台账" style="width:120px;"/> </div>
    <div class="login-wrap">
      <input type="text" class="form-control" name="username" placeholder="请填写用户名" autofocus>
      <input type="password" class="form-control" name="password" placeholder="请填写密码">
      <p>加QQ群（1093747590）获取用户和密码</p>
	<button class="btn btn-lg btn-login btn-block" type="submit"> 登录</button>
    </div>
  </form>
    <div class="form-signin">
    <div class="form-signin-heading text-center">
      <img src="/static/img/1093747590.png" alt="疫情台账" /> </div>
    </div>
  </div>
</div>
{{template "inc/foot.tpl" .}}
</body>
</html>
