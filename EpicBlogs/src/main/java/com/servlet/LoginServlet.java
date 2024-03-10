package com.servlet;

import jakarta.servlet.ServletException;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import com.DB.DBConnect;
import com.data.UserData;
import com.entities.User;

@WebServlet
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		Connection conn = null;
		UserData data=null;

		try {
			conn = DBConnect.getConnection();
			data=new UserData(conn);
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		try {

			int uid =data.getLogin(username, password);
			if (uid != 0) {
				User user = data.getUser(uid);
				HttpSession session = request.getSession();
				session.setAttribute("db", conn);
				session.setAttribute("login-status", true);
				session.setAttribute("user-id", uid);
				session.setAttribute("user", user);
				response.sendRedirect("dashboard.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		PrintWriter out = response.getWriter();
		out.println("<html><body>");
		out.println("<script>");
		out.println("alert('Invalid username or password. Please try again.');");
		out.println("window.location.href='index.jsp';");
		out.println("</script>");
		out.println("</body></html>");

	}
}
