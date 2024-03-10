package com.data;

import java.sql.Blob;

/**
methods : 


	public boolean createUser(User us);
	public boolean deleteUser(int id);
	public int getUid(String username); 
	public User getUser(int uid);	// no pass

	*****************To BE Created **************
		
	update password ;
	

*/

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.entities.User;

public class UserData {
	Connection connection;

	public UserData(Connection connection) {

		super();
		this.connection = connection;
	}

	public int createUser(User us) {
		int status = 0;

		try {
			String query = "INSERT INTO user(username,password,fname,lname,phone,gender,profile_photo) VALUES (?,?,?,?,?,?,?)";
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setString(1, us.getUsername());
			pstmt.setString(2, us.getPassword());
			pstmt.setString(3, us.getFname());
			pstmt.setString(4, us.getLname());
			pstmt.setString(5, us.getPhone());
			pstmt.setString(6, us.getGender());
			pstmt.setBlob(7, us.getProfilePhoto());
			pstmt.executeUpdate();
			status = getUid(us.getUsername());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	public int getUid(String username) {

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT uid FROM  blog.user_view WHERE username=?";
		try {
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, username);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int uid = rs.getInt(1);
				return uid;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return 0;
	}

	public boolean deleteUser(int id) {

		boolean status = false;

		try {
			String query = "DELETE FROM user WHERE user_id=?";
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, id);
			pstmt.execute();
			status = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return status;
	}

	public User getUser(int userId) {

		User user = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT * from blog.user_view where uid=?";
		try {
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, userId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int uid = rs.getInt("uid");
				String uname = rs.getString("username");
				String fname = rs.getString("fname");
				String lname = rs.getString("lname");
				String phone = rs.getString("phone");
				String gender = rs.getString("gender");
				Blob image = rs.getBlob("profile_photo");
				user = new User(uid, uname, fname, lname, phone, gender, image);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return user;
	}
	
	public int getLogin(String username, String password) {
		try {
			String query = "select uid from User where username=? AND password=?";
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt("uid");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}
