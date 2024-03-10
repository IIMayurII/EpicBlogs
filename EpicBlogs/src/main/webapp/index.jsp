<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
if (session.getAttribute("login-status") != null) {
	response.sendRedirect("dashboard.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/index.css">
<link rel="stylesheet" href="css/bootstrap.css">
<script src="js/index.js" type="text/javascript"></script>
<title>Login Page</title>


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body
	style="background-image: url('img/login-image.jpg'); background-repeat: no-repeat; background-size: 100% 100%; background-attachment: fixed;">
	<%
	if (session.getAttribute("logout") != null) {
	%>
	<script>
		alert("Logout Successful");
	</script>
	<%
	}
	session.removeAttribute("logout");
	%>

	<div class="login-container">
		<h1 class="mb-4">Login</h1>
		<form id="loginForm" action="LoginServlet" method="Post">
			<div class="form-group">
				<label for="username">Username:</label> <input type="text"
					class="form-control" name="username" id="username"
					placeholder="Enter your username">
			</div>
			<div class="form-group">
				<label for="password">Password:</label> <input type="password"
					class="form-control" name="password" id="password"
					placeholder="Enter your password">
			</div>
			<button type="submit" class="btn btn-primary btn-block">Sign
				In</button>
		</form>
		<p class="mt-3">
			New to this website? <a href="signup.jsp" class="create-account-link">Create
				New Account</a>
		</p>
	</div>

</body>
</html>



