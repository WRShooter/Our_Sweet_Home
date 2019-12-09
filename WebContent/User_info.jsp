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
		String sql = "select user_name,password,user_email from user limit ?,?";
		stmlt = conn.prepareStatement(sql);
		stmlt.setLong(1, start);
		stmlt.setLong(2, pageSize);
		rs = stmlt.executeQuery();
	%>
	<table border="1" style="height:80%;text-align: center;border-collapse: separate;border-spacing: 3px 3px; border:1px solid #eaeaea;">
		<thead>
			<tr style="background:#d5d5d5;color: #fff; text-align: center;">
				<td style="width:100px;"><h4>序号&nbsp;&nbsp;&nbsp;</h4></td>
				<td style="width:150px;"><h4>用户账号&nbsp;&nbsp;&nbsp;</h4></td>
				<td style="width:250px;"><h4>用户密码&nbsp;&nbsp;&nbsp;</h4></td>
				<td style="width:250px;"><h4>用户邮箱&nbsp;&nbsp;&nbsp;</h4></td>
			</tr>
		</thead>
	<%
		while(rs.next()) {
			String user_name = rs.getString(1);
			String user_password = rs.getString(2);
			String user_email = rs.getString(3);
	%>
		<tbody style="background: #eaeaea; text-align: center;">                  
            <tr style="background-color: white">         
            	<td></td>               
                <td><%=user_name %></td>                        
                <td><%=user_password %></td>                        
                <td><%=user_email %></td>
            </tr>                
		</tbody>
	<%
		}
	%>
	</table>
	<form   Action= ""   method= "post">   
	<%    
		for(int i=1;i<=pageCount;i++){   
    	out.println("<a href=User_info.jsp?pageNow="+i+">["+i+"]</a>");   
	}   
	if(pageNow != 1){   
    	out.println( " <a  href=User_info.jsp?pageNow=1>首页</a> ");   
    	out.println( " <a   href=User_info.jsp?pageNow="+(pageNow - 1)+">上一页</a> ");   
	}   
	if(pageNow != pageCount){   
	    out.println( " <a   href=User_info.jsp?pageNow="+ (pageNow + 1)+"> 下一页</a>");   
	    out.println( " <a   href=User_info.jsp?pageNow="+ pageCount+"> 最后一页</a>");   
	}   
%>  
</form>
</body>
<script type="text/javascript">
$(function(){
    //$('table tr:not(:first)').remove();
    var len = $('table tr').length;
    for(var i = 1;i<len;i++){
        $('table tr:eq('+i+') td:first').text(i);
    }
        
});
</script>
</html>