<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html >
<html>
<head>
<!-- 에디터 경로 -->
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
		if($("#title").val()==""){
			alert("제목을 입력해주세요.")	
		}else{
		$("#writeSave").submit();
		}
	});

	if("${update}"=="update"){
		$("#title").val("${boardUpdateVO.board_title}");
		$("#boardNo").attr("name","board_no");
		$("#boardNo").val("${boardUpdateVO.board_no}");
		$("#writeSave").attr("action","BoardUpdateSave");
	}
});

</script>
<title>게시글 작성</title>
</head>
<body>
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
                            <form id="writeSave" action="BoardWrite" method="post">
                            
                            	<!-- 제목 입력 -->
                            	<div class="row">
		                        	<div class="col-sm-12">
                                    	<div class="form-group input-group ">
                                        	<span class="input-group-addon">제목</span>
                                        	<input id="title" type="text" class="form-control" name="board_title">
                                    	</div>
	                          		 </div>
                          		 </div>
                          		 
                          		 <!-- 내용 입력 -->
                        		 <div class="row">
                          		 	 <div class="col-sm-12">
                          				  <textarea rows="50" id="ckeditor" cols="90" name="board_contents">${boardUpdateVO.board_contents}</textarea>
                           			 </div>
                           		 </div>
                           		 <input type="hidden" id="boardNo">
                           		 <input type="hidden" id="boardType" name="board_type" value="${param.board_type}" >
                           		 <button id="save" type="button" class="btn btn-outline btn-primary">저장</button>                        		 
                           	</form>
                        </div>
                    </div>
                </div>
            </div>
	    </div>
   </div>
</body>
</html>