package com.servlet;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.data.BlogData;

@WebServlet
public class LikeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Connection conn = (Connection) session.getAttribute("db");
		int blog_id = Integer.parseInt(request.getParameter("blog-id"));
		int user_id = Integer.parseInt(request.getParameter("user-id"));
		PreparedStatement pstmt = null;
		BlogData data = new BlogData(conn);
		Boolean status = data.isLiked(blog_id, user_id);
		String query = "";

		if (status) {
			query = "DELETE FROM blog.liked_table WHERE user_id =? and blog_id =?";
		} else {
			query = "INSERT INTO blog.liked_table(user_id,blog_id) VALUES (?,?)";

		}

		try {

			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, user_id);
			pstmt.setInt(2, blog_id);
			int k = pstmt.executeUpdate();
			if (k > 0)
				System.out.println("Success");
			else
				System.out.println("Failed");

		} catch (Exception e) {
			e.printStackTrace();
		}
	    session.setAttribute("blogId", blog_id);
		response.sendRedirect("view-blog.jsp");
	}

}
