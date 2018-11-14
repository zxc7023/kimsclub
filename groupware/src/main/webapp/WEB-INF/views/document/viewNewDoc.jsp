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

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>

<style type="text/css">

#sign td{
height: 80px;
}
</style>
<script>
$("#approval-btn").click(function(){
	if($('.check:checked').val()==null){
		alert("선택한 문서가 없습니다.");
	}
	else{
		window.location.href = "/groupware/approvalDoc?document_no="+$('.check:checked').val();
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
					<h1 class="page-header">임시저장 문서</h1>
				</div>
			</div>

			<form class="col-sm-12" method="post">
				<div class="panel panel-default">
					<div class="panel-heading">
						<button id="approval-btn" class="btn btn-default">기안하기</button>
						<button type="button" onclick="location.href='modifyNewDoc?document_no=${dvo.document_no}'" class="btn btn-default">수정하기</button>
						<input type="button" class="btn btn-default" onclick="location.href='/groupware/newDocList'" value="돌아가기">
					</div>
					<div class="panel-body">
						<table class="table table-bordered dataTable no-footer dtr-inline" id="dataTables-example" role="grid" aria-describedby="dataTables-example_info">
							<colgroup>
								<col width="20%">
								<col width="30%">
								<col width="20%">
								<col width="30%">
							</colgroup>
							<tbody>
								<tr>
									<td class="odd">작성자</td>
									<td colspan="3">${dvo.employee.employee_name}</td>
								</tr>
								<tr>
									<td class="odd">문서 제목<br>
									</td>
									<td colspan="3">${dvo.document_title}</td>
								</tr>
								<tr>
									<td class="odd">문서 생성일</td>
									<td><fmt:formatDate value="${dvo.document_date}" pattern="yyyy/MM/dd" /></td>
									<td class="odd">문서 상태</td>
									<td>${dvo.document_state}</td>
								</tr>
								<tr>
									<td colspan="4" class="odd">문서 내용</td>
								</tr>
								<tr>
									<td colspan="4">
										<div class="col-lg-12">${dvo.document_contents}</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>