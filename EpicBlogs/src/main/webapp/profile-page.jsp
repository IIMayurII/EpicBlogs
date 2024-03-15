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
<%@page import="com.data.BlogPromo"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User user = null;
String Image = null;
Connection conn = null;
BlogData data = null;
TreeSet<Integer> ts =null; 

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
				<%ts= data.getBlogsByAuthor(user.getUid()); %>
				<%=BlogPromo.generateBlogHTML(ts.descendingIterator())%>
			</div>

		

			<div id="readlist" class="content">
				<h2>Your Read List</h2>
				<% ts = data.getBlogsByAuthor(user.getUid()); %>
				<%=BlogPromo.generateBlogHTML(ts.descendingIterator())%>
			</div>

			<div id="liked" class="content">
				<h2>Liked Posts</h2>
				<% ts = data.getBlogsByAuthor(user.getUid()); %>
				<%=BlogPromo.generateBlogHTML(ts.descendingIterator())%>
			</div>

			<div id="commented" class="content">
				<h2>Commented Posts</h2>
				<% ts = data.getBlogsByAuthor(user.getUid()); %>
				<%=BlogPromo.generateBlogHTML(ts.descendingIterator())%>
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
