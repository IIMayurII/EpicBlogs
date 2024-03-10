
package com.servlet;

import java.io.IOException;

import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.SQLException;
import com.DB.DBConnect;
import com.data.BlogData;
import com.entities.Blog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet
@MultipartConfig
public class CreateBlogServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Connection connection = null;

        try {
            connection = DBConnect.getConnection();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        // Redirect to index.jsp if not logged in
        if (session.getAttribute("login-status") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Get author ID from session
        int authorId = (int) session.getAttribute("user-id");

        // Get blog title and body from request parameters
        String title = request.getParameter("blog-title");
        String body = request.getParameter("main-body");

        // Get thumbnail image from request
        Part thumbnailPart = request.getPart("thumbnail");
        Blob thumbnailBlob = null;
        if (thumbnailPart != null && thumbnailPart.getSize() > 0) {
            try (InputStream inputStream = thumbnailPart.getInputStream()) {
                thumbnailBlob = connection.createBlob();
                thumbnailBlob.setBytes(1, inputStream.readAllBytes());
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Get subtopics from request
        String topic[]= {"","",""};
        String topicBody[]= {"","",""};
        Blob[] img= {null,null,null};
        
        /*
          Enumeration<String> para =request.getParameterNames();
        while (para.hasMoreElements()) {
			String str = (String) para.nextElement();
			System.out.println("string : "+str);
		}
		*/
        
        for (int i = 0; i < 3; i++) { 
             topic[i] = request.getParameter("topic" + (i+1));
            topicBody[i] = request.getParameter("body" + (1+i));
            Part topicImagePart = request.getPart("topic-image" + (1+i));
            if (topicImagePart != null && topicImagePart.getSize() > 0) {
                try (InputStream inputStream = topicImagePart.getInputStream()) {
                    img[i] = connection.createBlob();
                    img[i].setBytes(1, inputStream.readAllBytes());
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
           
        }

        // Create blog object
        Blog blog = new Blog(authorId, title, body, thumbnailBlob,topic,topicBody,img);

        // Save blog to database
        try {
            BlogData blogData = new BlogData(DBConnect.getConnection());
            if (blogData.createBlog(blog)) {
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("createblog.jsp");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("createblog.jsp"); // Redirect to createblog.jsp on error
        }
    }
}
