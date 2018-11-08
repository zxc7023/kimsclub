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

<!-- jquery-ui.css -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>

<!-- ckeditor -->
<script src="resources/ckeditor/ckeditor.js"></script>

<!-- jquery-ui.js -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- jquery-serializeObject.js  -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-serializeObject.js"></script>
<style>
.odd {
background-color: #f5f5f5;
}
</style>
<script>
$(document).ready(function() {
	var type;
	$(function(){
	    CKEDITOR.replace( 'ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
			width:'100%',
	    	height:'400px',
	    	filebrowserUploadUrl: '${pageContext.request.contextPath}/upload/ckeditor_upload.asp',
	    	extraPlugins : 'uploadimage'
	    });
	});

	$("#save_btn").click(function(){
		$("#submit").attr("value",0);
		submitBtn();
	});
	
	$("#app_btn").click(function(){
		$("#type").attr("value",1);
		submitBtn();
	});
	
	function submitBtn(){
		$('#ckeditor').html(CKEDITOR.instances.ckeditor.getData());
		var tmpArr = $("form#writeDocForm").serializeObject();

		$.ajax({
			method : "post",
			url : "/groupware/approvalNewDoc",
			contentType: "application/json;charset=UTF-8",
			dataType : "json",
			data :  JSON.stringify(tmpArr),
			error : function(error) {
				alert("양식 불러오기 실패");
			},
			success : function(data) {
				
				window.location.href = data;
			}
		});
	}
	
	
	
	
	$('.selectForm').change(function() {
		if($(this).val()!='default'){
			if(CKEDITOR.instances.ckeditor.getData()!=''){
				$('#deleteCheckModal').modal('show'); //This can also be $("#deleteCheckModal").modal({ show: true });
			}else{
				loadForm();
			}
		}
	});
	
});//ready end
function loadForm(){
	$.ajax({
		method : "GET",
		url : "/groupware/loadForm",
		data : {
			"form_no" : $('.selectFormNo:selected').val()
		},
		error : function() {
			alert("양식 불러오기 실패");
		},
		success : function(data) {
			CKEDITOR.instances.ckeditor.setData(data);
			//keditor.element.appendText(data);
		}
	});
}
</script>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">결재</h1>
				</div>
			</div>
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">문서 작성</div>
					<div class="panel-body">
						<form class="col-sm-12" action="/groupware/approvalNewDoc" id="writeDocForm" method="post">
							<div class="panel-heading">
								<input type="hidden" name="document_state" id="type" value="">
								<input type="button" class="btn btn-info" id="app_btn" value="기안하기">
								<input type="button" class="btn btn-info" id="save_btn" value="임시저장">
							</div>
							<div class="panel-body">
								<table
									class="table table-bordered dataTable no-footer dtr-inline"
									id="dataTables-example" role="grid"
									aria-describedby="dataTables-example_info">
									<colgroup>
										<col width="150">
										<col width="auto">
									</colgroup>
									<tbody>
										<tr>
											<td class="odd">문서 양식</td>
											<td><select class="selectForm">
													<option selected="selected" value="default">양식 선택</option>
													<c:forEach items="${flist}" var="fvo">
														<option class="selectFormNo" value="${fvo.form_no}">${fvo.form_name}</option>
													</c:forEach>
											</select></td>
										</tr>
										<tr>
											<td class="odd">작성자</td>
											<td>${sessionScope.loginInfo.employee_name}</td>
										</tr>
										<tr>
											<td class="odd">결재</td>
											<td>
												<div role="row">
													<div class="col-lg-10">
														<div class="panel panel-default" id="approvalLine">
															<table width="100%"
																class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline"
																role="grid" aria-describedby="dataTables-example_info"
																style="width: 100%;">
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
																		<td class="name" index=0></td>
																		<td class="name" index=1></td>
																		<td class="name" index=2></td>
																		<td class="name" index=3></td>
																		<td class="name" index=4></td>
																		<td class="name" index=5></td>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
													<div class="col-lg-2">
														<button class="btn-ApprovalLine" type="button"
															data-toggle="modal" data-target="#approvalLineSelect">결재선
															선택</button>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="odd">문서 제목<br>
											</td>
											<td><input type="text" name="document_title"
												class="form-control" required="required"
												autofocus="autofocus"></td>
										</tr>
										<tr>
											<td colspan="2" class="odd">문서 내용</td>
										</tr>
										<tr>
											<td colspan="2">
												<div class="col-lg-12">
													<textarea name="document_contents" id="ckeditor" class="form"></textarea>
												</div>
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

	<!-- 양식 수정 체크 modal -->
	<div class="modal fade" id="deleteCheckModal"
		aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="modalLabel">
						주의!
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</h3>
				</div>
				<div class="modal-body">
					저장하지 않은 문서 양식이 삭제 될 수 있습니다. 정말로 진행하시겠습니까?
					<!--해당 글 삭제하는 주소값받는 input 태그-->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="loadForm();"
						data-dismiss="modal">확인</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 결재선 불러오기 modal -->
	<jsp:include page="/WEB-INF/views/approvalLineModal.jsp"></jsp:include>
</body>
</html>