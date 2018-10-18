<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.0.2/TweenMax.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href=" ${pageContext.request.contextPath}/resources/css/default.css">
<link rel="stylesheet" href=" ${pageContext.request.contextPath}/resources/css/navigation.css">
<link rel="stylesheet" href=" ${pageContext.request.contextPath}/resources/css/dayoff/day_selection.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<script>
	$(document).ready(function() {
		$('.tab-pane').click(function(e) {
			e.preventDefault()
			$(this).tab('show')
		})
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<section>

		<section>
			<div class="container-fluid">
				<div class="row">
					<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>
				</div>
				<div class="col-10 back cont-wrap">
					<div role="tabpanel">

						<!-- Nav tabs -->
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Home</a></li>
							<li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Profile</a></li>
							<li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Messages</a></li>
							<li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Settings</a></li>
						</ul>

						<!-- Tab panes -->
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane active" id="home">...</div>
							<div role="tabpanel" class="tab-pane" id="profile">...</div>
							<div role="tabpanel" class="tab-pane" id="messages">...</div>
							<div role="tabpanel" class="tab-pane" id="settings">...</div>
						</div>

					</div>
				</div>
			</div>
		</section>
	</section>

</body>
</html>