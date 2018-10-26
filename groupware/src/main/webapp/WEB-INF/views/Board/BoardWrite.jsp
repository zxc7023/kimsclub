<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html >
<html>
<head>
<script src="resources/ckeditor/ckeditor.js"></script>

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
	
	$(function(){
     	    CKEDITOR.replace( 'ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
	            width:'100%',
	            height:'400px',
	        	filebrowserUploadUrl: '${pageContext.request.contextPath}/upload/ckeditor_upload.asp'
	        });
	         
	        CKEDITOR.on('dialogDefinition', function( ev ){
	            var dialogName = ev.data.name;
	            var dialogDefinition = ev.data.definition;
	          
	            switch (dialogName) {
	                case 'image': //Image Properties dialog
	                    //dialogDefinition.removeContents('info');
	                    dialogDefinition.removeContents('Link');
	                    dialogDefinition.removeContents('advanced');
	                    break;
	            }
	        });
	         
	    });
	
	$("#save").click(function(){
		$("#writeSave").submit();
	});
	
});//ready end

</script>
<title>Insert title here</title>
</head>
<body>
	<%-- <form id="frm" action="BoardWrite" method="post">
		<table width="100%">
			<tr>
			<td>제목</td>
			<td><input type="text" name="board_title"></td>
			</tr>
			
			<!-- <tr>
			<td>파일첨부</td><td><input type="file"> </td>
			</tr> -->
			
			<tr>
			<td>내용</td>
			<td><textarea rows="35" id="ckeditor" cols="90" name="board_contents"></textarea></td>
			</tr>
		</table>
		<input type="hidden" id="boardType" name="board_type" value="${param.boardType}" >
		<input type="submit" id="save" value="저장">
	</form> --%>
<div id="wrapper">
	<!-- header,navigation div -->
	<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>
		<!-- content div -->
		<div id="page-wrapper">
			<div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">글쓰기</h1>
                </div>
            </div>

			<div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                                                   글쓰기
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                            <form id="writeSave" action="BoardWrite" method="post">
                            
                            	<!-- 제목 입력 -->
                            	<div class="row">
		                            <div class="col-lg-12">
		                          		   <div class="form-group">
	                                            <label>제목</label>
	                                            <input class="form-control" type="text" name="board_title">
                                      	  </div>
	                          		 </div>
                          		 </div>
                          		 
                          		 <!-- 내용 입력 -->
                        		 <div class="row">
                          		 	 <div class="col-sm-12">
                          				  <textarea rows="35" id="ckeditor" cols="90" name="board_contents"></textarea>
                           			 </div>
                           		 </div>
                           		 <input type="hidden" id="boardType" name="board_type" value="${param.board_type}" >
                           		 <button id="save" type="button" class="btn btn-outline btn-primary">저장</button>                           		 
                           	</form>
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
	    </div>
   </div>
</body>
</html>