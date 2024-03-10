<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
<style>
.bg-gradient-primary {
	background-image: linear-gradient(to right, #6c5ce7, #fd79a8);
}
</style>
</head>
<body>
 	<!-- Navigation Bar -->
	<nav
		class="navbar navbar-expand-lg navbar-light bg-gradient-primary fixed-top">
		<div class="container">
			<a class="navbar-brand text-white" href="dashboard.jsp">EpicBlogs</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link text-white"
						href="#aboutUs">About Us</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="#featuredBlogs">Featured Blogs</a></li>
					<li class="nav-item"><a class="nav-link text-white"
						href="profile-page.jsp">Profile</a></li>
				</ul>
			</div>
		</div>
	</nav>
 
</body>
</html>