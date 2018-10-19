<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<!-- header 및 navigation을 불러오기 위해서 사용해야하는 자원들 아래 다 복사해서 붙여넣기 하세요. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap Core CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Core CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>

<style type="text/css">
.btn-i {
border-right: 1px white;
}
</style>
<script>
	$(document).ready(function() {
		$('.check-all').click(function() {
			$('.check').prop('checked', this.checked);
		});
	});//ready end
</script>

</head>
<body>

	<!-- 아래의 구조로 복사하시오 -->
	<!-- 전체 div-->
	<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper" style="min-height: 927px;">

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">결재</h1>
				</div>
			</div>

			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fas fa-table"></i>양식 관리
					</div>
					<div class="panel-body">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<div class="panel-heading">
									<button onclick="location='createform'" class="btn btn-info">
										<i class="fa fa-plus-circle" style="border-right:solid white 1px;"></i>양식 생성
									</button>
									<button class="btn btn-info">
										<i class="fa fa-minus-circle btn-i"></i>양식 삭제
									</button>
									<button class="btn btn-info">
										<i class="fa fa-check-circle btn-i"></i>양식 활성화
									</button>
									<button class="btn btn-info">
										<i class="fa fa-times-circle btn-i"></i>양식 비활성화
									</button>
								</div>
								<div class="panel-body">
									<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
										<thead>
											<tr role="row">
												<th><p><input type="checkbox" name="check-all" class="check-all">양식 번호</p></th>
												<th>사용 여부</th>
												<th>양식 이름</th>
												<th>양식 설명</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${FormList}" var="list">
												<tr>
													<td>
														<p>
															<input type="checkbox" name="check" class="check" value="${list.form_no}"> ${list.form_no}
														</p>
													</td>
													<td>${list.form_activation}</td>
													<td><a href="createform?form_no=${list.form_no}">${list.form_name}</a></td>
													<td>${list.form_desc}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>