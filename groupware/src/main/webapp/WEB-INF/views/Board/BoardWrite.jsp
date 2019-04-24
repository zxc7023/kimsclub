<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html >
<html>
<head>

<!-- 공통 JS, CSS를 모아서 불러오는 헤더-->
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<!-- 에디터 js-->
<script src="resources/ckeditor/ckeditor.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/board/board.css" rel="stylesheet">

<script type="text/javascript">

$(document).ready(function() {
	
	$(function(){
		
     	    CKEDITOR.replace( 'ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
     	   		width:'100%',
	            height:'400px',
	        	filebrowserUploadUrl: '${pageContext.request.contextPath}/upload'
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
                           		                         		 
                           	</form>
                        </div>
                        <div class="panel-footer">
                            <button id="save" type="button" class="btn btn-outline btn-primary">저장</button>
                        </div>
                    </div>
                </div>
            </div>
	    </div>
   </div>
</body>
</html>