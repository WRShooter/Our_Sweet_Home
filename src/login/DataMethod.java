package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DataMethod {
	public boolean isSuccess_User(Connection conn, String userName, String password) throws SQLException {
		boolean flag;
		PreparedStatement stmt = conn.prepareStatement("select * from user where user_name=? and password=?");
		stmt.setString(1, userName);
		stmt.setString(2, password);
		ResultSet rs=stmt.executeQuery();
		if(rs.next()){
			flag=true;
		} else {
			flag=false;
		}
		rs.close();
		stmt.close();
		conn.close();
		return flag;
	}
	
	public boolean isSuccess_Manager(Connection conn, String manager_name, String manager_password) throws SQLException {
		boolean flag;
		PreparedStatement stmt = conn.prepareStatement("select * from manager where manager_name=? and manager_password=?");
		stmt.setString(1, manager_name);
		stmt.setString(2, manager_password);
		ResultSet rs=stmt.executeQuery();
		if(rs.next()){
			flag=true;
		} else {
			flag=false;
		}
		rs.close();
		stmt.close();
		conn.close();
		return flag;
	}
	
	public boolean ifExist(Connection conn, String userName) throws SQLException {
		boolean flag;
		PreparedStatement stmt = conn.prepareStatement("select * from user where user_name=?");
		stmt.setString(1, userName);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			flag = true;
		} else {
			flag = false;
		}
		rs.close();
		stmt.close();
		conn.close();
		return flag;
	}
	
	public void Update(Connection conn, String userName, String password) throws SQLException {
		PreparedStatement stmt = conn.prepareStatement("update user set password=? where user_name=?");
		stmt.setString(2, userName);
		stmt.setString(1, password);
		stmt.executeUpdate();
		stmt.close();
		conn.close();
	}
	
	public void Insert(Connection conn, String userName, String password, String email) throws SQLException {
		PreparedStatement stmt = conn.prepareStatement("insert into user(user_name,password,user_email) values(?,?,?)");
		stmt.setString(1, userName);
		stmt.setString(2, password);
		stmt.setString(3, email);
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();
	}
	
	public Connection DataConn() throws SQLException, ClassNotFoundException {
		DataValue value = new DataValue();
		Class.forName("com.mysql.jdbc.Driver");
		String url=value.GetDataBaseValue_Url();
		String loginName=value.GetDataBaseValue_loginName();
		String loginPass=value.GetDataBaseValue_loginPass();
		Connection conn=DriverManager.getConnection(url,loginName,loginPass);
		return conn;
	}
}
