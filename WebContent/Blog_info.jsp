<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login.DataMethod" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>博客信息</title>
</head>
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
		String sql1 = "select count(*) from blog";
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
		String sql = "select blog_people_id,blog_title,blog_time,blog_id from blog limit ?,?";
		stmlt = conn.prepareStatement(sql);
		stmlt.setLong(1, start);
		stmlt.setLong(2, pageSize);
		rs = stmlt.executeQuery();
	%>
	<table border="1" style="margin-top:5%;text-align: center;border-collapse: separate;border-spacing: 3px 3px; border:1px solid #eaeaea;">
		<tr style="text-align: center;">
			<td style="width:100px;">博客编号&nbsp;&nbsp;&nbsp;</td>
			<td style="width:150px;">博客发表时间&nbsp;&nbsp;&nbsp;</td>
			<td style="width:200px;">博客发表人账号&nbsp;&nbsp;&nbsp;</td>
			<td style="width:200px;">博客主题&nbsp;&nbsp;&nbsp;</td>
		</tr>
		<tr>
			<td><input style="text-align:center;width:100px;" type="text" name="id" id="blog_id" placeholder="请输入博客id"></td>
			<td><input style="text-align:center;width:150px;" type="text" name="time" id="blog_time" placeholder="请输入博客发表时间"></td>
			<td><input style="text-align:center;width:200px;" type="text" name="people_id" id="blog_people_id" placeholder="请输入待添加的用户id"></td>
			<td><input style="text-align:center;width:200px;" type="text" name="title" id="blog_title" placeholder="请输入待添加的主题"></td>
			<td><input type="button" id="btn" value="添加"/></td>
		</tr>
	</table>
	<table id="tb" border="1" style="margin-top:2%;height:80%;text-align: center;border-collapse: separate;border-spacing: 3px 3px; border:1px solid #eaeaea;">
		<thead>
			<tr style="height:20px;background:#d5d5d5;color: #fff; text-align: center;">
				<td style="width:100px;">博客编号&nbsp;&nbsp;&nbsp;</td>
				<td style="width:130px;">博客发表时间&nbsp;&nbsp;&nbsp;</td>
				<td style="width:150px;">博客发表人账号&nbsp;&nbsp;&nbsp;</td>
				<td style="width:200px;">博客主题&nbsp;&nbsp;&nbsp;</td>
				<td style="width:160px;">操作&nbsp;&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</thead>
	<%
		while(rs.next()) {
			String blog_id = rs.getString(4);
			String blog_time = rs.getString(3);
			String blog_people_id = rs.getString(1);
			String blog_title = rs.getString(2);
	%>
		<tbody style="background: #eaeaea; text-align: center;">                  
            <tr style="height:35px;background-color: white">         
            	<td class="blog_id"><%=blog_id %></td>               
                <td class="blog_time"><%=blog_time %></td>                        
                <td class="blog_people_id"><%=blog_people_id %></td>                        
                <td class="blog_title"><div style="width: 150px;white-space: nowrap;text-overflow: ellipsis; overflow: hidden;"><%=blog_title %></div></td>
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
    	out.println( " <a  href=Blog_info.jsp?pageNow=1>首页</a> ");   
    	out.println( " <a   href=Blog_info.jsp?pageNow="+(pageNow - 1)+">上一页</a> ");   
	}   
	if((pageNow != pageCount)&&(pageCount != 0)){   
	    out.println( " <a   href=Blog_info.jsp?pageNow="+ (pageNow + 1)+"> 下一页</a>");   
	    out.println( " <a   href=Blog_info.jsp?pageNow="+ pageCount+"> 最后一页</a>");   
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
				url :'Blog_Add',
				data:{
					id:$("#blog_id").val(),
					time:$("#blog_time").val(),
					people_id:$("#blog_people_id").val(),
					title:$("#blog_title").val(),
				},
				success:function(data){
					alert("添加成功。");
					location.href='Blog_info.jsp';
				},
			});
		})
	})
	</script>
<script type="text/javascript">
	$(function(){
		$(".del").click(function(){
			var flag = confirm("确定要删除？");
			var x = $(this).parent().parent().find(".blog_id");
			var y = x.eq(0).text();
			if (flag){
			$.ajax({
				type:'POST',
				url :'Blog_Del',
				data:{
					id:y,
				},
				success:function(data){
					alert("删除成功。");
					location.href='Blog_info.jsp';
				},
			});
		}
	})
})
</script>
<script type="text/javascript">
$(function(){           
    $(".edit").click(function(){
        var blog_id = this.parentNode.parentNode.getElementsByTagName("td")[0];
        var blog_time = this.parentNode.parentNode.getElementsByTagName("td")[1];
        var blog_people_id = this.parentNode.parentNode.getElementsByTagName("td")[2];
        var blog_title = this.parentNode.parentNode.getElementsByTagName("td")[3];
        if(this.value == "编辑"){
            this.value = "确定";
            //user_id.innerHTML ="<input value='"+user_id.innerHTML+"'/>";
            blog_time.innerHTML ="<input value='"+blog_time.innerHTML+"'/>";
            blog_people_id.innerHTML ="<input value='"+blog_people_id.innerHTML+"'/>";
            blog_title.innerHTML ="<input value='"+blog_title.innerHTML+"'/>";
        }else{
        	//user_id.innerHTML =user_id.getElementsByTagName("input")[0].value;
        	blog_time.innerHTML =blog_time.getElementsByTagName("input")[0].value;
        	blog_people_id.innerHTML =blog_people_id.getElementsByTagName("input")[0].value;
        	blog_title.innerHTML =blog_title.getElementsByTagName("input")[0].value;
        	$.ajax({
        		type:'POST',
				url :'Blog_Edit',
				data:{
					id:blog_id.innerHTML,
					time:blog_time.innerHTML,
					people_id:blog_people_id.innerHTML,
					title:blog_title.innerHTML,
				},
				success:function(data){
					alert("修改成功。");
					location.href='Blog_info.jsp';
				},
        	});
            this.value = "编辑";
        }
    })
}); 
</script>
</html>