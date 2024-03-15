package com.data;

/**
 methods:




 	************** Implemented **********************
 	
 	public boolean createBlog(Blog b);
 	public Blog getBlog(int blogId);
 	public Blog getBlogPromo(int blogId);
 	public boolean deleteBlog(int blogId);
  	public int getCountOfBlogs();
	private int getFirstBlog();
	private int getLastBlog();
	public int getRandomBlogs();
	public String getAuthorName(int blogId);
	public boolean isValidBlog(int blogId);
	public int[] getBlogByAuthor(int authorId);
	public TreeSet<Integer> getBlogsByAuthor(int authorId)
	public boolean isLiked(int blogId,int uid)
	public int getTotalLikes(int blogId)
	
  *************** To BE Created *******************
 
 
 	
  
 */
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Base64;
import java.util.Date;
import java.util.Random;
import java.util.TreeSet;

import com.entities.Blog;

public class BlogData {
	Connection connection;

	public BlogData() {
	}

	public BlogData(Connection connection) {
		this.connection = connection;
	}

	public boolean createBlog(Blog blog) {
		boolean status = false;

		try (PreparedStatement pstmt = connection
				.prepareStatement("INSERT INTO blog.blogs (Author_id, Create_date, Blog_title, main_body, thumbnail, "
						+ "subtopic_1, image_1, sub_body_1, subtopic_2, image_2, sub_body_2, subtopic_3, image_3, sub_body_3) "
						+ "VALUES (?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {

			pstmt.setInt(1, blog.getAuthorId());
			pstmt.setString(2, blog.getTitle());
			pstmt.setString(3, blog.getBody());
			pstmt.setBlob(4, blog.getThumbnail());

			String[] subTopics = blog.getSubTopic();
			Blob[] images = blog.getImg();
			String[] subBodies = blog.getSubBody();

			for (int i = 0; i < 3; i++) {
				if (i < subTopics.length && subTopics[i] != null) {
					pstmt.setString(5 + i * 3, subTopics[i]);
				} else {
					pstmt.setNull(5 + i * 3, Types.VARCHAR);
				}

				if (i < images.length && images[i] != null) {
					pstmt.setBlob(6 + i * 3, images[i]);
				} else {
					pstmt.setNull(6 + i * 3, Types.BLOB);
				}

				if (i < subBodies.length && subBodies[i] != null) {
					pstmt.setString(7 + i * 3, subBodies[i]);
				} else {
					pstmt.setNull(7 + i * 3, Types.VARCHAR);
				}
			}

			pstmt.executeUpdate();
			System.out.println("Data stored successfully in MySQL database!");
			status = true;

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("Data store FAILED: " + e.getMessage());
		}
		return status;
	}

	public Blog getBlogPromo(int blogId) {
		Blog blog = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT Author_id,Blog_title,main_body,Create_date,thumbnail from blog_view where blog_id=?";
		try {
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, blogId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int authorId = rs.getInt("Author_id");
				String title = rs.getString("Blog_title");
				String body = rs.getString("main_body");
				Date createDate = rs.getTimestamp("Create_date");
				Blob imageBlob = rs.getBlob("thumbnail");
				String imageString = null;
				if (imageBlob != null) {
					byte[] imageData = imageBlob.getBytes(1, (int) imageBlob.length());
					imageString = Base64.getEncoder().encodeToString(imageData);
				}

				blog = new Blog(blogId, authorId, title, body, createDate, imageString);
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
		return blog;
	}

	public boolean deleteBlog(int blogId) {
		String query = "DELETE FROM blogs WHERE blog_id=?";
		try (PreparedStatement pstmt = connection.prepareStatement(query)) {
			pstmt.setInt(1, blogId);
			int rows = pstmt.executeUpdate();
			return rows > 0; // Returns true if at least one row was deleted
		} catch (SQLException e) {
			e.printStackTrace();
			return false; // Return false if an exception occurs
		}
	}

	// will be used for stats
	public int getCountOfBlogs() {
		String query = "SELECT COUNT(blog_id) AS blog_count FROM blog_view";
		try (PreparedStatement pstmt = connection.prepareStatement(query)) {
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt("blog_count");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	private int getFirstBlog() {
		String query = "SELECT blog_id FROM blog_view ORDER BY blog_id LIMIT 1";
		try (PreparedStatement pstmt = connection.prepareStatement(query)) {
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt("blog_id");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	private int getLastBlog() {
		String query = "SELECT blog_id FROM blog_view ORDER BY blog_id DESC LIMIT 1";
		try (PreparedStatement pstmt = connection.prepareStatement(query)) {
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt("blog_id");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int getRandomBlogs() {
		Random random = new Random();
		int num = random.nextInt(getFirstBlog(), getLastBlog() + 1);
		return num;
	}

	public String getAuthorName(int blogId) {
		String author = null;
		String query = "select fname,lname from user_view,blog_view where uid = Author_id and blog_id=?";
		try (PreparedStatement pstmt = connection.prepareStatement(query)) {
			pstmt.setInt(1, blogId);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					author = rs.getString("fname") + " " + rs.getString("lname");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return author;
	}

	public boolean isValidBlog(int blogId) {
		String query = "SELECT Blog_id FROM blog_view WHERE Blog_id=?";
		try {
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, blogId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// get Blogs By same Author
	public TreeSet<Integer> getBlogsByAuthor(int authorId) {
		TreeSet<Integer> ts = new TreeSet<Integer>();
		String query = "SELECT Blog_id FROM blog_view WHERE Author_id=?";
		try {
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, authorId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ts.add(rs.getInt("Blog_Id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ts;
	}

	public Blog getBlog(int blogId) {
		Blog blog = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT Blog_id, Author_id, Blog_title,main_body, Create_date, thumbnail,"
				+ "subtopic_1, image_1, sub_body_1, subtopic_2, image_2,"
				+ "sub_body_2, subtopic_3, image_3, sub_body_3 from blog_view where blog_id=?";
		try {
			pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, blogId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int authorId = rs.getInt("Author_id");
				Date createDate = rs.getTimestamp("Create_date");
				String title = rs.getString("Blog_title");
				String body = rs.getString("main_body");
				Blob thumbnail = rs.getBlob("thumbnail");
				Blob img[] = { rs.getBlob("image_1"), rs.getBlob("image_2"), rs.getBlob("image_3") };
				String subTopic[] = { rs.getString("subtopic_1"), rs.getString("subtopic_2"),
						rs.getString("subtopic_3") };
				String subBody[] = { rs.getString("sub_body_1"), rs.getString("sub_body_2"),
						rs.getString("sub_body_3") };

				blog = new Blog(blogId, authorId, title, body, createDate, thumbnail, img, subTopic, subBody);

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
		return blog;
	}

	public boolean isLiked(int blogId, int uid) {
		String query = "SELECT user_id FROM liked_table WHERE blog_id=? AND user_id=?";
		try {
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, blogId);
			pstmt.setInt(2, uid);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public int getTotalLikes(int blogId) {
		String query = "SELECT count(*) as count FROM blog.liked_table where blog_id=?";

		int like = 0;
		try {
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, blogId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				like = rs.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
		return like;

	}

}

/**
 
 
 */
