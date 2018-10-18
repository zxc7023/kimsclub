<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>양식 관리 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="resources/js/jquery-3.2.1.min.js"></script>
<!-- navigation -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.0.2/TweenMax.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>
<link rel="stylesheet" href="resources/css/default.css">
<link rel="stylesheet" href="resources/css/navigation.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet">
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
<link href="resources/css/sb-admin.css" rel="stylesheet">
<script>
$(document).ready(function() {
	$('.check-all').click(function() {
		$('.check').prop('checked', this.checked);
	});
});//ready end
</script>
</head>
<body>
	<section>
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>
				<div class="col-10 back cont-wrap">
					<div class="row">
						<div class="card mb-3">
							<div class="card-header">
								<i class="fas fa-table"></i> 
								양식 관리
							</div>
							<div class="card-body">
								<div class="card mb-3">
									<div class="card-header">
										<div id="form_menu">
											<button onclick="location='createform'"" class="btn btn-info"><span class="fa fa-plus-circle" style="display: inline;">양식 생성</span></button>
											<button class="btn btn-info"><span class="fa fa-minus-circle" style="display: inline;">양식 삭제</span></button>
											<button class="btn btn-info"><span class="fa fa-check-circle" style="display: inline;">양식 활성화</span></button>
											<button class="btn btn-info"><span class="fa fa-times-circle" style="display: inline;" >양식 비활성화</span></button>
										</div>
									</div>
									<div class="card-body">
										<table class="table table-bordered" id="dataTable"
												width="100%" cellspacing="0">
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
														<td><p>
																<input type="checkbox" name="check" class="check"
																	value="${list.form_no}">
															${list.form_no}</p></td>
														<td>${list.form_activation}</td>
														<td><a href="createform?form_no=${list.form_no}">${list.form_name}</a></td>
														<td>${list.form_desc}</td>
													</tr>
													</c:forEach>
												</tbody>
											</table>
									</div>
									<div class="card-footer small text-muted">Updated
										yesterday at 11:59 PM</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- card mb-3 -->
</body>
</html>