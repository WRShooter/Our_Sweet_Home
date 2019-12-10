<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login.DataMethod" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>评论管理</title>
</head>
<body>
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
		String sql1 = "select count(*) from comment";
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
		String sql = "select comment_people_id,comment_time,comment_content,comment_id from comment limit ?,?";
		stmlt = conn.prepareStatement(sql);
		stmlt.setLong(1, start);
		stmlt.setLong(2, pageSize);
		rs = stmlt.executeQuery();
	%>
	<table border="1" style="margin-top:5%;text-align: center;border-collapse: separate;border-spacing: 3px 3px; border:1px solid #eaeaea;">
		<tr style="text-align: center;">
			<td style="width:100px;">评论编号&nbsp;&nbsp;&nbsp;</td>
			<td style="width:150px;">评论时间&nbsp;&nbsp;&nbsp;</td>
			<td style="width:200px;">评论者账号&nbsp;&nbsp;&nbsp;</td>
			<td style="width:200px;">评论主题&nbsp;&nbsp;&nbsp;</td>
		</tr>
		<tr>
			<td><input style="text-align:center;width:100px;" type="text" name="id" id="comment_id" placeholder="请输入评论id"></td>
			<td><input style="text-align:center;width:150px;" type="text" name="time" id="comment_time" placeholder="请输入评论时间"></td>
			<td><input style="text-align:center;width:200px;" type="text" name="people_id" id="comment_people_id" placeholder="请输入评论者id"></td>
			<td><input style="text-align:center;width:200px;" type="text" name="content" id="comment_content" placeholder="请输入评论内容"></td>
			<td><input type="button" id="btn" value="添加"/></td>
		</tr>
	</table>
	<table id="tb" border="1" style="margin-top:2%;height:80%;text-align: center;border-collapse: separate;border-spacing: 3px 3px; border:1px solid #eaeaea;">
		<thead>
			<tr style="height:20px;background:#d5d5d5;color: #fff; text-align: center;">
				<td style="width:100px;">评论编号&nbsp;&nbsp;&nbsp;</td>
				<td style="width:130px;">评论时间&nbsp;&nbsp;&nbsp;</td>
				<td style="width:150px;">评论者账号&nbsp;&nbsp;&nbsp;</td>
				<td style="width:200px;">评论内容&nbsp;&nbsp;&nbsp;</td>
				<td style="width:160px;">操作&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</thead>
	<%
		while(rs.next()) {
			String comment_id = rs.getString(4);
			String comment_time = rs.getString(2);
			String comment_people_id = rs.getString(1);
			String comment_content = rs.getString(3);
	%>
		<tbody style="background: #eaeaea; text-align: center;">                  
            <tr style="height:35px;background-color: white">         
            	<td class="comment_id"><%=comment_id %></td>               
                <td class="comment_time"><%=comment_time %></td>                        
                <td class="comment_people_id"><%=comment_people_id %></td>                        
                <td class="comment_content"><div style="width: 150px;white-space: nowrap;text-overflow: ellipsis; overflow: hidden;"><%=comment_content %></div></td>
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
				url :'Comment_Add',
				data:{
					id:$("#comment_id").val(),
					time:$("#comment_time").val(),
					people_id:$("#comment_people_id").val(),
					content:$("#comment_content").val(),
				},
				success:function(data){
					alert("添加成功。");
					location.href='Comment_info.jsp';
				},
			});
		})
	})
	</script>
<script type="text/javascript">
	$(function(){
		$(".del").click(function(){
			var flag = confirm("确定要删除？");
			var x = $(this).parent().parent().find(".comment_id");
			var y = x.eq(0).text();
			if (flag){
			$.ajax({
				type:'POST',
				url :'Comment_Del',
				data:{
					id:y,
				},
				success:function(data){
					alert("删除成功。");
					location.href='Comment_info.jsp';
				},
			});
		}
	})
})
</script>
<script type="text/javascript">
$(function(){           
	$(".edit").click(function(){
        var comment_id = this.parentNode.parentNode.getElementsByTagName("td")[0];
        var comment_time = this.parentNode.parentNode.getElementsByTagName("td")[1];
        var comment_people_id = this.parentNode.parentNode.getElementsByTagName("td")[2];
        var comment_content = this.parentNode.parentNode.getElementsByTagName("td")[3];
        if(this.value == "编辑"){
            this.value = "确定";
            //user_id.innerHTML ="<input value='"+user_id.innerHTML+"'/>";
            comment_time.innerHTML ="<input value='"+comment_time.innerHTML+"'/>";
            comment_people_id.innerHTML ="<input value='"+comment_people_id.innerHTML+"'/>";
            comment_content.innerHTML ="<input value='"+comment_content.innerHTML+"'/>";
        }else{
        	//user_id.innerHTML =user_id.getElementsByTagName("input")[0].value;
        	comment_time.innerHTML =comment_time.getElementsByTagName("input")[0].value;
        	comment_people_id.innerHTML =comment_people_id.getElementsByTagName("input")[0].value;
        	comment_content.innerHTML =comment_content.getElementsByTagName("input")[0].value;
        	$.ajax({
        		type:'POST',
				url :'Comment_Edit',
				data:{
					id:comment_id.innerHTML,
					time:comment_time.innerHTML,
					people_id:comment_people_id.innerHTML,
					content:comment_content.innerHTML,
				},
				success:function(data){
					location.href='Comment_info.jsp';
				},
        	});
            this.value = "编辑";
        }
    })
}); 
</script>
</html>