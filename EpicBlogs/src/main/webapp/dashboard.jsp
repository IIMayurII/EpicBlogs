<!DOCTYPE html>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.TreeSet,java.util.Iterator"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.data.BlogData ,com.entities.Blog"%>
<%
Connection conn = null;
if (session.getAttribute("login-status") == null) {
	response.sendRedirect("index.jsp");
} else {
	conn = (Connection) session.getAttribute("db");
	
%>

<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>EpicBlogs Dashboard</title>
<link href="css/bootstrap.css" rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
.bg-gradient-primary {
	background-image: linear-gradient(to right, #6c5ce7, #fd79a8);
}

body {
	padding-top: 150px;
	background-image: url('img/dashboard-image.jpg');
	background-repeat: no-repeat;
	background-size: 100% 100%;
	background-attachment: fixed;
}
</style>
</head>
<body>
	<%@include file="header.jsp" %>
	<div class="container mt-5 py-4">
		<div class="row">
			<div class="col-lg-12 text-center">
				<h1>Welcome to EpicBlogs</h1>
				<p class="lead">Discover and share amazing stories.</p>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<!-- Action Buttons -->
	<div class="container mb-10 mt-4">
		<div class="row">
			<div class="col-lg-6 text-center">
				<a href="createblog.jsp" class="btn btn-primary btn-lg"
					id="createBlogBtn">Create New Blog</a>
			</div>
			<div class="col-lg-6 text-center">
				<a href="#featuredBlogs" class="btn btn-success btn-lg">Read
					Existing Blogs</a>
			</div>
		</div>
	</div>

	<!-- Blog Thumbnails Section -->
	<div class="container mt-4">
		<%
		for (int i = 0; i < 5; i++)
			out.print("<br>");
		%>
		<h3 id="featuredBlogs" style="text-align: center; margin-top: 20px;">Featured
			Blogs</h3>
		<div class="row mt-10">
			<%
			// in this block random blogs will be accessed from database
			BlogData data = new BlogData(conn);
			TreeSet<Integer> ts = new TreeSet<Integer>();
			while (ts.size() != 3) {
				int n = data.getRandomBlogs();
				if (data.isValidBlog(n))
					ts.add(n);
			}
			Iterator<Integer> i = ts.descendingIterator();
			Blog blog; //Blog blog = data.getBlog(n);
			while (i.hasNext()) {
				String Image = null;
				blog = data.getBlogPromo(i.next());
				String body = blog.getBody();
				String author = data.getAuthorName(blog.getBlog_id());

				if (body.length() > 135) {
					body = body.substring(0, 135) + "..."; //
				}
				Blob imageBlob = blog.getThumbnail();
				if (imageBlob != null) {
					byte[] imageData = imageBlob.getBytes(1, (int) imageBlob.length());
					Image = Base64.getEncoder().encodeToString(imageData);
				}
			%>

			<div class="col-lg-4 mb-4">
				<div class="card">
					<div>
						<img class="card-img-top " style="width: 100%; height: 200px;"
							<%if (Image != null) {%> src="data:image/jpeg;base64, <%=Image%>"
							<%} else {%> src="img/no-thumbnail.png" <%}%>>

					</div>
					<div class="card-body" style="height: 300px; width: 300px">
						<h4 class="card-title"><%=blog.getTitle()%></h4>
						<h6 class="card-title">
							by
							<%=author%></h6>
						<p class="card-text"><%=body%></p>
					</div>
					<div align="right" class="mb-2 mr-2">
						<form action="view-blog.jsp" method="post">
							<input type="hidden" name="blogId" value="<%=blog.getBlog_id()%>">
							<button type="submit" class="btn btn-primary">Read More</button>
						</form>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</div>
	<section id="aboutUs" class="py-5 bg-light">
		<div class="container">
			<h2 class="mb-4">About Us</h2>
			<p>EpicBlogs is a community of bloggers who love to share their
				knowledge, experience, and passion with the world. Our mission is to
				provide high-quality blog posts on various topics, including
				technology, design, lifestyle, and much more.</p>
			<p>Feel free to explore our blog posts and join our community by
				creating your own profile. We welcome bloggers of all levels and
				backgrounds.</p>
		</div>
	</section>
	<%@include file="footer.html"%>
</body>
</html>
