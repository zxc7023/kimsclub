<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>일정</title>

<link
	href='${pageContext.request.contextPath}/resources/full/css/vendor/bootstrap.min.css'
	rel='stylesheet' />
<link
	href='${pageContext.request.contextPath}/resources/full/css/vendor/fullcalendar.css'
	rel='stylesheet' />
<link
	href='${pageContext.request.contextPath}/resources/full/css/style.css'
	rel='stylesheet' />
<!-- jQuery -->
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<%-- <script src='${pageContext.request.contextPath}/resources/full/js/vendor/jquery.min.js'></script> --%>
<script
	src='${pageContext.request.contextPath}/resources/full/js/vendor/moment.min.js'></script>
<script
	src='${pageContext.request.contextPath}/resources/full/js/vendor/bootstrap.min.js'></script>

<script
	src="${pageContext.request.contextPath}/resources/js/fullcalendar.js"></script>
<%-- <script src='${pageContext.request.contextPath}/resources/full/js/vendor/fullcalendar.js'></script>  --%>

<script
	src='${pageContext.request.contextPath}/resources/full/js/events.js'></script>
<script
	src='${pageContext.request.contextPath}/resources/full/js/calendar.js'></script>
<script src="${pageContext.request.contextPath}/resources/locale/ko.js"></script>

<script type='text/javascript'
	src='${pageContext.request.contextPath}/resources/js/gcal.js'></script>

<!--  달력-->
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/full/jquery.datetimepicker.css" />

<!--미니달력  -->
<%-- <script src="${pageContext.request.contextPath}/resources/minicalendar/pignose.calendar.min.js"></script>
<link href='${pageContext.request.contextPath}/resources/minicalendar/pignose.calendar.min.css' rel='stylesheet' /> --%>
<!-- js -->
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/jstree/3.3.5/themes/default/style.min.css" />
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jstree/3.3.5/jstree.min.js"></script>
<!-- z-tree js -->
<script src="http://www.treejs.cn/v3/js/jquery.ztree.core.js"></script>
<script src="http://www.treejs.cn/v3/js/jquery.ztree.excheck.js"></script>

<!-- z-tree CSS -->
<link href="http://www.treejs.cn/v3/css/zTreeStyle/zTreeStyle.css"
	rel="stylesheet">
<!-- header 및 navigation을 불러오기 위해서 사용해야하는 자원들 아래 다 복사해서 붙여넣기 하세요. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap Core CSS -->
<link
	href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Bootstrap Core CSS -->
<link
	href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link
	href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link
	href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/css/sb-admin-2.css"
	rel="stylesheet">

<!-- Custom Fonts -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.4.1/css/all.css">


<!-- Bootstrap Core JavaScript -->
<script
	src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script
	src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script
	src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>
</head>
<style>
.wrap-btn {
	position: relative;
	margin-top: 10px;
	text-align: left;
	cursor: pointer;
	overflow: hidden;
}

.wrap-btn label {
	float: left;
	margin-left: 10px;
	cursor: pointer;
	font-size: 13px;
}

.wrap-btn input.form-inputPop {
	position: absolute;
	top: 0;
	left: 0;
	opacity: 0;
	cursor: pointer;
	z-index: 5;
}

.wrap-btn #i1 {
	float: left;
	display: block;
	width: 20px;
	height: 20px;
	background:
		url(${pageContext.request.contextPath}/resources/images/btn_checkbox.png)
		no-repeat left top;
	z-index: 3;
}

.wrap-btn input.form-inputPop:checked+#i1 {
	background-position: left bottom;
}

.wrap-btn #i2 {
	float: left;
	display: block;
	width: 20px;
	height: 20px;
	background:
		url(${pageContext.request.contextPath}/resources/images/btn_checkbox2.png)
		no-repeat left top;
	z-index: 3;
}

.wrap-btn input.form-inputPop:checked+#i2 {
	background-position: left bottom;
}

