<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>

<script src="${pageContext.request.contextPath}/resources/js/jquery-serializeObject.js"></script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
function beforeClick(treeId, treeNode) {
	$('#department').html(treeNode.name);
	$('#department_no').val(treeNode.no.split('d')[1]);
	 $('#testTreeModal').modal('hide');
}
$(document).ready(function() {
	$( "#datepicker").datepicker();
	$( "#datepicker").datepicker("option","dateFormat", "yy-mm-dd" );
	
	$('#modifyEmployee-btn').click(function(){
		var tmpArr = $("form#addEmployee").serializeObject();
		console.log(tmpArr);
		$.ajax({
			method : "post",
			url : "/groupware/humanResources/modifyEmployee",
			contentType: "application/json;charset=UTF-8",
			data :  JSON.stringify(tmpArr),
			error : function(error) {
				alert("양식 불러오기 실패");
			},
			success : function(data) {
				
				window.location.href = data;
			}
		});
	});
/* 
		$.ajax({
			method : "post",
			url : "/groupware/modifyDocState",
			contentType: "application/json;charset=UTF-8",
			data :  JSON.stringify(tmpArr),
			error : function(error) {
				alert("양식 불러오기 실패");
			},
			success : function(data) {
				
				window.location.href = data;
			}
		}); */
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
		<div id="page-wrapper"  >

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">사용자 수정</h1>
				</div>
			</div>

			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<button class="btn btn-default" type="button" id="modifyEmployee-btn">사용자 수정</button>
					</div>
					<div class="panel-body">
						<form id="addEmployee" action="addEmployee" method="post">
							<table class="table table-bordered dataTable no-footer dtr-inline" id="dataTables-example" role="grid" aria-describedby="dataTables-example_info">
								<colgroup>
									<col width="25%">
									<col width="75%">
								</colgroup>
								<tbody>
								<tr role="row">
									<td>이름</td>
									<td><input type="text" name="employee_name" required="required" style="width: 100%;" placeholder="이름 입력" value="${evo.employee_name}">
										<input type="hidden" name="employee_no" value="${evo.employee_no}">
									</td>
								</tr>
								<tr role="row">
									<td>비밀번호</td>
									<td><input type="password" name="password" required="required" style="width: 100%;" placeholder="비밀번호 입력" value="${evo.password}"></td>
								</tr>
								<tr role="row">
									<td>부서</td>
									<td id="department">${evo.department.department_name}<button type="button" class="btn btn-default" id="tree-btn">부서 변경</button></td>
									<td hidden="hidden"><input type="hidden" id="department_no" name="department[department_no]" value="${evo.department.department_no}"></td>
								</tr>
								<tr role="row">
									<td>직위</td>
									<td><label class="bmax v2 Mr0"> <select id="position" name="position" class="select_insa">
											<option value="-1">직위 선택</option>
											<option value="회장"<c:if test="${evo.position=='회장'}">selected="selected"</c:if>>회장</option>
											<option value="사장"<c:if test="${evo.position=='사장'}">selected="selected"</c:if>>사장</option>
											<option value="부사장"<c:if test="${evo.position=='부사장'}">selected="selected"</c:if>>부사장</option>
											<option value="전무"<c:if test="${evo.position=='전무'}">selected="selected"</c:if>>전무</option>
											<option value="상무"<c:if test="${evo.position=='상무'}">selected="selected"</c:if>>상무</option>
											<option value="이사"<c:if test="${evo.position=='이사'}">selected="selected"</c:if>>이사</option>
											<option value="공장장"<c:if test="${evo.position=='공장장'}">selected="selected"</c:if>>공장장</option>
											<option value="부장"<c:if test="${evo.position=='부장'}">selected="selected"</c:if>>부장</option>
											<option value="차장"<c:if test="${evo.position=='차장'}">selected="selected"</c:if>>차장</option>
											<option value="팀장"<c:if test="${evo.position=='팀장'}">selected="selected"</c:if>>팀장</option>
											<option value="과장"<c:if test="${evo.position=='과장'}">selected="selected"</c:if>>과장</option>
											<option value="대리"<c:if test="${evo.position=='대리'}">selected="selected"</c:if>>대리</option>
											<option value="사원"<c:if test="${evo.position=='사원'}">selected="selected"</c:if>>사원</option>
										</select>
									</label></td>
								</tr>
								<tr role="row">
									<td>이메일</td>
									<td><input type="text" pattern="/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i" name="email" value="${evo.email}" placeholder="example@example.com" style="width: 100%;"></td>
								</tr>
								<tr role="row">
									<td>입사일</td>
									<td><input type="text" id="datepicker" name="hiredate" value="${evo.hiredate}">
									</td>
								</tr>
								<tr role="row">
									<td>휴대폰번호</td>
									<td>
										<input type="text" value="${evo.phonenumber}" name="phonenumber" pattern="^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$" oninvalid="this.setCustomValidity('형식에 맞게 적어주세요 01X-xxx(x)-xxxx')" placeholder="형식에 맞게 적어주세요 01X-xxx(x)-xxxx" style="width: 100%;">
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
	<!-- 결재선 불러오기 modal -->
	<!-- 사용려는 곳에 버튼 만든뒤 id에 tree-btn만들기 -->
	<!-- value 0 : 부서만 1: 사원 포함 -->
	<jsp:include page="/WEB-INF/views/treeModal.jsp">
		<jsp:param value="0" name="load_type" />
		<jsp:param value="beforeClick" name="beforeClick" />
		<jsp:param value="null" name="beforeCheck" />
	</jsp:include>
</body>
</html>