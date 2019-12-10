<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="login.DataMethod" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户信息</title>
<script src="js/jquery-3.4.1.min.js"
    type="text/javascript"></script>
</head>
<body>
	<%
		DataMethod method = new DataMethod();
	%>
	<%
		Connection conn = method.DataConn();
		PreparedStatement stmlt = null;
		ResultSet rs = null;
	%>
	<%
		int pageSize = 10;
		int pageNow = 1;
		int rowCount = 0;
		int pageCount = 0;
		String s_pageNow = (String)request.getParameter("pageNow");
		if(s_pageNow != null) {
			pageNow = Integer.parseInt(s_pageNow);
		}
		String sql1 = "select count(*) from user";
		stmlt = conn.prepareStatement(sql1);
		rs = stmlt.executeQuery();
		if(rs.next()) {
			rowCount = rs.getInt(1);
		}
		if(rowCount%pageSize == 0) {
			pageCount = rowCount/pageSize;
		} else {
			pageCount = rowCount/pageSize + 1;
		}
		int start = pageSize * (pageNow -1);
		int end = start + (pageSize - 1);
		if (end > pageSize) {
			pageSize = rowCount - start; 
		}
		String sql = "select user_id,user_name,user_password,user_email from user limit ?,?";
		stmlt = conn.prepareStatement(sql);
		stmlt.setLong(1, start);
		stmlt.setLong(2, pageSize);
		rs = stmlt.executeQuery();
	%>
	<table border="1" style="margin-top:5%;text-align: center;border-collapse: separate;border-spacing: 3px 3px; border:1px solid #eaeaea;">
		<tr style="text-align: center;">
			<td style="width:100px;">用户编号&nbsp;&nbsp;&nbsp;</td>
			<td style="width:150px;">用户账号&nbsp;&nbsp;&nbsp;</td>
			<td style="width:200px;">用户密码&nbsp;&nbsp;&nbsp;</td>
			<td style="width:200px;">用户邮箱&nbsp;&nbsp;&nbsp;</td>
		</tr>
		<tr>
			<td><input style="text-align:center;width:100px;" type="text" name="id" id="user_id" placeholder="请输入待添加的用户id"></td>
			<td><input style="text-align:center;width:150px;" type="text" name="name" id="user_name" placeholder="请输入待添加的用户账号"></td>
			<td><input style="text-align:center;width:200px;" type="password" name="password" id="user_password" placeholder="请输入待添加的用户密码"></td>
			<td><input style="text-align:center;width:200px;" type="email" name="email" id="user_email" placeholder="请输入待添加的email"></td>
			<td><input type="button" id="btn" value="添加"/></td>
		</tr>
	</table>
	<table id="tb" border="1" style="margin-top:2%;height:80%;text-align: center;border-collapse: separate;border-spacing: 3px 3px; border:1px solid #eaeaea;">
		<thead>
			<tr style="height:20px;background:#d5d5d5;color: #fff; text-align: center;">
				<td style="width:100px;">用户编号&nbsp;&nbsp;&nbsp;</td>
				<td style="width:100px;">用户账号&nbsp;&nbsp;&nbsp;</td>
				<td style="width:170px;">用户密码&nbsp;&nbsp;&nbsp;</td>
				<td style="width:170px;">用户邮箱&nbsp;&nbsp;&nbsp;</td>
				<td style="width:160px;">操作&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</thead>
	<%
		while(rs.next()) {
			String user_id = rs.getString(1);
			String user_name = rs.getString(2);
			String user_password = rs.getString(3);
			String user_email = rs.getString(4);
	%>
		<tbody style="background: #eaeaea; text-align: center;">                  
            <tr style="height:35px;background-color: white">         
            	<td class="user_id"><%=user_id %></td>               
                <td class="user_name"><%=user_name %></td>                        
                <td class="user_password"><%=user_password %></td>                        
                <td class="user_email"><%=user_email %></td>
                <td><input type="button" class="del" value="删除"/>｜<input type="button" class="edit" value="编辑"></td>
            </tr>                
		</tbody>
	<%
		}
	%>
	</table>
	<form   Action= ""   method= "post" style="margin-left:80%;">   
	<%    
	if(pageNow != 1){   
    	out.println( " <a  href=User_info.jsp?pageNow=1>首页</a> ");   
    	out.println( " <a   href=User_info.jsp?pageNow="+(pageNow - 1)+">上一页</a> ");   
	}   
	if((pageNow != pageCount)&&(pageCount !=0)){   
	    out.println( " <a   href=User_info.jsp?pageNow="+ (pageNow + 1)+"> 下一页</a>");   
	    out.println( " <a   href=User_info.jsp?pageNow="+ pageCount+"> 最后一页</a>");   
	}   
%>  
</form>
</body>
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#btn").click(function(){
			$.ajax({
				type:'POST',
				url :'User_Add',
				data:{
					id:$("#user_id").val(),
					email:$("#user_email").val(),
					name:$("#user_name").val(),
					password:$("#user_password").val(),
				},
				success:function(data){
					alert("添加成功。");
					location.href='User_info.jsp';
				},
			});
		})
	})
	</script>
<script type="text/javascript">
	$(function(){
		$(".del").click(function(){
			var flag = confirm("确定要删除？");
			var x = $(this).parent().parent().find(".user_id");
			var y = x.eq(0).text();
			if (flag){
			$.ajax({
				type:'POST',
				url :'User_Del',
				data:{
					id:y,
				},
				success:function(data){
					alert("删除成功。");
					location.href='User_info.jsp';
				},
			});
		}
	})
})
</script>
<script type="text/javascript">
$(function(){           
    $(".edit").click(function(){
        var user_id = this.parentNode.parentNode.getElementsByTagName("td")[0];
        var user_name = this.parentNode.parentNode.getElementsByTagName("td")[1];
        var user_password = this.parentNode.parentNode.getElementsByTagName("td")[2];
        var user_email = this.parentNode.parentNode.getElementsByTagName("td")[3];
        if(this.value == "编辑"){
            this.value = "确定";
            //user_id.innerHTML ="<input value='"+user_id.innerHTML+"'/>";
            user_name.innerHTML ="<input value='"+user_name.innerHTML+"'/>";
            user_password.innerHTML ="<input value='"+user_password.innerHTML+"'/>";
            user_email.innerHTML ="<input value='"+user_email.innerHTML+"'/>";
        }else{
        	//user_id.innerHTML =user_id.getElementsByTagName("input")[0].value;
        	user_name.innerHTML =user_name.getElementsByTagName("input")[0].value;
        	user_password.innerHTML =user_password.getElementsByTagName("input")[0].value;
        	user_email.innerHTML =user_email.getElementsByTagName("input")[0].value;
        	$.ajax({
        		type:'POST',
				url :'User_Edit',
				data:{
					id:user_id.innerHTML,
					name:user_name.innerHTML,
					password:user_password.innerHTML,
					email:user_email.innerHTML,
				},
				success:function(data){
					alert("修改成功。");
					location.href='User_info.jsp';
				},
        	});
            this.value = "编辑";
        }
    })
}); 
</script>
</html>