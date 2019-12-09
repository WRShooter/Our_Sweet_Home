<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>博客后台管理系统</title>
<link type="text/css" rel="stylesheet" href="css/manager.css">
</head>
<body>
	<div class="login_block">
			<p><label class="blog">博客后台</label></p>
			<form action="manager_login" method="POST">
				<p><label class="lable_input">账号：</label><input type="text" name="manager_name" class="text_input" placeholder="请输入您的账号"><br/></p>
				<p><label class="lable_input">密码：</label><input type="password" name="manager_password" class="text_input" placeholder="请输入您的密码"><br/></p>
				<div id="login_control">
					<input type="submit" value="登录">
				</div>
			</form>
		</div>
</body>
</html>