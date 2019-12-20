package login;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		String login_name=request.getParameter("user_name");
		String login_pwd=request.getParameter("user_password");
		if(login_name == "") {
			String script = "<script>alert('用户名不能为空！！！');location.href='login.jsp'</script>";
			response.getWriter().println(script);
		} else if (login_pwd == "") {
			String script = "<script>alert('密码不能为空！！！');location.href='login.jsp'</script>";
			response.getWriter().println(script);
		} else {
			DataMethod method = new DataMethod();
			try {
				if(method.isSuccess_User(method.DataConn(), login_name, login_pwd)) {
					request.getSession().setAttribute("user_name", login_name);
					response.sendRedirect("Image.jsp");
				} else {
					String script = "<script>alert('用户名或密码错误，请重新登陆');location.href='login.jsp'</script>";
					response.getWriter().println(script);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
