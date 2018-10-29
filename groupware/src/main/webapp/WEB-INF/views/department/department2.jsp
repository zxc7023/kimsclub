<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- header 및 navigation을 불러오기 위해서 사용해야하는 자원들 아래 다 복사해서 붙여넣기 하세요. -->
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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css"
	integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">


<!-- DataTables CSS -->
<!-- <link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet"> -->

<!-- DataTables Responsive CSS -->
<!-- <link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet"> -->

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/jquery.orgchart.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery.orgchart.js"></script>

<script>
	$(document).ready(function() {
		var department_json = ${requestScope.department_json};
		var org_chart = $('#orgChart').orgChart({
			data : department_json, //데이터
			showControls : true, //보여줄지말지
			allowEdit : true, //제목이 수정가능할지 아닐지
			onAddNode : function(parent_node) {
				$.ajax({
					method : "post",
					dataType : "json",
					contentType : 'application/json;charset=UTF-8',
					url :  "${pageContext.request.contextPath}/humanResources/getDepartmentSeq",
					error : function() {
						alert('전송 실패');
					},
					success : function(server_result) {
						console.log("성공");
					}
				}).done(function(server_result){
					var server_json = server_result;
					department_no_seq = server_json.department_no;
					org_chart.newNode(department_no_seq,parent_node.data.department_no);
				});
				console.log(org_chart.getData());
			},
			onDeleteNode : function(node) {
				org_chart.deleteNode(node.data.department_no);
			},
			onDeleteNodeDB : function(node){
				console.log(node);
				$.ajax({
					method : "post",
					dataType : "json",
					data : JSON.stringify(node),
					contentType : 'application/json;charset=UTF-8',
					url :  "${pageContext.request.contextPath}/humanResources/removeDepartments",
					error : function() {
						alert('전송 실패');
					},
					success : function(server_result) {
						var server_json = server_result;
						result = server_json.result;
						console.log(result);
					}
				});
			},
			onClickNode : function(node) {
				// log('Clicked node '+node.data.department_no);
			},
			onChangedNodeDB : function(node){
				console.log(node);
				$.ajax({
					method : "post",
					dataType : "json",
					data : JSON.stringify(node),
					contentType : 'application/json;charset=UTF-8',
					url :  "${pageContext.request.contextPath}/humanResources/modifyDepartmentName",
					error : function() {
						alert('전송 실패');
					},
					success : function(server_result) {
						var server_json = server_result;
						result = server_json.result;
						console.log(result);
					}
				});
			},
			onAddNodeDB : function(node){
				console.log(node);
				$.ajax({
					method : "post",
					dataType : "json",
					data : JSON.stringify(node),
					contentType : 'application/json;charset=UTF-8',
					url :  "${pageContext.request.contextPath}/humanResources/addDepartment",
					error : function() {
						alert('전송 실패');
					},
					success : function(server_result) {
						var server_json = server_result;
						result = server_json.result;
						console.log(result);
					}
				})
			}
		});
		$("#orgSave").click(function() {
			console.log(org_chart.getData());
		});
	});
</script>
<title>예제</title>
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
					<div id="orgChart"></div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>