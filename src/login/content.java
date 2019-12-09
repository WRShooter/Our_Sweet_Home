package login;

public class content {
			public static String html(String code) {
				
				String html = "Email地址验证<br/>"+ 
				"这封邮件是由【博客系统】发送的。<br/>"+
				"你收到这封邮件是【博客系统】进行新用户注册。<br/>"+
				"账号激活声明<br/>"+
				"请将下面的验证码输入到提示框即可：<h3 style='color:red;'>" + code + "</h3><br/>";
				return html;
			}
		}

