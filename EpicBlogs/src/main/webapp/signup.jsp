<!DOCTYPE html>
<%
 if(session.getAttribute("login-status")!=null){
	 response.sendRedirect("dashboard.jsp");
 }
%> 

<html lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="robots" content="noindex, nofollow">

<title>Create account - EpicBlog</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="css/signup.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet">
<script>
function validateRegister() {
	const firstName = document.forms[1].elements["fname"].value;
	const lastName = document.forms[1].elements["lname"].value;
	const password = document.forms[1].elements["password"].value;
	const confirmPassword = document.forms[1].elements["confirmPassword"].value;

	if (!isAllText(firstName)) {
		alert("Please enter only alphabets for First Name.");
		return false;
	}
	if (!isAllText(lastName)) {
		alert("Please enter only alphabets for Last Name.");
		return false;
	}
	if (password.length < 6) {
		alert("Password must be at least 6 characters long.");
		return false;
	}
	if (password !== confirmPassword) {
		alert("Passwords do not match.");
		return false;
	}
	return true;
}

function isAllText(input) {
	const regex = /^[a-zA-Z]+$/;
	return regex.test(input);
}
</script>
</head>
<body>
	<div class="container register">
		<div class="row">
			<div class="col-md-3 register-left">
				<!-- <img src="" alt=""> -->
				<h3>Welcome</h3>
				<p>Already a user login in now</p>
				<form action="index.jsp" method="Post">
					<input type="submit" name="" value="Login"><br>
				</form>
			</div>
			<div class="col-md-9 register-right">
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="home" role="tabpanel"
						aria-labelledby="home-tab">
						<h3 class="register-heading">Register to EpicBlogs</h3></div>
						<form action="RegisterServlet" method="POST" onSubmit="return validateRegister()" enctype="multipart/form-data" >
							<div class="row register-form">
								<div class="col-md-6">
									<div class="form-group">
										<input required type="text" name="fname" class="form-control"
											placeholder="First Name *">
									</div>
									<div class="form-group">
										<input required type="text" name="lname" class="form-control"
											placeholder="Last Name *">
									</div>
									<div class="form-group">
										<input required type="password" name="password"
											class="form-control" placeholder="Password *">
									</div>
									
									<div class="form-group">
										<div class="maxl">
											<label class="radio inline"> <input type="radio"
												name="gender" value="male"> <span> Male </span>
											</label> <label class="radio inline"> <input type="radio"
												name="gender" value="female" checked="checked"> <span>Female
											</span>
											</label>
										</div>
									</div>
								</div>
								<div class="col-md-6">
								<!-- second side  -->
									<div class="form-group">
										<input type="email" required class="form-control"placeholder="Your Email *" name="mail">
									</div>
									<div class="form-group">
										<input type="text" maxlength="10" name="phone"class="form-control" required placeholder="Your Phone *">
									</div>
									<div class="form-group">
										<input required type="password" name="confirmPassword"
											class="form-control" placeholder="Confirm Password *">
									</div>
									<div class="form-group">
										<label for="image">Choose Profile photo:</label><br>
										<input type="file" id="image" name="profile-pic" accept="image/*">
									</div>
									<div>
										
								 	</div>
									<div class="form-group">
									    <input type="submit"  class="btnRegister" value="Register">
									 </div>
								</div>
							</div>
					  	</form>
					 </div>
				</div>
			</div>
		</div>
  </body>
</html>