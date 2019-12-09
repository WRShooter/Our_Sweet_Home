package login;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.mail.util.MailSSLSocketFactory;


/**
 * Servlet implementation class send_email
 */
@WebServlet("/send_email")
public class send_email extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public send_email() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("邮箱发送功能");
		try {
			String email = request.getParameter("email");
			Mail.receiveMailAccount = email; 
 
			Properties props = new Properties();
			props.setProperty("mail.debug", "true");
			props.setProperty("mail.smtp.auth", "true");
			props.setProperty("mail.host", Mail.emailSMTPHost);
			props.setProperty("mail.transport.protocol", "smtp");
			MailSSLSocketFactory sf = new MailSSLSocketFactory();
	        sf.setTrustAllHosts(true);
			props.put("mail.smtp.ssl.enable", "true");
	        props.put("mail.smtp.ssl.socketFactory", sf);
			
 
			Session session = Session.getInstance(props);
			// 设置debug，可以查看详细的发送log
			session.setDebug(true);
			// 3、创建一封邮件
			String code = CreateRandom.getRandom();
			System.out.println("邮箱验证码：" + code);
			String html = content.html(code);
			MimeMessage message = Mail.creatMimeMessage(session, Mail.emailAccount,
					Mail.receiveMailAccount, html);
 
			Transport transport = session.getTransport();
			transport.connect(Mail.emailAccount, Mail.emailPassword);
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();
			request.getSession().setAttribute("code", code);
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("error", "邮件发送失败");
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