.wrap-btn #i3 {
	float: left;
	display: block;
	width: 20px;
	height: 20px;
	background:
		url(${pageContext.request.contextPath}/resources/images/btn_checkbox3.png)
		no-repeat left top;
	z-index: 3;
}

.wrap-btn input.form-inputPop:checked+#i3 {
	background-position: left bottom;
}

.wrap-btn #i4 {
	float: left;
	display: block;
	width: 20px;
	height: 20px;
	background:
		url(${pageContext.request.contextPath}/resources/images/btn_checkbox4.png)
		no-repeat left top;
	z-index: 3;
}

.wrap-btn input.form-inputPop:checked+#i4 {
	background-position: left bottom;
}
/* .wrap-btn input.form-inputPop:checked+i+label {color:#f56592;} */
</style>
<script>
	$(function() {
		$('#container').jstree({
			"plugins" : [ "checkbox" ]
		});
	});
</script>
<script>
	function beforeClick(treeId, treeNode) {
		if (treeNode.parent) {

			//parent 구분하기위해 부서 명 앞에 d적은 거 자르기
			department_no = treeNode.no.split('d')[1];
			alert(department_no);

			//return true;
		} else {
			alert("사원 클릭 : " + name + ":" + no);
			//return false;
		}
	}

	$(document).ready(function() {

	});
