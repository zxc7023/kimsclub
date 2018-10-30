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

<script type="text/javascript">
$(document).ready(function() {
	
	$('.myApprovalLine').change(function(){
		$.ajax({
			method : "GET",
			url : "/groupware/selectMyApprovalLine",
			data : {
				"approval_path_no" : $('.myApprovalLine option:selected').val()
			},
			error : function() {
				alert("양식 불러오기 실패");
			},
			success : function(data) {
				$('.approvalLine').html("");		
				for(var i=0;i<data.length;i++){
					$('.approvalLine').append("<li>"+data[i].employee.department.department_name+":"+data[i].employee.position+":"+data[i].employee.employee_name+"</li>");

				}
			}
		});
	});
});
</script>
</head>
<body>

	<!-- 아래의 구조로 복사하시오 -->
	<!-- 전체 div-->
	<div id="wrapper">
		<!-- content div -->
		<div id="page-wrapper"  >

			<div class="row">
				<div class="col-lg-12">
					<h3 class="page-header">결재선 선택</h3>
				</div>
			</div>

			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">내 결재선</div>
					<div class="panel-body">
						<select class="form-control myApprovalLine" style="width:100%;height:100px;" id="select_menuline" multiple="multiple">
							<c:forEach items="${alist}" var="alist">
								<option value="${alist.approval_path_no}">${alist.approval_path_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			
			<form class="col-lg-12">
				<table class="table no-footer">
					<tr>
						<td rowspan="2">
							<div class="col-lg-5 form-control" style="height: 500px;">1</div>
						</td>
						<td><div class="col-lg-2">2</div></td>
						<td rowspan="2"><div class="col-lg-4 form-control" style="height: 500px;"><ul class="approvalLine"></ul></div></td></tr>
					<tr><td><div class="col-lg-2"></div></td></tr>					

					
				</table>
			
			</form>
		</div>
	</div>
</body>
</html>
