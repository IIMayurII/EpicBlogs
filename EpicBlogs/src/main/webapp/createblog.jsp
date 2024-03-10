<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Write a new Blog</title>
<link href="css/bootstrap.css" rel="stylesheet">
<style>
.subtopic {
	border: 1px solid #ced4da;
	padding: 10px;
	border-radius: 5px;
	background-color: #f8f9fa;
}

.main-title {
	font-size: 24px;
	font-weight: bold;
}

.subtopic-title {
	font-size: 18px;
	font-weight: bold;
}

.subtopic-body {
	resize: vertical;
}

.container-form {
	background-color: #f0f0f0;
	padding: 20px;
	border-radius: 10px;
}
</style>
</head>
<body>
	<%
	if (session.getAttribute("login-status") == null) {
		response.sendRedirect("index.jsp");
	}
	%>
	<div class="container mt-5 container-form">
		<h2 class="main-title">Create a New Blog Post</h2>
		<form id="blog-form" action="create-blog" method="POST"
			enctype="multipart/form-data">
			<div class="form-group">
				<input type="text" id="blog-title" name="blog-title"
					class="form-control mb-3" placeholder="Blog Title *" required>
				<label for="thumbnail" class="d-block mb-3">Upload Thumbnail
					Image</label> <input type="file" id="thumbnail" name="thumbnail"
					class="form-control-file mb-3">
				<textarea id="main-body" style="height: 383px;" name="main-body"
					class="form-control mb-3" rows="6" placeholder="Main Body *"
					required></textarea>
				<div id="subtopics">
					<!-- Subtopic areas will be dynamically added here  -->
				</div>
				<button type="button" id="add-subtopic-btn"
					class="btn btn-primary mt-3">Add Subtopic</button>
				<input type="submit" class="btn btn-success mt-3" value="Submit">
			</div>
		</form>
	</div>

	<script>
		// Function to dynamically add subtopic area
		function addSubtopic() {
			var subtopicsDiv = document.getElementById('subtopics');
			var subtopicCount = subtopicsDiv.querySelectorAll('.subtopic').length + 1;

			if (subtopicCount <= 3) {
				var subtopicArea = document.createElement('div');
				subtopicArea.className = 'subtopic mb-3';
				subtopicArea.innerHTML = '<label for="topic" class="subtopic-title mb-2">Topic</label>'
						+ '<input type="text" id="topic" name="topic' + subtopicCount + '" class="form-control mb-2" placeholder="Topic Title *" required>'
						+ '<input type="file" id="topic-image" name="topic-image' + subtopicCount + '" class="form-control-file mb-2" accept="image/*">'
						+ '<textarea id="body" style="height: 383px;" name="body' + subtopicCount + '" class="form-control mb-3 subtopic-body" rows="6" placeholder="Topic Body *" required></textarea>'
						+ '<button type="button" class="btn btn-danger btn-sm remove-subtopic-btn" onclick="removeSubtopic(this)">Remove</button>';
				subtopicsDiv.appendChild(subtopicArea);
			}
			// Hide the button if three subtopics are added
			if (subtopicCount >= 3) {
				document.getElementById('add-subtopic-btn').style.display = 'none';
			}
		}

		// Function to remove a subtopic
		function removeSubtopic(button) {
			var subtopicContainer = button.parentNode;
			subtopicContainer.parentNode.removeChild(subtopicContainer);

			// Show the "Add Subtopic" button if less than three subtopics are present
			var subtopicCount = document.querySelectorAll('.subtopic').length;
			if (subtopicCount < 3) {
				document.getElementById('add-subtopic-btn').style.display = 'block';
			}
		}

		// Add event listener to the "Add Subtopic" button
		document.getElementById('add-subtopic-btn').addEventListener('click',
				addSubtopic);
	</script>
</body>
</html>