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
<style>
.odd {
background-color: #f5f5f5;
}
</style>
<script>
$(document).ready(function() {
	//버튼 클릭시 팝업창 호출
	$('.btn-ApprovalLine').click(function(){
		var left = (window.screen.width/2) - 300;
		var top= (window.screen.height/2) - 350;
		
		window.open('/groupware/approvalLine', '결재선', 'status=no, height=700, width=600, left='+ left + ', top='+ top);
	});
	
	$(function(){
	    CKEDITOR.replace( 'ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
			width:'100%',
	    	height:'400px',
	    	filebrowserUploadUrl: '${pageContext.request.contextPath}/upload/ckeditor_upload.asp'
	    });        
	});
	
	$('.selectForm').change(function() {
		if($(this).val()!='default'){
			if(CKEDITOR.instances.ckeditor.getData()!=''){
				$('#deleteCheckModal').modal('show'); //This can also be $("#deleteCheckModal").modal({ show: true });
			}else{
				loadForm();
			}
		}
	});
// 	$(window).load(function(){
// 			    $('#deleteCheckModal').modal('show');
// 	});
	
	
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
		}
	});
}

//결재선 불러오기
function loadApprovalLine(){
	$.ajax({
		method : "GET",
		url : "/groupware/approvalLine",
		error : function() {
			alert("조직도 불러오기 실패");
		},
		success : function(data) {
			CKEDITOR.instances.ckeditor.setData(data);
		}
	});
}
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

			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">문서 작성</div>
					<div class="panel-body">
						<div class="panel panel-default">
							<div class="panel-heading">
								<button onclick="location='approvalDoc'" class="btn btn-info">기안하기</button>
								<button onclick="location='approvalNewDoc'" class="btn btn-info">임시저장</button>
							</div>
							<div class="panel-body">
								<form class="col-sm-12">
									<table class="table table-bordered dataTable no-footer dtr-inline" id="dataTables-example" role="grid" aria-describedby="dataTables-example_info">
										<colgroup>
											<col width="150">
											<col width="auto">
										</colgroup>
										<tbody>
											<tr role="row">
												<td class="odd">문서 양식</td>
												<td>
													<select class="selectForm">
														<option selected="selected" value="default">양식 선택</option>
														<c:forEach items="${flist}" var="fvo">
															<option class="selectFormNo" value="${fvo.form_no}">${fvo.form_name}</option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr role="row">
												<td class="odd">작성자</td>
												<td>사원이름</td>
											</tr>
											<tr role="row">
												<td class="odd">결재</td>
												<td>
													<button class="btn-ApprovalLine" type="button">결재선 선택</button>
												</td>
												
											</tr>
											<tr role="row">
												<td colspan="2" class="odd">문서 내용</td>
											</tr>
											<tr role="row">
												<td  colspan="2">
													<div class="col-lg-12">
														<textarea name="form_contents" id="ckeditor" class="form"></textarea>
													</div>
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
	
	<!-- 양식 수정 체크 modal -->
	<div class="modal fade" id="deleteCheckModal"
		aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="modalLabel" >주의!
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
					<button type="button" class="btn btn-primary" onclick="loadForm();" data-dismiss="modal">확인</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 결재선 불러오기 modal -->
	<div class="modal fade" id="loadApprovalLineModal"
		aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="modalLabel" >결재선 불러오기
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
					<button type="button" class="btn btn-primary" onclick="loadForm();" data-dismiss="modal">확인</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
