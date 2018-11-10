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

<!-- jquery-ui.css -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

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

<!-- jquery-ui.js -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- jquery-serializeObject.js  -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-serializeObject.js"></script>

<style type="text/css">
.odd {
background-color: #f5f5f5;
}
#sign td{
height: 80px;
}
</style>
<script>
$(document).ready(function() {
	$("#app_btn").click(function(){
		$("#type").attr("value","진행");
		submitBtn();
	});
	
	function submitBtn(){
		var tmpArr = $("form#writeDocForm").serializeObject();
		console.log(tmpArr);
		
		$.ajax({
			method : "post",
			url : "/groupware/approvalDoc",
			contentType: "application/json;charset=UTF-8",
			data :  JSON.stringify(tmpArr),
			error : function(error) {
				alert("전송 실패");
			},
			success : function(data) {
				
				window.location.href = data;
			}
		}); 

	}
});
</script>
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
				<div class="col-lg-12">
					<h1 class="page-header">결재</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">문서 기안(결재선 선택)</div>
						<div class="row">
							<div class="col-lg-12">
								<div class="panel-body">
									<form class="col-sm-12" id="writeDocForm" method="post">
										<div class="panel-heading">
											<input type="hidden" name="document_no" value="${dvo.document_no}">
											<input type="hidden" name="document_state" id="type" value="">
											<button type="button" id="app_btn" class="btn btn-info">기안하기</button>
										</div>
										<div class="panel-body">
											<table class="table table-bordered dataTable no-footer dtr-inline" id="dataTables-example" role="grid" aria-describedby="dataTables-example_info">
												<colgroup>
													<col width="150">
													<col width="auto">
												</colgroup>
												<tbody>
													<tr>
														<td class="odd">작성자</td>
														<td>${dvo.employee.employee_name}</td>
													</tr>
													<tr>
														<td class="odd">문서 제목<br>
														</td>
														<td>${dvo.document_title}</td>
													</tr>
													<tr>
														<td class="odd">결재</td>
														<td>
															<div role="row">
																<div class="col-lg-10">
																	<div class="panel panel-default" id="approvalLine">
																		<table width="100%" class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline" role="grid" aria-describedby="dataTables-example_info" style="width: 100%;">
																			<colgroup>
																				<col width="15%">
																				<col width="17%">
																				<col width="17%">
																				<col width="17%">
																				<col width="17%">
																				<col width="17%">
																			</colgroup>
																			<tbody class="t-body">
																				<tr>
																					<th colspan="6">결재 순서
																						<p class="fa fa-long-arrow-right"></p>
																					</th>
																				</tr>
																				<tr id="paste">
																					<c:forEach begin="0" end="5" varStatus="i">
																						<td class="name" index="${i.index}" style="text-align: center;">${dvo.approval[i.index].employee.department.department_name}<br> ${dvo.approval[i.index].employee.employee_name} ${dvo.approval[i.index].employee.position}
																						</td>
																					</c:forEach>
																				</tr>
																			</tbody>
																		</table>
																	</div>
																</div>
																<div class="col-lg-2">
																	<button class="btn-ApprovalLine" type="button" data-toggle="modal" data-target="#approvalLineSelect">결재선 선택</button>
																</div>
															</div>
														</td>
													</tr>
													<tr>
														<td colspan="2" class="odd">문서 내용</td>
													</tr>
													<tr>
														<td colspan="2">
															<div class="col-lg-12">${dvo.document_contents}</div>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 결재선 불러오기 modal -->
	<jsp:include page="/WEB-INF/views/approvalLineModal.jsp"></jsp:include>
</body>
</html>
