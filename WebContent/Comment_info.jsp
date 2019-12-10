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
	<table border="1" style="margin-top:10%;height:80%;text-align: center;border-collapse: separate;border-spacing: 3px 3px; border:1px solid #eaeaea;">
		<thead>
			<tr style="height:20px;background:#d5d5d5;color: #fff; text-align: center;">
				<td style="width:100px;">评论编号&nbsp;&nbsp;&nbsp;</td>
				<td style="width:150px;">评论时间&nbsp;&nbsp;&nbsp;</td>
				<td style="width:250px;">评论者账号&nbsp;&nbsp;&nbsp;</td>
				<td style="width:250px;">评论内容&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</thead>
	<%
		while(rs.next()) {
			String comment_id = rs.getString(1);
			String comment_time = rs.getString(2);
			String comment_people_id = rs.getString(3);
			String comment_content = rs.getString(4);
	%>
		<tbody style="background: #eaeaea; text-align: center;">                  
            <tr style="height:35px;background-color: white">         
            	<td><%=comment_id %></td>               
                <td><%=comment_time %></td>                        
                <td><%=comment_people_id %></td>                        
                <td><%=comment_content %></td>
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
</body>
</html>