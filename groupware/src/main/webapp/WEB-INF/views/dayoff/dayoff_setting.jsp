<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- header 및 navigation을 불러오기 위해서 사용해야하는 자원들 아래 다 복사해서 붙여넣기 하세요. -->
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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css"
	integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">


<!-- DataTables CSS -->
<!-- <link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet"> -->

<!-- DataTables Responsive CSS -->
<!-- <link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet"> -->

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>

<!-- <!-- DataTables JavaScript -->
<!-- <script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/datatables-responsive/dataTables.responsive.js"></script> -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dayoff/dayoff_setting.css">

<script>
	$(document).ready(function() {
		console.log($("form").serializeArray());
		$("form").submit(function(){
			alert("호출");
			return false;
		})
	});
</script>

<title>Insert title here</title>
</head>
<body>
	<!-- 아래의 구조로 복사하시오 -->
	<!-- 전체 div-->
	<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper">
		
			<div class="row">
				<div class="col-sm-12">
					<h1 class="page-header">휴가 관리</h1>
				</div>
			</div>
			
			<div class="row">
				<div class="col-sm-12">
					<div class="panel panel-default">
						<div class="panel-heading">휴가 생성 조건</div>
						<div class="panel-body">
				
								<div>
									<h3>
										휴가 일수<br>
										<small>연차별 휴가일수를 설정하세요.</small>
									</h3>
									<form action="${pageContext.request.contextPath}/dayoff/dayoffSetting" method="post">
										<table class="table table-bordered  " id="dataTables-example" role="grid" aria-describedby="dataTables-example_info">
											<thead>
												<tr role="row">
													<th>연차</th>
													<c:forEach items="${requestScope.dayoffCreateCondition}" var="list">
														<th><input type="hidden" name="year_in_office" value="${list.year_in_office}"> ${list.year_in_office}</th>
													</c:forEach>
												</tr>
											</thead>
											<tbody>
												<tr role="row">
													<th>휴가일</th>
													<c:forEach items="${requestScope.dayoffCreateCondition}" var="list">
														<td>
															<input class="form-control" type="text" name="dayoff_days" value="${list.dayoff_days}">
														</td>
													</c:forEach>
												</tr>
											</tbody>
										</table>
										<input type="submit" class="btn btn-outline btn-default" value="저장">
									</form>
								</div>
							</div>
						
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<div class="panel panel-default">
						<div class="panel-heading">휴가 종류</div>
						<div class="panel-body"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>