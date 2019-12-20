package Image;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.DataMethod;

@SuppressWarnings("serial")
@WebServlet("/GetImage")
public class GetImage extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String pic_name = request.getParameter("data");
        String sql="SELECT DATA FROM`image` WHERE pic_name=?";
        Connection con = null;
        try{
            con=new DataMethod().DataConn();
            PreparedStatement pre=con.prepareStatement(sql);
            pre.setString(1, pic_name);
            ResultSet re=pre.executeQuery();
            if(re.next()){
                Blob b=re.getBlob(1);
                response.setContentType("image/jpeg"); //设置返回的类型
                OutputStream out = response.getOutputStream();
                out.write(b.getBytes(1, (int) b.length()));//获取读取的数据写到返回中
                out.flush();
            }           
        }catch(Exception e){
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