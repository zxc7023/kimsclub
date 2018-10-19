<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.0.2/TweenMax.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href=" ${pageContext.request.contextPath}/resources/css/default.css">
<link rel="stylesheet"
	href=" ${pageContext.request.contextPath}/resources/css/navigation.css">
<link rel="stylesheet"
	href=" ${pageContext.request.contextPath}/resources/css/dayoff/day_status.css">

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
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

				<div class="col-10  cont-wrap">
					<div class="row">
						<div class="col-10 day_status">
								<!-- Nav tabs -->
								<ul class="nav nav-tabs" role="tablist">
									<li role="presentation" >
										<a href="#home" aria-controls="home" role="tab" data-toggle="tab" class="active">내휴가 </a>
									</li>
									<li role="presentation">
										<a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">휴가캘린더 </a>
									</li>
									<li role="presentation">
										<a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">휴가신청관리 </a>
									</li>
								</ul>

								<!-- Tab panes -->
								<div class="tab-content">
									<div role="tabpanel" class="tab-pane active" id="home">kjhjhgjhgjkh.</div>
									<div role="tabpanel" class="tab-pane" id="profile">123123123.</div>
									<div role="tabpanel" class="tab-pane" id="messages">adsfadsfasdf.</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	</section>

</body>
</html>