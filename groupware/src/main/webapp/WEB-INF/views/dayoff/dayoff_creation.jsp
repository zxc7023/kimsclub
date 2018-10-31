<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js"></script>
<script src="https://fullcalendar.io/releases/fullcalendar/3.9.0/gcal.min.js"></script>
<!-- dayoff_writeform.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dayoff/day_status.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css">
<script type="text/javascript">
	$(document).ready(function() {
		$("#createDayoff").click(function() {
			if ($("#check1").prop("checked") && $("#check2").prop("checked")) {

				var emp = {
					'employee_no' : 0
				};
				
				$.ajax({
					method : "post",
					dataType : "json",
					contentType : 'application/json;charset=UTF-8',
					url : "${pageContext.request.contextPath}/dayoff/createDayoff",
					data : JSON.stringify(emp),
					error : function() {
						alert('전송 실패');
					},
					success : function(server_result) {
						var server_json = server_result;
						var result = server_json.result;
						if (result == "1") {
							alert("생성 성공");
						} else {
							alert("생성 실패");
						}
					}
				});
				
				
			} else {
				alert("확인사항을 체크해주세요.");
			}
		});
	});
</script>
<title>휴가현황</title>
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
					<h1 class="page-header">휴가 생성</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<div class="panel-body">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs">
							<li class="active"><a href="#tab01" data-toggle="tab">연차 휴가 생성</a></li>
							<li><a href="#tab02" data-toggle="tab">포상 휴가 생성</a></li>
						</ul>
						<!-- Tab panes -->
						<div class="tab-content">
							<div class="tab-pane fade in active" id="tab01">
								<ul>
									<li>연차는 [휴가관리 - 기본 설정] 페이지에서 설정한 휴가 생성 조건에 따라 생성됩니다.</li>
									<li>오피스 생성 후 근태/휴가를 처음 사용하거나 수동 설정이 필요한 경우, 아래 확인 사항을 확인하시고 [지금 생성] 버튼을 클릭하여 연차를 수동 생성하세요.</li>
									<li>연차 휴가는 휴가 생성 조건에서 설정한 생성 일자에 매년 1회 자동 생성되므로, 특별한 경우를 제외하고는 수동 생성할 필요가 없습니다.</li>
								</ul>
								<table class="table table-bordered" id="dataTables-example" role="grid" aria-describedby="dataTables-example_info">
									<thead>
										<tr role="row">
											<th>연차</th>
											<c:forEach items="${requestScope.DayoffCreateTerms}" var="list">
												<td>${list.year_in_office}</td>
											</c:forEach>
										</tr>
									</thead>
									<tbody>
										<tr role="row">
											<th>휴가일</th>
											<c:forEach items="${requestScope.DayoffCreateTerms}" var="list">
												<td>${list.dayoff_days}</td>
											</c:forEach>
										</tr>
										<tr role="row">
											<th>확인 사항</th>
											<td colspan="${fn:length(requestScope.DayoffCreateTerms)}">
												<p>아래 내용을 확인 후 체크해주세요.</p>
												<div>
													<input type="checkbox" id="check1"> <small>위 조건으로 전 직원의 연차 휴가를 생성(재설정)합니다. 생성 조건이 회사 규정에 맞지 않으면 설정을 변경한 후 이용하세요.</small> <a href="${pageContext.request.contextPath}/dayoff/dayoffSetting">연차 휴가 설정 변경 바로가기</a>
												</div>
												<div>
													<input type="checkbox" id="check2"> <small> 입사일이 입력되지 않은 사용자는 휴가가 생성되지 않습니다. 휴가 대상자를 먼저 확인하시기 바랍니다</small> <a href="#">회원관리 바로가기</a>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
								<button class="btn btn-outline btn-default" id="createDayoff">휴가 생성</button>
							</div>
							<div class="tab-pane fade" id="tab02">
								<div>
									<table>
										<colgroup>
											<col width="7%">
											<col width="12%">
											<col width="12%">
											<col width="10%">
											<col width="12%">
											<col width="12%">
											<col width="12%">
											<col width="12%">
										</colgroup>
										<thead>
											<tr>
												<th scope="row">번호</th>
												<th scope="row">신청자</th>
												<th scope="row">휴가 종류</th>
												<th scope="row">일수</th>
												<th scope="row">기간</th>
												<th scope="row">상태</th>
												<th scope="row">상세</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td>김준기</td>
												<td>연차</td>
												<td>1</td>
												<td>
													<p>2018.01.02 ~ 2018.01.02</p>
												</td>
												<td>결재 완료</td>
												<td>
													<button>상세</button>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- tab_content 끝 -->
					</div>
				</div>
				<!-- col-sm-12영역 끝 -->
			</div>
			<!-- row 끝 -->
		</div>
	</div>
</body>
</html>