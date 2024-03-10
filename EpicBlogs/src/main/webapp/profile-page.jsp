<%@page import="com.entities.Blog"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.TreeSet"%>
<%@page import="com.data.BlogData"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.Blob"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.data.UserData"%>
<%@page import="com.entities.User"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User user = null;
String Image = null;
Connection conn = null;
BlogData data = null;

if (session.getAttribute("login-status") == null) {
	response.sendRedirect("index.jsp");
} else {

	conn = (Connection) session.getAttribute("db");
	user = (User) session.getAttribute("user");
	data = new BlogData(conn);

	Blob imageBlob = user.getProfilePhoto();
	if (imageBlob != null) {
		byte[] imageData = imageBlob.getBytes(1, (int) imageBlob.length());
		Image = Base64.getEncoder().encodeToString(imageData);
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Profile</title>
<link rel="stylesheet" href="css/font-awesome-5.15.4.css" />
<link rel="stylesheet" href="css/profile-page.css" />
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="website-name">
				<h1>
					<i>EpicBlogs</i>
				</h1>
			</div>
			<div class="profile">
				<img class="card-img-top " style="width: 50%; height: 90px;"
					<%if (Image != null) {%> src="data:image/jpeg;base64, <%=Image%>"
					<%} else {%> src="img/no-profile-pic.png" <%}%>> <span
					style="width: 200px;"> Welcome<br><%=user.getFname()%>
					<%=user.getLname()%></span>
			</div>
			<div>
				<div>
					<form action="LogoutServlet" method="post">
						<button style="width: 100%;" class="logout-btn">Logout</button>
					</form>
				</div>
				<div style="margin-top: 15px;">
					<button style="width: 100%;" class="logout-btn"
						onclick="toggleMessagesPanel()">Messages</button>
				</div>
			</div>
		</div>
		<div class="main-content">
			<div class="tabs">
				<button class="tab" data-tab="readlist"
					onclick="showTab('readlist')">Your Read List</button>
				<button class="tab" data-tab="writings"
					onclick="showTab('writings')">Your Writings</button>
				<button class="tab" data-tab="liked" onclick="showTab('liked')">Liked
					Posts</button>
				<button class="tab" data-tab="commented"
					onclick="showTab('commented')">Commented Posts</button>
			</div>
			<!-- Blogs by User -->

			<div id="writings" class="content">
				<h2>Your Blogs</h2>
				<%
				TreeSet<Integer> ts = data.getBlogsByAuthor(user.getUid());
				Iterator<Integer> i = ts.descendingIterator();
				Blog blog; //Blog blog = data.getBlog(n);
				int j = 0;
				while (i.hasNext()) {
					String img = null;
					int blogId = i.next();
					blog = data.getBlogPromo(blogId);
					String body = blog.getBody();
					if (body.length() > 230) {
						body = body.substring(0, 230) + "..."; //
					}
					imageBlob = blog.getThumbnail();
					if (imageBlob != null) {
						byte[] imageData = imageBlob.getBytes(1, (int) imageBlob.length());
						img = Base64.getEncoder().encodeToString(imageData);
					}
					String author = data.getAuthorName(blogId);
				%>
				<form action="view-blog.jsp" method="post" id="blog-form-<%=j%>">
					<input type="hidden" name="blogId" value="<%=blog.getBlog_id()%>">
					<button type="submit" style="display: none;"></button>
				</form>
				<div class="blog-container"
					onclick="document.getElementById('blog-form-<%=j%>').submit();">
					<img <%if (img != null) {%> src="data:image/jpeg;base64, <%=img%>"
						<%} else {%> src="img/no-thumbnail.png" <%}%>>
					<div class="blog-info">
						<h3><%=blog.getTitle()%></h3>
						<p><%=body%></p>
					</div>
				</div>
				<i>by <%=author%></i>
				<hr>
				<br>
				<%
				j++;
				}
				%>
			</div>

			<div id="readlist" class="content">
				<h2>Your Read List</h2>
				<div class="blog-container" onclick="">
					<img src="thumbnail1.jpg" alt="Thumbnail 1">
					<div class="blog-info">
						<h3>Read Article 1</h3>
						<p>Description of Read Article 1</p>
					</div>
				</div>
			</div>

			<div id="liked" class="content">
				<h2>Liked Posts</h2>
				<div class="blog-container" onclick="">
					<img src="thumbnail7.jpg" alt="Thumbnail 7">
					<div class="blog-info">
						<h3>Liked Article A</h3>
						<p>Description of Liked Article A</p>
					</div>
				</div>
			</div>

			<div id="commented" class="content">
				<h2>Commented Posts</h2>
				<div class="blog-container" onclick="">
					<img src="thumbnail10.jpg" alt="Thumbnail 10">
					<div class="blog-info">
						<h3>Commented on Article X</h3>
						<p>Description of Commented Article X</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Messages Panel -->
	<div class="messages-panel" id="messagesPanel">
		<div class="messages-header">
			<span>Messages</span> <span class="close-messages"
				onclick="toggleMessagesPanel()">&times;</span>
		</div>
		<div class="messages-list">
			<!-- Messages will be displayed here -->
			<div class="message">
				<p>Message 1</p>
			</div>
			<div class="message">
				<p>Message 2</p>
			</div>
			<div class="message">
				<p>Message 3</p>
			</div>
		</div>
	</div>

	<script>
		var tabs = document.querySelectorAll('.tab');

		tabs.forEach(function(tab) {
			tab.addEventListener('click', function() {
				tabs.forEach(function(tab) {
					tab.classList.remove('active');
				});

				this.classList.add('active');

				var contents = document.querySelectorAll('.content');
				contents.forEach(function(content) {
					content.classList.remove('active');
				});

				var tabName = this.getAttribute('data-tab');
				var content = document.getElementById(tabName);
				content.classList.add('active');
			});
		});

		function goToBlog(blogId) {
			alert("Redirecting to blog with ID: " + blogId);
		}

		function toggleMessagesPanel() {
			var messagesPanel = document.getElementById("messagesPanel");
			if (messagesPanel.style.right === "-400px") {
				messagesPanel.style.right = "0";
			} else {
				messagesPanel.style.right = "-400px";
			}
		}
	</script>
	<%
	}
	%>
</body>
</html>
