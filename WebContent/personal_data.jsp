<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="login.DataMethod" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>个人资料</title>
<link type="text/css" rel="stylesheet" href="css/personal_data.css">
</head>
<body>
	<%
		DataMethod method = new DataMethod();
	%>
	<%
		String user_name = (String)session.getAttribute("user_name");
		Connection conn = method.DataConn();
		PreparedStatement stmlt = null;
		ResultSet rs = null;
		String sql1="SELECT * FROM`image` WHERE user_name=?";
		stmlt = conn.prepareStatement(sql1);
		stmlt.setString(1, user_name);
		rs = stmlt.executeQuery();%>
		<%
			if(rs.next()) {
			String pic_name = rs.getString(2); 
			session.setAttribute("pic_name", pic_name);
		%>
		<%
			} 
		%>
	<%	
		int i = 1;
		String sql = "select manager_name,intro,name,gender,birthday,location,occupational,manager_email from profile where manager_name=?";
		stmlt = conn.prepareStatement(sql);
		stmlt.setString(1, (String)session.getAttribute("user_name"));
		rs = stmlt.executeQuery();
		while(rs.next()){
			rs.getString(i);
			i++;
		%>
	<h2>个人资料</h2>
	<div class="line"></div>
	<div class="content clearfix">
		<div class="left">
		<form method="post"  action="ImageUpload" enctype="multipart/form-data" >
		<img id="avatar_img" src="http://localhost:8080/Blog_System/GetImage?data=<%=session.getAttribute("pic_name") %>" style="" class="avatar" onerror="this.src='image/timg.jpeg'" onclick="imageOnClick()"/>
		<input style="display:none" id="avatar_file" type="file" name="fileName" placeholder="上传图片">
		<button style="display:none" class="btn btn-default" type="submit"></button>
		</form>
			<input type="button" class="edit" value="修改资料">
		</div>
		<div class="right">
			<div class="right-top">
					<p>账号：&nbsp;<label><%=rs.getString(1) %> </label></p>
					<p>签名：&nbsp;<label><%=rs.getString(2)%> </label></p>		
			</div>
			<div class="right-bottom">
					<p>昵称：&nbsp;<label><%=rs.getString(3)%></label></p>
					<p>性别：&nbsp;<label><%=rs.getString(4)%></label></p>
					<p>生日：&nbsp;<label><%=rs.getString(5)%></label></p>
					<p>地区：&nbsp;<label><%=rs.getString(6)%></label></p>
					<p>职业：&nbsp;<label><%=rs.getString(7)%></label></p>
					<p>邮箱：&nbsp;<label><%=rs.getString(8)%></label></p>
			</div>
		</div>
	<%
			}
	%>
		
	</div>
</body>
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(function(){           
    $(".edit").click(function(){
    	document.getElementById("avatar_file").disabled=false;
    	var user_name = this.parentNode.parentNode.getElementsByTagName("label")[0];
        var intro = this.parentNode.parentNode.getElementsByTagName("label")[1];
        var name = this.parentNode.parentNode.getElementsByTagName("label")[2];
        var gender = this.parentNode.parentNode.getElementsByTagName("label")[3];
        var birthday = this.parentNode.parentNode.getElementsByTagName("label")[4];
        var location = this.parentNode.parentNode.getElementsByTagName("label")[5];
        var occupational = this.parentNode.parentNode.getElementsByTagName("label")[6];
        var manager_email = this.parentNode.parentNode.getElementsByTagName("label")[7];
        if(this.value == "修改资料"){
            this.value = "确定";
            //user_id.innerHTML ="<input value='"+user_id.innerHTML+"'/>";
            intro.innerHTML ="<input value='"+intro.innerHTML+"'/>";
            name.innerHTML ="<input value='"+name.innerHTML+"'/>";
            birthday.innerHTML ="<input value='"+birthday.innerHTML+"'/>";
            location.innerHTML ="<input value='"+location.innerHTML+"'/>";
            occupational.innerHTML ="<input value='"+occupational.innerHTML+"'/>";
            gender.innerHTML ="<input value='"+gender.innerHTML+"'/>";
        }else{
        	//user_id.innerHTML =user_id.getElementsByTagName("input")[0].value;
        	intro.innerHTML =intro.getElementsByTagName("input")[0].value;
        	name.innerHTML =name.getElementsByTagName("input")[0].value;
        	birthday.innerHTML =birthday.getElementsByTagName("input")[0].value;
        	location.innerHTML =location.getElementsByTagName("input")[0].value;
        	occupational.innerHTML =occupational.getElementsByTagName("input")[0].value;
        	gender.innerHTML =gender.getElementsByTagName("input")[0].value;
        	$.ajax({
        		type:'POST',
				url :'ChangeServlet',
				data:{
					intro:intro.innerHTML,
					name:name.innerHTML,
					birthday:birthday.innerHTML,
					location:location.innerHTML,
					occupational:occupational.innerHTML,
					gender:gender.innerHTML,
				},
				success:function(data){
					location.href='personal_data.jsp';
				},
        	});
        	$(".btn").click();
            this.value = "修改资料";
        }
    })
}); 
</script>
<script type="text/javascript">
    document.getElementById("avatar_file").disabled=true;
function imageOnClick(){
    $("#avatar_file").click();
}
$("#avatar_file").change(function () {
    var file = $(this)[0].files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function () {
        $("#avatar_img").attr("src", this.result);
    }
});
$(".btn").click(function(){
	document.getElementById("avatar_file").disabled=false;
})
    </script>
</html>