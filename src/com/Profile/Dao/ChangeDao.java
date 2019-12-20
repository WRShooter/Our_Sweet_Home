package com.Profile.Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;

import com.Profile.Entity.ProfileEntity;

public class ChangeDao {
	@SuppressWarnings("resource")
	public static void ProfileChange(ProfileEntity profile) {
		String url = "jdbc:mysql://localhost:3306/users?serverTimezone=UTC";
		String uname = "root";
		String upwd = "tp52006211999";
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(url,uname,upwd);
			String sql1 = "update profile set intro=? where manager_name=?";
			pstmt = connection.prepareStatement(sql1);
			pstmt.setString(1, profile.getIntro());
			pstmt.setString(2, profile.getManager_name());
			pstmt.executeUpdate();

			String sql2 = "update profile set name=? where manager_name=?";
			pstmt = connection.prepareStatement(sql2);
			pstmt.setString(1, profile.getName());
			pstmt.setString(2, profile.getManager_name());
			pstmt.executeUpdate();
			
			String sql3 = "update profile set gender=? where manager_name=?";
			pstmt = connection.prepareStatement(sql3);
			pstmt.setString(1, profile.getGender());
			pstmt.setString(2, profile.getManager_name());
			pstmt.executeUpdate();
			
			String sql4 = "update profile set birthday=? where manager_name=?";
			pstmt = connection.prepareStatement(sql4);
			pstmt.setString(1, profile.getBirthday());
			pstmt.setString(2, profile.getManager_name());
			pstmt.executeUpdate();
			
			String sql5 = "update profile set location=? where manager_name=?";
			pstmt = connection.prepareStatement(sql5);
			pstmt.setString(1, profile.getLocation());
			pstmt.setString(2, profile.getManager_name());
			pstmt.executeUpdate();
			
			String sql6 = "update profile set occupational=? where manager_name=?";
			pstmt = connection.prepareStatement(sql6);
			pstmt.setString(1, profile.getOccupational());
			pstmt.setString(2, profile.getManager_name());
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if(connection!=null)
				try {
					connection.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
	}
	
}
