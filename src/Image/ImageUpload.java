package Image;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import login.DataMethod;

@SuppressWarnings("serial")
@WebServlet("/ImageUpload")
public class ImageUpload extends HttpServlet {

    /**
     * 获取上传文件
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //设置读取上传文件文件的缓存
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload sfu = new ServletFileUpload(factory);
        sfu.setHeaderEncoding("UTF-8");//设置字符
        sfu.setSizeMax(10*1024*1024);//上传文件最大10m
        Connection con=null;        
        try {
            con=new DataMethod().DataConn();
            List<FileItem> items = sfu.parseRequest(request);//获取上传的文件名
            PreparedStatement pre=null;
            PreparedStatement pre1=null;
            PreparedStatement pre2=null;
            String user_name = (String) request.getSession().getAttribute("user_name");
            String sql1 = "Update image set data=?,pic_name=? where user_name=?";
            String sql2 = "select * from image where user_name=?";
            String sql="INSERT INTO `image`(user_name,pic_name,data) VALUE(?,?,?)";
            for(FileItem fileItem:items){//将上传的所有文件保存到mysql数据库          
                 String name = fileItem.getName();// name属性值
                 pre2=con.prepareStatement(sql2);
                 pre2.setString(1, user_name);
                 ResultSet rs = pre2.executeQuery();
                 if(rs.next()) {
                	 pre=con.prepareStatement(sql1);
                     pre.setString(3, user_name);
                     pre.setString(2, name);
                     pre.setBlob(1, fileItem.getInputStream());
                     pre.executeUpdate();
                     pre.close();
                     response.sendRedirect("http://localhost:8080/Blog_System/personal_data.jsp");
                 } else {
                	 pre1=con.prepareStatement(sql);
                     pre1.setString(1, user_name);
                     pre1.setString(2, name);
                     pre1.setBlob(3, fileItem.getInputStream());
                     pre1.executeUpdate();
                     pre1.close();
                     //request.getSession().setAttribute("name", URLEncoder.encode(name, "UTF-8"));
                     response.sendRedirect("http://localhost:8080/Blog_System/personal_data.jsp");
                 }
                 
            }           
        } catch (Exception e) {         
            response.sendRedirect("http://localhost:8080/Upload_Pic/Image.jsp?data="+e.getMessage());//失败携带异常信息返回上传页面
            e.printStackTrace();
        }finally{
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }       
    }
}

