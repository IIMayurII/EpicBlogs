package com.data;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Iterator;
import com.entities.Blog;
import com.DB.DBConnect;


public class BlogPromo {
	public static String generateBlogHTML(Iterator<Integer> iterator) {
		StringBuilder htmlBuilder = new StringBuilder();
		Connection conn=null;
		try {
			conn=DBConnect.getConnection();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		BlogData data=new BlogData(conn);
		int j = 0;
		while (iterator.hasNext()) {
			int blogId = iterator.next();
			Blog blog = data.getBlogPromo(blogId);
			String img = blog.getImageString();
			String body = blog.getBody();
			if (body.length() > 230) {
				body = body.substring(0, 230) + "...";
			}
			String author = data.getAuthorName(blogId);

			// Append HTML code for each blog entry
			htmlBuilder.append("<form action=\"view-blog.jsp\" method=\"post\" id=\"blog-form-" + j + "\">");
			htmlBuilder.append("<input type=\"hidden\" name=\"blogId\" value=\"" + blog.getBlog_id() + "\">");
			htmlBuilder.append("<button type=\"submit\" style=\"display: none;\"></button>");
			htmlBuilder.append("</form>");
			htmlBuilder.append("<div class=\"blog-container\" onclick=\"document.getElementById('blog-form-" + j
					+ "').submit();\">");
			if (img != null) {
				htmlBuilder.append("<img src=\"data:image/jpeg;base64, " + img + "\">");
			} else {
				htmlBuilder.append("<img src=\"img/no-thumbnail.png\">");
			}
			htmlBuilder.append("<div class=\"blog-info\">");
			htmlBuilder.append("<h3>" + blog.getTitle() + "</h3>");
			htmlBuilder.append("<p>" + body + "</p>");
			htmlBuilder.append("</div>");
			htmlBuilder.append("</div>");
			htmlBuilder.append("<i>by " + author + "</i>");
			htmlBuilder.append("<hr>");
			htmlBuilder.append("<br>");

			j++;
		}
		return htmlBuilder.toString();
	}
}
