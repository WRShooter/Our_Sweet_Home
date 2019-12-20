<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="login.DataMethod" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>   
    <title>上传图片</title>    
    <meta charset="utf-8"/>
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  </head>  
  <body>
      <div class="row">
          <div class="col-md-4"></div>
          <div class="col-md-4" style="margin-top: 15%;">
            <form class="form-horizontal" method="post"  action="ImageUpload" enctype="multipart/form-data" >
            <div class="form-group">        
                <div class="col-sm-10">
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
		<%if(rs.next()) {
			String pic_name = rs.getString(2); 
			session.setAttribute("pic_name", pic_name);
		%>
		<%
			} 
		%>
                	<img id="avatar_img" src="http://localhost:8080/Blog_System/GetImage?data=<%=session.getAttribute("pic_name") %>" style="widht:10%;height:10%;" class="img-circle" onerror="this.src='image/timg.jpeg'" onclick="imageOnClick()"/>
                	<input style="display:none" id="avatar_file" type="file" name="fileName" placeholder="上传图片">
                </div>      
                <button  class="btn btn-default" type="submit">上传</button>
            </div>
            </form>
          </div>
          <div class="col-md-4"></div>
      </div>  
  </body>
  <script src="js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
    document.getElementById("avatar_file").disabled=true;
    function imageOnClick(){
    	document.getElementById("avatar_file").disabled=false;
        $("#avatar_file").click();
        document.getElementById("avatar_file").disabled=true;
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