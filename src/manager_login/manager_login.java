package manager_login;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.DataMethod;

/**
 * Servlet implementation class manager_login
 */
@WebServlet("/manager_login")
public class manager_login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public manager_login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		String manager_name = request.getParameter("manager_name");
		String manager_password = request.getParameter("manager_password");
		if(manager_name == "") {
			String script = "<script>alert('用户名不能为空！！！');location.href='Manager_login.jsp'</script>";
			response.getWriter().println(script);
		} else if (manager_password == "") {
			String script = "<script>alert('密码不能为空！！！');location.href='Manager_login.jsp'</script>";
			response.getWriter().println(script);
		} else {
			DataMethod method = new DataMethod();
			try {
				if(method.isSuccess_Manager(method.DataConn(), manager_name, manager_password)) {
					request.getSession().setAttribute("Manager_Name", manager_name);
					request.getSession().setAttribute("user_name", manager_name);
					response.sendRedirect("BlogManager.jsp");
				} else {
					String script = "<script>alert('用户名或密码错误，请重新登陆');location.href='Manager_login.jsp'</script>";
					response.getWriter().println(script);
				}
			} catch (ClassNotFoundException | SQLException e) {
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
