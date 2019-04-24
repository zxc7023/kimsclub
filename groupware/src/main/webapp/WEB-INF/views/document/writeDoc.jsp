<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<!-- 공통 JS, CSS를 모아서 불러오는 헤더-->
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<!-- ckeditor -->
<script src="resources/ckeditor/ckeditor.js"></script>

<!-- jquery-serializeObject.js  -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-serializeObject.js"></script>
<title>새 문서 작성</title>
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
	    	filebrowserUploadUrl: '${pageContext.request.contextPath}/upload'
	    });
	});

	$("#save_btn").click(function(){
		if($("input[name=document_title]").val()!=""){
			$("#type").attr("value","임시저장");
			submitBtn();
		}else{
			alert("제목을 입력하세요.");
		}
	});
	
	function submitBtn(){
		$('#ckeditor').html(CKEDITOR.instances.ckeditor.getData());
		var tmpArr = $("form#writeDocForm").serializeObject();

		$.ajax({
			method : "post",
			url : "/groupware/newDocList",
			contentType: "application/json;charset=UTF-8",
			//dataType : "json",
			data :  JSON.stringify(tmpArr),
			error : function(error) {
				alert("양식 불러오기 실패");
			},
			success : function(data) {
				console.log(data);
				window.location.href = data.result;
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
		url : "/groupware/form/loadForm",
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
					<h1 class="page-header">새 문서 작성</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<input type="button" class="btn btn-default" id="save_btn" value="저장하기">
						</div>
						<div class="panel-body">
							<form class="col-sm-12" id="writeDocForm" method="post">
								<input type="hidden" name="document_state" id="type" value="">
								<table class="table table-bordered dataTable no-footer dtr-inline" id="dataTables-example" role="grid" aria-describedby="dataTables-example_info">
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
											<td class="odd">문서 제목<br>
											</td>
											<td><input type="text" size="20" name="document_title" class="form-control" required="required" autofocus="autofocus" maxlength="40"></td>
										</tr>
										<tr>
											<td colspan="2" class="odd">문서 내용</td>
										</tr>
										<tr>
											<td colspan="2"><textarea name="document_contents" id="ckeditor" class="form"></textarea></td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 양식 수정 체크 modal -->
		<div class="modal fade" id="deleteCheckModal" aria-labelledby="modalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h3 class="modal-title" id="modalLabel">
							주의!
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
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
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>