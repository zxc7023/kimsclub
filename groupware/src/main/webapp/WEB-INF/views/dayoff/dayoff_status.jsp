<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<!-- dayoff_writeform.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dayoff/day_status.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css">
<script type="text/javascript">
$(document).ready(function() {
	    $('#calendar').fullCalendar({
	    })
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
					<h1 class="page-header">휴가현황</h1>
				</div>
			</div>

			<div class="row">
				<div class="col-sm-12">
					<div class="">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs">
							<li class="active"><a href="#tab01" data-toggle="tab">휴가 생성 내역</a></li>
							<li><a href="#tab02" data-toggle="tab">휴가 신청 내역</a></li>
							<li><a href="#tab03" data-toggle="tab">휴가 캘랜더 </a></li>
						</ul>

						<!-- Tab panes -->
						<div class="tab-content ">
							<div class="tab-pane fade in active" id="tab01">
								<table>
									<caption>휴가 생성 내역</caption>
									<colgroup>
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="20%">
										<col width="50%">
									</colgroup>
									<thead>
										<tr>
											<th rowspan="2">생성일</th>
											<th colspan="2">생성 내역</th>
											<th rowspan="2">내용</th>
											<th rowspan="2">비고</th>
										</tr>
										<tr>
											<th>발생</th>
											<th>최종</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>2018.09.27</td>
											<td>19일</td>
											<td>49일</td>
											<td>정기 휴가</td>
											<td>금년발생일(13), 전년이월(6), 최종연차(49)</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="tab-pane fade" id="tab02">
								<div>
									<table>
										<caption>휴가 신청 내역</caption>
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
												<td><button>상세</button></td>
											</tr>
										</tbody>
									</table>
								</div>

							</div>
							<div class="tab-pane fade" id="tab03">
								<div><div id="calendar"></div></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>