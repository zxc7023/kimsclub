<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<!-- header 및 navigation을 불러오기 위해서 사용해야하는 자원들 아래 다 복사해서 붙여넣기 하세요. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap Core CSS -->

<link href="${pageContext.request.contextPath}/resources/css/board/board.css" rel="stylesheet">

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
		$("#sendBtn").click(function(){
			$("#messageSave").submit();
		});
		
	});
</script>
<title>쪽지작성</title>
</head>
<body>
<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">쪽지작성</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
             <!-- 게시판 타입명  -->${sessionScope.loginInfo.employee_name}
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
	        <!-- 받는이 선택 --> 
	        				<form id="messageSave" action="messageWrite" method="post">
	                            <div class="row">
	                            	<div class="col-sm-8">
	                            		<div class="form-group input-group">
                                            <span class="input-group-addon">받는이</span>
                                            <input type="text" class="form-control" name="message_receiver_no" placeholder="Username" >
                                            <span class="input-group-btn">
                                                <button class="btn btn-warning" type="button"><i class="glyphicon glyphicon-user"></i>
                                                </button>
                                            </span>
	                            		</div>
	                            	</div>
	                            </div>
	         <!-- 쪽지 내용 입력  -->
	                            <div class="row">
                          		 	 <div class="col-sm-8">
                          				  <textarea class="form-control" rows="15" cols="80" name="message_contents" ></textarea>
                           			 </div>
	                            </div>
             <!-- 쪽지 보내기  -->
	                            <div class="row">
	                            	<div class="col-sm-6">
	                            		 <div class="dataTables_info" id="dataTables-example_info" role="status" aria-live="polite">
	                            		 	<button id="sendBtn" type="button" class="btn btn-primary">send</button>
	                            		 </div>
	                            	</div>
	                            </div>
	                        </form>    
                            </div>
                        </div>
                    </div>
                </div>
            </div>
	</div>
</div>
</body>
</html>