</script>
<body>


	<!-- 아래의 구조로 복사하시오 -->
	<!-- 전체 div-->
	<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper">


			<nav class="navbar navbar-default">
				<div class="container-fluid">
					<p class="navbar-brand" id="todaysDate"></p>
				</div>
			</nav>

			<div class="container-fluid row">
				<div id='calendar1' class='calendar col-md-2 '>
					<!-- -ms-overflow-style: none; -->
					<label class="form-control-label">공유 캘린더</label> 
					<input
						type="button" id="tree-btn" value="만들기"
						style="position: absolute; right: 0;" />
					<!-- 카테고리 -->
					<!--  -->
					<div class="wrap-btn2">
						<input class="form-inputPop2" type="checkbox" name="e1" id="e1"
							checked="checked" /> <i></i> <label for="checkbox02">부서별</label>
					</div>
					<!--  -->


					<!--  -->
				</div>
				<div id='calendar2' class='calendar col-md-10'></div>
			</div>
			<!--이벤트 등록  -->
			<div class="modal fade" id="newEvent" role="dialog"
				aria-labelledby="eventFormLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="newEvent">일정등록</h4>
						</div>
						<form>
							<div class="modal-body">
								<div class="form-group">
									<label class="form-control-label">제목</label> <input type="text"
										class="form-control" id="title">
									<!--t수정  -->
									<label class="form-control-label">내용</label>
									<textarea rows="5" cols="30" id="content" class="form-control"></textarea>
									<label class="form-control-label">색상</label>
									<!-- 									<div class="wrap-btn">
										<label ><input class="form-inputPop" type="radio" name="color"
											id="checkbox1" style="display: none;"/> <i id="i1"></i></label>  
									
										<label ><input class="form-inputPop" type="radio" name="color"
											id="checkbox2" style="display: none;"/> <i id="i2"></i></label> 
											
										<label><input class="form-inputPop" type="radio" name="color"
											id="checkbox3" style="display: none;" /> <i id="i3"></i></label>
											
										<label><input class="form-inputPop" type="radio" name="color"
											id="checkbox4" style="display: none;" /> <i id="i4"></i></label>
									</div> -->

									<select name="color" id="color" class="form-control">
										<option value="#f27d4a" style="background-color: #f27d4a">주황</option>
										<option value="#f56592" style="background-color: #f56592;">업무</option>
										<option value="#feeb5b" style="background-color: #feeb5b;">노랑</option>
										<option value="#008bca" style="background-color: #008bca;"
											selected="selected">파란</option>
									</select> <label class="form-control-label">시작날짜</label> <input
										type="text" class="form-control" id="starts_at"> <label
										class="form-control-label">종료날짜</label> <input type="text"
										class="form-control" id="ends_at">
									<!--수정끝  -->
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">취소</button>
								<button type="button" class="btn btn-success" id="submit">저장</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!--이벤트 편집  -->
			<div class="modal fade" id="editEvent" role="dialog"
				aria-labelledby="eventFormLabel" aria-hidden="true"
				data-persist="false">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="editEvent">일정 내용</h4>
						</div>
						<form>
							<div class="modal-body">
								<div class="form-group">
									<label for="title" class="form-control-label">제목</label> <input
										type="text" class="form-control" id="editTitle">
									<!--t수정  -->
									<label class="form-control-label">내용</label>
									<textarea rows="5" cols="30" id="content2" class="form-control"></textarea>
									<label class="form-control-label">색상</label> <select
										name="color" id="color2" class="form-control">
										<option value="#f27d4a" style="background-color: #f27d4a">주황</option>
										<option value="#e0305a" style="background-color: #e0305a;">빨강</option>
										<option value="#feeb5b" style="background-color: #feeb5b;">노랑</option>
										<option value="#008bca" style="background-color: #008bca;"
											selected="selected">파란</option>
									</select> <label class="form-control-label">시작날짜</label> <input
										type="text" class="form-control" id="starts_at2"> <label
										class="form-control-label">종료날짜</label> <input type="text"
										class="form-control" id="ends_at2">
									<!--수정끝  -->
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger left" id="delete">삭제</button>
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">취소</button>
								<button type="button" class="btn btn-success" id="update">수정</button>
							</div>
						</form>
					</div>
				</div>
			</div>

			<!--카테고리  -->
			<div class="modal fade" id="tree-btn" role="dialog"
				aria-labelledby="eventFormLabel" aria-hidden="true"
				data-persist="false">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="shereEvent">공유캘린더</h4>
						</div>
						<form>
							<div class="modal-body">
								<div class="form-group">
									<label for="title" class="form-control-label">캘린더 이름</label> <input
										type="text" class="form-control" id="shereTitle"> t수정
									<label class="form-control-label">색상</label>
									<div class="wrap-btn">
										<label><input class="form-inputPop" type="radio"
											name="color" id="checkbox1" style="display: none;" /> <i
											id="i1"></i></label> <label><input class="form-inputPop"
											type="radio" name="color" id="checkbox2"
											style="display: none;" /> <i id="i2"></i></label> <label><input
											class="form-inputPop" type="radio" name="color"
											id="checkbox3" style="display: none;" /> <i id="i3"></i></label> <label><input
											class="form-inputPop" type="radio" name="color"
											id="checkbox4" style="display: none;" /> <i id="i4"></i></label>
									</div>
									<label class="form-control-label">공유 대상</label>
									<table>
										<tr>
											<td>
												<div id="container">
													<ul>
														<li data-jstree='{"opened":true}'>KIM'SCLUB
															<ul>
																<li>영업부</li>
																<li>전산팀</li>
															</ul>
														</li>
													</ul>
												</div>
											</td>
											<td>
											
											</td>
										</tr>
									</table>
									수정끝
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">취소</button>
								<button type="button" class="btn btn-success" id="submit">저장</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!--  -->
			<script
				src="${pageContext.request.contextPath}/resources/full/jquery.datetimepicker.full.js"></script>
			<script>
				/*jslint browser:true*/
				/*global jQuery, document*/
				jQuery(document)
						.ready(
								function() {
									'use strict';

									$.datetimepicker.setLocale('ko');
									jQuery(
											'#starts_at, #starts_at2, #ends_at, #ends_at2')
											.datetimepicker({
												step : 30
											});

								});
			</script>
		</div>

	</div>

<%-- 	<jsp:include page="/WEB-INF/views/treeModal.jsp">
		<jsp:param value="0" name="load_type" />
		<jsp:param value="beforeClick" name="beforeClick" />
		<jsp:param value="beforeCheck" name="beforeCheck" />
	</jsp:include> --%>

</body>
</html>