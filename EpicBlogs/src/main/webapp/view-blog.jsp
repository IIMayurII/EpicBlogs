<!DOCTYPE html>
<%@page import="com.entities.User"%>
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
	int blogId = 0;
	if (request.getParameter("blogId") != null) {
		blogId = Integer.parseInt(request.getParameter("blogId"));
	} else {
		System.out.println((int)session.getAttribute("blogId"));
		blogId=(int)session.getAttribute("blogId");
	}
	User user = (User) session.getAttribute("user");
	BlogData data = new BlogData(conn);
	Blog blog = data.getBlog(blogId);

	Boolean isLike = data.isLiked(blogId, blog.getAuthorId());

	String author = data.getAuthorName(blogId);
	String thumbnail = null;
	Blob imgBlob[] = { null, null, null };
	String image[] = { null, null, null };
	imgBlob = blog.getImg();
	String[] subTopic = blog.getSubTopic();
	String[] subBody = blog.getSubBody();
	Blob imageBlob = blog.getThumbnail();

	if (imageBlob != null) {
		byte[] imageData = imageBlob.getBytes(1, (int) imageBlob.length());
		thumbnail = Base64.getEncoder().encodeToString(imageData);
	}

	for (int i = 0; i < 3; i++) {
		if (imgBlob[i] != null) {
	byte[] imageData = imgBlob[i].getBytes(1, (int) imgBlob[i].length());
	image[i] = Base64.getEncoder().encodeToString(imageData);
		}
	}
%>

<html>
<head>
<meta charset="UTF-8">
<title>Blog Post</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.23.0/themes/prism-okaidia.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<style>
body {
	font-family: 'Roboto', sans-serif;
	line-height: 1.6;
	color: #333;
	background-color: #f5f5f5;
}

h1 {
	font-size: 3rem;
	margin-bottom: 0.5em;
	color: #444;
	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
}

.lead {
	font-size: 1.5rem;
	margin-bottom: 2em;
	color: #444;
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
}

.card {
	border: none;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	border-radius: 5px;
	overflow: hidden;
	margin-bottom: 2em;
}

.card-header {
	background-color: #f9f9f9;
	border-bottom: none;
	padding: 1em;
	font-size: 1.2rem;
	font-weight: bold;
	color: #444;
}

.card-body {
	padding: 1.5em;
}

.card-text {
	font-size: 1.1rem;
	color: #444;
	line-height: 1.5;
}

.thumbnail {
	width: 100%;
	height: auto;
	margin-bottom: 2em;
	border-radius: 5px;
}

.like-button {
	font-size: 1.2rem;
	padding: 0.5em 1em;
	background-color: #444;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.btn.like-button {
	background-color: white;
	color: blue;
}

.btn.like-button.liked {
	background-color: blue;
	color: white;
}

.like-button:hover {
	background-color: #666;
}

.comments {
	border-top: 1px solid #ddd;
	padding-top: 2em;
	margin-top: 2em;
}

.tags {
	margin-top: 2em;
}

.related-posts {
	margin-top: 4em;
}
</style>
</head>
<body><%@include file="header.jsp"%>
	<div class="container mt-5 py-4">
		<div class="row">
			<div class="col-md-8 offset-md-2">
				<h1 class="text-center mb-4"><%=blog.getTitle()%></h1>
				<p class="lead text-center">
					Posted on
					<%=blog.getDate()%>
					by
					<%=author%></p>
				<img class="img-fluid thumbnail" <%if (thumbnail != null) {%>
					src="data:image/jpeg;base64, <%=thumbnail%>" <%} else {%>
					src="img/no-thumbnail.png" <%}%>>
				<p class="card-text" style="text-align: left;"><%=blog.getBody()%></p>
				<%
				for (int i = 0; i < 3 && subTopic[i] != null && subBody[i] != null; i++) {
				%>
				<div class="card">
					<div class="card-header">
						<%
						if (subTopic[i] != null) {
						%>
						<i class=" mr-2"></i> <span><%=subTopic[i]%></span>
						<%
						}
						%>
					</div>
					<div class="card-body" style="text-align: center;">
						<%
						if (image[i] != null) {
						%>
						<img src="data:image/jpeg;base64, <%=image[i]%>"
							class="img-fluid mb-3">
						<%
						}
						%>
						<%
						if (subBody[i] != null) {
						%>
						<p class="card-text" style="text-align: left;"><%=subBody[i]%></p>
						<%
						}
						%>
					</div>
				</div>
				<%
				}
				%>
				<form action="LikeServlet" method="post">
					<input type="hidden" name="blog-id" value="<%=blogId%>"> <input
						type="hidden" name="user-id" value="<%=user.getUid()%>">
					<button class="btn like-button <%=(isLike ? "liked" : "")%>"
						type="submit">
						<%=data.getTotalLikes(blogId)%>
						<i class="fas fa-thumbs-up mr-2"></i>
					</button>
					<input type="hidden" name="liked" value="<%=isLike%>">
				</form>



				<%-- <div class="d-flex justify-content-between align-items-center mt-5">
					<p class="lead"></p>
					<button class="btn like-button">
						<%=blog.getLikes()%>
						<i class="fas fa-thumbs-up mr-2"></i>
					</button>
				</div> --%>
			</div>
		</div>
		<div class="comments">
			<h2>Comments</h2>
			<ul class="list-unstyled">
				<li>
					<p>Lorem ipsum dolor sit amet, consectetur dipiscing elit.
						Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.
						Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis
						sagittis ipsum. Praesent mauris.</p>
					<p class="small text-muted">Posted by John Doe on Jan 1, 2023</p>
				</li>
				<li>
					<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
						Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.
						Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis
						sagittis ipsum. Praesent mauris.</p>
					<p class="small text-muted">Posted by Jane Doe on Dec 31, 2022</p>
				</li>
			</ul>
			<form>
				<div class="form-group">
					<label for="comment">Add a comment</label>
					<textarea class="form-control" id="comment" rows="3"></textarea>
				</div>
				<button type="submit" class="btn btn-primary">Post Comment</button>
			</form>
		</div>

		<div class="tags">
			<h2>Tags</h2>
			<ul class="list-inline">
				<li class="list-inline-item"><a href="#"
					class="badge badge-secondary">Tag 1</a></li>
				<li class="list-inline-item"><a href="#"
					class="badge badge-secondary">Tag 2</a></li>
				<li class="list-inline-item"><a href="#"
					class="badge badge-secondary">Tag 3</a></li>
			</ul>
		</div>


		<div class="related-posts">
			<h2>Also Read...</h2>
			<ul class="list-unstyled row">
				<li class="col-md-4">
					<div class="card">
						<img src="https://via.placeholder.com/350x150"
							class="card-img-top" alt="Related Post 1">
						<div class="card-body">
							<h5 class="card-title">Related Post 1</h5>
							<p class="card-text">Some quick example text to build on the
								card title and make up the bulk of the card's content.</p>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<%
	}
	%>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.23.0/prism.min.js"></script>

	<%@include file="footer.html"%>
</body>
</html>