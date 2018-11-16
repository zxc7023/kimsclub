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

<!-- z-tree js -->
<script src="http://www.treejs.cn/v3/js/jquery.ztree.core.js"></script>
<script src="http://www.treejs.cn/v3/js/jquery.ztree.excheck.js"></script>

<!-- z-tree CSS -->
<link href="http://www.treejs.cn/v3/css/zTreeStyle/zTreeStyle.css"
	rel="stylesheet">

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

.wrap-btn .ii1 {
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

.wrap-btn #i5 {
	float: left;
	display: block;
	width: 20px;
	height: 20px;
	background:
		url(${pageContext.request.contextPath}/resources/images/btn_checkbox5.png)
		no-repeat left top;
	z-index: 3;
}

.wrap-btn input.form-inputPop:checked+#i5 {
	background-position: left bottom;
}
/* 카테고리 색 */
.wrap-btn input.form-inputPop:checked+#i1+label {
	color: #ff7473;
}

.wrap-btn input.form-inputPop:checked+#i2+label {
	color: #ffc952;
}

.wrap-btn input.form-inputPop:checked+#i3+label {
	color: #47b8e0;
}

.wrap-btn input.form-inputPop:checked+#i4+label {
	color: #34314c;
}
/*  */
.wrap-btn input.form-inputPop:checked+#i5+label {
	color: #f56592;
}
</style>



<style>
.mytable {
	border-collapse: collapse;
}

.mytable th, .mytable td {
	border: 1px solid black;
}
</style>
<script>
	$(document)
			.ready(
					function() {
						function showLog(str) {
							if (!log)
								log = $("#log");
							log.append("<li class='"+className+"'>" + str
									+ "</li>");
							if (log.children("li").length > 6) {
								log.get(0).removeChild(log.children("li")[0]);
							}
						}

						function beforeClick(treeId, treeNode) {
							var department_no = treeNode.no;
							alert(department_no);
/* 							$.ajax({
								method : "post",
								data : JSON.stringify(eventData),
								dataType : "json",
								contentType : 'application/json;charset=UTF-8',
								url : "/groupware/addCalendar",
								error : function() {
									alert('전송 실패:데이터 저장');
								},
								success : function(data) {
									alert(data.result);
									$cal2.fullCalendar('renderEvent',
											eventData, true);
								}
							}) */

/* 							console.log(treeNode);
							alert("부서 클릭 : " + treeNode.name + ":"
									+ treeNode.no);
							showLog("부서 클릭 : " + treeNode.name + ":"
									+ treeNode.no); */
						}
						//zTree 세팅 부분
						var setting = {
							view : {
								selectedMulti : false
							},
							//체크박스 사용 여부 부분
							check : {
								enable : true,
								chkStyle : "checkbox"
							},
							data : {
								key : {
									isParent : "parent",
									name : "name"

								},
								simpleData : {
									enable : true,
									idKey : "no",
									pIdKey : "pNo",
									cnt : "cnt",

								}
							},
							callback : {
							/* 	beforeClick : beforeClick, */
								beforeCheck:beforeClick
							},
							edit : {
								enable : true,
								drag : {
									autoOpenTime : 0
								}
							}
						};
						var zNodes = [];
						var open = {
							open : true
						};

						var log, code, className = "dark";
						$('#category')
								.click(
										function() {

											$
													.ajax({
														method : "get",
														contentType : 'application/json;charset=UTF-8',
														url : "/groupware/humanResources/departmentList?load_type=0",
														error : function() {
															alert("전송 실패");
														},
														success : function(
																server_result) {
															zNodes = JSON
																	.parse(server_result);
															console.log(zNodes);

															var tree = $.fn.zTree
																	.init(
																			$("#treeDemo"),
																			setting,
																			zNodes);
															tree
																	.expandAll(true);

														}
													});

											$('#addcategory').modal('show');
										});

					});
</script>
<script>
$(document).on("click","#index_submit",function() {
	$('#update').unbind();
	 var radioVal = $('input[name="color"]:checked').val();
	 var nameVal = $('#shereTitle').val();
	$("#index_list").append (
			"<div class='.wrap-btn'><input type='checkbox'><i class='ii1'></i><label style='color:"+radioVal+"'>"+nameVal+"</label></div>"			
			);
	$('#shereTitle').val("");
	 $('#addcategory').modal('hide');
	
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
					<label class="form-control-label">공유 캘린더</label> <input
						type="button" id="category" value="만들기"
						style="position: absolute; right: 0;" />
					<!-- 카테고리 -->
					<div id="index_list"></div>
					<!--  -->
					<div class="wrap-btn">
						<input class="form-inputPop" type="checkbox" name="e1" id="e1"
							checked="checked"
							onChange="scheduleChoice(0, 'qansohiecib58ga9k1bmppvt5oi65b1q@import.calendar.google.com', '#f8f8f8', '#FF0000');" />
						<i id="i5"></i> <label for="checkbox01">공휴일</label>
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
									<label class="form-control-label">색상</label> <select
										name="color" id="color" class="form-control">
										<option value="#ff7473" style="background-color: #ff7473">주황</option>
										<option value="#ffc952" style="background-color: #ffc952;">업무</option>
										<option value="#47b8e0" style="background-color: #47b8e0;">노랑</option>
										<option value="#34314c" style="background-color: #34314c;">파란</option>
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
										<option value="#ff7473" style="background-color: #ff7473">주황</option>
										<option value="#ffc952" style="background-color: #ffc952;">빨강</option>
										<option value="#47b8e0" style="background-color: #47b8e0;">노랑</option>
										<option value="#34314c" style="background-color: #34314c;">파란</option>
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
			<div class="modal fade" id="addcategory" role="dialog"
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
										type="text" class="form-control" id="shereTitle">
									<!--t수정  -->
									<label class="form-control-label">색상</label>
									<div class="wrap-btn">
										<label>
										<input class="form-inputPop" type="radio"
											name="color" id="checkbox1" value="#ff7473" style="display: none;" /> <i class="ii1"
											id="i1"></i></label> 
											<label>
											<input class="form-inputPop"
											type="radio" name="color" id="checkbox2"value="#ffc952"
											style="display: none;" /> <i class="form-inputPop"id="i2"></i></label> 
											<label>
											<input class="form-inputPop" type="radio" name="color"
											id="checkbox3" value="#47b8e0"style="display: none;" /> <i class="form-inputPop" id="i3"></i></label> 
											<label>
											<input class="form-inputPop" type="radio" name="color"
											id="checkbox4"value="#34314c" style="display: none;" /> <i class="form-inputPop"id="i4"></i></label>
									</div>
									<label class="form-control-label">공유 대상</label>
									<table >
										<tr valign=top>
											<td>
												<div>
													<div class="zTreeDemoBackground left">
														<ul id="treeDemo" class="ztree">
														</ul>
													</div>
												</div> </td>																																	
										</tr>
									</table>
									<!--수정끝  -->
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">취소</button>
								<button type="button" class="btn btn-success" id="index_submit">저장</button>
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

</body>
</html>