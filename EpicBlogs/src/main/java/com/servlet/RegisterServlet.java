package com.servlet;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.SQLException;
import com.data.UserData;
import com.entities.User;

//Sessions to be add 
@WebServlet
@MultipartConfig
public class RegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection connection = null;
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String username = request.getParameter("mail");
		String password = request.getParameter("password");
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		Blob profilePic = null;
		Part filePart = request.getPart("profile-pic");
		if (filePart != null) {
			InputStream inputStream = filePart.getInputStream();

			try {
				connection = (Connection) request.getAttribute("db");
				profilePic = connection.createBlob();
				profilePic.setBytes(1, inputStream.readAllBytes());
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		int uid = 0;
		System.out.println(
				fname + "\n" + lname + "\n" + username + "\n" + password + "\n" + gender + "\n" + phone + "\n");
		User user = new User();
		user.setFname(fname);
		user.setLname(lname);
		user.setUsername(username);
		user.setPassword(password);
		user.setGender(gender);
		user.setPhone(phone);
		user.setProfilePhoto(profilePic);
		try {
			UserData newUser = new UserData(connection);
			uid = newUser.createUser(user);
			if (uid != 0) {
				user.setUid(uid);
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				session.setAttribute("user-id", uid);
				session.setAttribute("login-status", true);
				response.sendRedirect("dashboard.jsp");
			} else {
				System.out.println("User creation failed");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (connection != null)
					connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
