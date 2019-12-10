<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>注册</title>
	<link type="text/css" rel="stylesheet" href="css/regist.css">
	</head>
	<body>
		<div class="regist_block">
			<p id="#regist_logo"><img src="image/logo.png" width="70px" height="48.3px"></p>
			<form action="regist" method="POST">
				<p><label class="lable_input">请输入账号：</label><input type="text" name="user_name" class="text_input" placeholder="请输入您的账号"><br/></p>
				<p><label class="lable_input">请输入密码：</label><input type="password" name="user_password1" class="text_input" placeholder="请输入您的密码"><br/></p>
				<p><label class="lable_input">请确认密码：</label><input type="password" name="user_password2" class="text_input" placeholder="重复输入密码"><br/></p>
				<p><label class="lable_input">请输入邮箱：</label><input type="email" name="user_text" id="email" placeholder="请输入您的邮箱"><br/></p>
				<p><label class="lable_input">输入验证码：</label><input type="text" name="yanzhengma" class="text_input" placeholder="请输入邮箱验证码"><input type="button" id="btn" value="免费获取验证码" onclick="settime(this)" /></p>
				<div id="regist_control">
					<input type="submit" value="注册">
					<input type="reset" value="重置"/>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
	<script type="text/javascript">
	var countdown = 60;
	function settime(obj) {
	    if (countdown == 0) {
	        obj.removeAttribute("disabled");
	        obj.value="免费获取验证码";
	        countdown = 60;
	        return;
	    } else {
	        obj.setAttribute("disabled", true);
	        obj.value="重新发送(" + countdown + ")";
	        countdown--;
	    }
	setTimeout(function() {
	    settime(obj) }
	    ,1000)
	}
	</script>
	<script type="text/javascript">
	$(function(){
		$("#btn").click(function(){
			if($("#email").val()){
				$.ajax({
					type:'POST',
					url :'se nd_email',
					data:{
						email:$("#email").val(),
					},
					success:function(data){
						alert("验证码发送成功，请注意查收。");
					},
				})
			}
		});
	})
	</script>
</html>