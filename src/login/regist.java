package login;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class regist
 */
@WebServlet("/regist_Manager")
public class regist extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public regist() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		String manager_Name = request.getParameter("manager_Name");
		String manager_Password1 = request.getParameter("manager_Password1");
		String manager_Password2 = request.getParameter("manager_Password2");
		String manager_email = request.getParameter("manager_email");
		String yanzhengma = request.getParameter("yanzhengma");
		String email_code = (String)request.getSession().getAttribute("code");
		if(manager_Name == "") {
			String script = "<script>alert('账号不能为空！！！');location.href='regist_Manager.jsp'</script>";
			response.getWriter().println(script);
		} else if (manager_Password1 == "") {
			String script = "<script>alert('密码不能为空！！！');location.href='regist_Manager.jsp'</script>";
			response.getWriter().println(script);
		} else if (manager_Password2 == "") {
			String script = "<script>alert('请确认密码！！！');location.href='regist_Manager.jsp'</script>";
			response.getWriter().println(script);
		} else if (manager_email == "") {
			String script = "<script>alert('邮箱不能为空！！！');location.href='regist_Manager.jsp'</script>";
			response.getWriter().println(script);
		} else if (yanzhengma == ""){
			String script = "<script>alert('验证码不能为空！！！');location.href='regist_Manager.jsp'</script>";
			response.getWriter().println(script);
		} else {
			DataMethod method = new DataMethod();
			try {
				if(!method.ifExist(method.DataConn(), manager_Name)) {
					if(manager_Password1.equals(manager_Password2)) {
						if(email_code.equals(yanzhengma)) {
							method.Insert_Manager(method.DataConn(), manager_Name, manager_Password1, manager_email);
							method.insertManagerName(method.DataConn(), manager_Name, manager_email);
							String script = "<script>alert('注册成功。');location.href='Manager_login.jsp'</script>";
							response.getWriter().println(script);
						} else {
							String script = "<script>alert('请输入正确的验证码！！！');location.href='regist_Manager.jsp'</script>";
							response.getWriter().println(script);
						}
						//response.sendRedirect("login.jsp");
					} else {
						String script = "<script>alert('两次输入密码不相同！！！');location.href='regist_Manager.jsp'</script>";
						response.getWriter().println(script);
					}
				} else {
					String script = "<script>alert('账号已经存在，请重新输入！！！');location.href='regist_Manager.jsp'</script>";
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
