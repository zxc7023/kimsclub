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
		//댓글 쓰기 버튼 클릭
		$("#save").click(function(){
			
			$.ajax({
				type : "post",
				url: "${pageContext.request.contextPath}/ReplyWrite",
				/* dataType : 'text', */
				data: $("#replyWrite").serialize(), //serialize()사용으로 form에 있는 데이터를 한번에 url파라미터 형식 테스트 문자열로 변환
				error : function(request,status,error){
	                alert('실패');
	            },
	            success : function(data){
	                listReply();

	            }
			});
		});
		
		//댓글 목록 
		function listReply(){
			$.ajax({
				type :"post",
				url: "${pageContext.request.contextPath}/ReplyList",
				success: function(result){
					alert("성공");
				}
			});
		}
	});
	
</script>

<title>Insert title here</title>
</head>
<body>
<div id="wrapper">
	<!-- header,navigation div -->
	<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>
		<!-- content div -->
		<div id="page-wrapper">
		
			<!-- 게시글 제목  row-->
			<div class="row">
                <div class="col-lg-6">
                    <h1 class="page-header">${detailVO.board_title}</h1>
                </div>
                
                <!-- 목록,수정,삭제 버튼 -->
                <div class="col-lg-12">
                     <div id="dataTables-example_filter" class="form-group input-group dataTables_filter">
                     <button type="button" class="btn btn-outline btn-primary"><i class="fa fa-list"></i></button>
	            		<button type="button" class="btn btn-success">수정</button>
	            		<button type="button" class="btn btn-danger">삭제</button>
            		</div>
                </div>
                
            </div>

			<div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                    
                    	<!-- 작성자, 작성일, 조회수 -->
                        <div class="panel-heading">
	                        ${detailVO.board_writer}
                        </div>
                        
                        <!-- 게시글 내용 -->
						<!-- css등록 style -->                        
                        <div class="panel-body" style="height: auto; min-height: 600px;">
                            <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                            	<!-- 제목 입력 -->
                            	<div class="row">
		                            <div class="col-lg-12">
		                          		   <div class="form-group">
		                          		   ${detailVO.board_contents}
                                      	   </div>
	                          		</div>
                          		</div>
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    
                    <!-- /.panel -->
                </div>
                
                <!-- /.col-lg-12 -->
            </div>
            
            <div class="row">
            	<div class="col-sm-6">
            		<div class="dataTables_info" id="dataTables-example_info" role="status" aria-live="polite">
            			댓글
            		</div>
            	</div>
            	<div class="col-sm-6">
            		<div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
            		
            		</div>
            	</div>
            </div>
            
            <div class="row">
				<div class="col-sm-12">
    	        <div class="well">
    	        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <td><i class="glyphicon glyphicon-user"></i></td>
                                        </tr>
                                    
                                        <tr>
                                            <td>1</td>
                                            <td>Mark</td>
                                            <td>Otto</td>
                                            <td>@mdo</td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>@fat</td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Larry</td>
                                            <td>the Bird</td>
                                            <td>@twitter</td>
                                        </tr>
                                    <thead>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
    	        
    	        	<!-- 댓글 입력 -->
    	        	<form id="replyWrite"  method="post">
	    	        	<div class="form-group input-group">
		                        <textarea class="form-control" rows="1" id="replyText" name="reply_contents" ></textarea>
							    <span class="input-group-btn">
							    	<input type="hidden" name="reply_board_type" value="${param.board_type}" >
							    	<input type="hidden" name="board_no" value="${param.board_no}" >
		                       		<button id="save" class="btn btn-primary" type="button"><i class="fa fa-comments"></i></button>
		                        </span>
	                    </div>
                    </form>
	            </div>
    			</div>        
        	</div>
   		</div>
</div>
</body>
</html>