<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<!-- 공통 JS, CSS를 모아서 불러오는 헤더-->
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<!-- jquery-serializeObject.js  -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-serializeObject.js"></script>
<title>문서 기안</title>
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
		if($("div#approvalLine input[name='approval[][employee][employee_no]']").length < 2){
			alert("결재선을 2명이상 입력해주세요.");
			return false;
		}
		$("#type").attr("value","진행");

		//submitBtn();
	});
	
	function submitBtn(){
		var tmpArr = $("form#writeDocForm").serializeObject();
		console.log(tmpArr);
		
		$.ajax({
			method : "post",
			url : "/groupware/approvalDocResult",
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
	<!-- 전체 div-->
	<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper">

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">문서 기안(결재선 선택)</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<button type="button" id="app_btn" class="btn btn-default">기안하기</button>
						</div>
						<div class="row">
							<div class="col-lg-12">
								<div class="panel-body">
									<form class="col-sm-12" id="writeDocForm" method="post">
										<input type="hidden" name="document_no" value="${dvo.document_no}"> 
										<input type="hidden" name="document_state" id="type" value="">
										
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
															<div class="col-lg-12">
																<div class="panel panel-default" id="approvalLine">
																	<table class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline" role="grid" aria-describedby="dataTables-example_info" style="width: 100%;">
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
																				<th colspan="6" class="t-tit text-center">결재 순서
																					<p class="fa fa-long-arrow-right"></p>
																					<button type="button" class="btn  btn-default float-right" data-toggle="modal" data-target="#approvalLineSelect" id="LineSelectBtn">결재선 선택</button>
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
