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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>
<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dayoff/dayoff_setting.css">
<script >
	$(document)
			.ready(
					function() {
											
						$("form#daysSettingForm")
								.submit(
										function() {
											var tmpArr = $(
													"form#daysSettingForm")
													.serializeArray();
											var toSendArr = [];
											for (i = 0; i < tmpArr.length; i += 2) {
												var dayoffCreateObj = new Object();
												dayoffCreateObj.year_in_office = tmpArr[i].value;
												dayoffCreateObj.dayoff_days = tmpArr[i + 1].value;
												toSendArr.push(dayoffCreateObj);
											}
											console.log(JSON.stringify(toSendArr));
											$
													.ajax({
														method : "post",
														dataType : "json",
														contentType : 'application/json;charset=UTF-8',
														url : "${pageContext.request.contextPath}/dayoff/dayoffSetting",
														data : JSON
																.stringify(toSendArr),
														error : function() {
															alert('전송 실패');
														},
														success : function(
																server_result) {
															var server_json = server_result;
															var result = server_json.result;
															if (result == "1") {
																alert("수정 성공");
															} else {
																alert("수정 실패");
															}
														}
													});
											return false;
										});
						$("#finish").click(function() {
							$("#dayoff_kinds_form").submit();
						});
						$("#remove").click(function() {
							alert("삭제");
						});
						$("#save").click(function() {
							alert("저장");
						});

					});
</script>
<title>기본 설정</title>
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
									휴가 일수<br> <small>연차별 휴가일수를 설정하세요.</small>
								</h3>
								<form action="${pageContext.request.contextPath}/dayoff/dayoffSetting" id="daysSettingForm" method="post">
									<table class="table table-bordered" id="dataTables-example" role="grid" aria-describedby="dataTables-example_info">
										<thead>
											<tr role="row">
												<th>연차</th>
												<c:forEach items="${requestScope.DayoffCreateTerms}" var="list">
													<th>${list.year_in_office}</th>
												</c:forEach>
											</tr>
										</thead>
										<tbody>
											<tr role="row">
												<th>휴가일</th>
												<c:forEach items="${requestScope.DayoffCreateTerms}" var="list">
													<td><input type="hidden" name="year_in_office" value="${list.year_in_office}"> <input class="form-control" type="text" name="dayoff_days" value="${list.dayoff_days}"></td>
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
						<div class="panel-body">
							<div class="table-responsive">
								<form>
									<table class="table table-bordered table-hover" id="dayoff_kinds_table">
										<colgroup>
											<col class="col-sm-1">
											<col class="col-sm-1">
											<col class="col-sm-5">
											<col class="col-sm-5">
										</colgroup>
										<thead>
											<tr>
												<th><input type="checkbox" name="check-all" class="check-all"></th>
												<th>휴가명</th>
												<th>사용 여부</th>
												<th>차감 여부</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${requestScope.DayoffKinds}" var="list2" varStatus="st">
												<tr>
													<td><input type="checkbox" name="dayoff_type_code" value="${list2.dayoff_type_code}"></td>
													<td><input class="form-control" type="text" name="dayoff_name" value="${list2.dayoff_name}"></td>
													<td><c:if test="${list2.dayoff_activation == 1}">
															<input type="radio" checked="checked" name="dayoff_activation${st.index}">
															<label>사용</label>
															<input type="radio" name="dayoff_activation${st.index}">
															<label>사용안함</label>
														</c:if> <c:if test="${list2.dayoff_activation == 0}">
															<input type="radio" name="dayoff_activation${st.index}">
															<label>사용</label>
															<input type="radio" checked="checked" name="dayoff_activation${st.index}">
															<label>사용안함</label>
														</c:if></td>
													<td><c:if test="${list2.dayoff_deduction == 1}">
															<input type="checkbox" checked="checked" name="dayoff_deduction">
														</c:if> <c:if test="${list2.dayoff_deduction == 0}">
															<input type="checkbox" name="dayoff_deduction">
														</c:if> <label>연차에서 차감</label></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</form>
							</div>
						</div>
						<div class="panel-footer">
							<button type="button" class="btn btn-outline btn-success" data-toggle="modal" data-target="#myModal" id="add">추가</button>
							<button class="btn btn-outline btn-danger" id="remove">삭제</button>
							<button class="btn btn-outline btn-primary" id="save">저장</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">휴가종류 추가</h4>
				</div>
				<div class="modal-body">
					<form id="dayoff_kinds_form" action="${pageContext.request.contextPath}/dayoff/createDayoffKinds" method="post">
						<div class="container-fluid">
							<div class="row">
								<div class="col-lg-5">
									<label for="dayoff_name" class="control-label">휴가 이름:</label>
								</div>
								<div class="col-lg-7">
									<input type="text" class="form-control" name="dayoff_name" id="dayoff_name">
								</div>
							</div>
							<div class="row">
								<div class="col-lg-5">
									<label for="dayoff_name" class="control-label">사용 여부:</label>
								</div>
								<div class="col-lg-7">
									<input type="radio" name="dayoff_activation" value="1"><label class="control-label">사용</label> <input type="radio" name="dayoff_activation" value="0"><label class="control-label">사용안함</label>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-5">
									<label for="dayoff_name" class="control-label">차감 여부:</label>
								</div>
								<div class="col-lg-7">
									<input type="checkbox" name="dayoff_deduction" value="1"><label class="control-label">차감함</label>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="finish">완료</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>