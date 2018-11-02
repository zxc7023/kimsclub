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
		
		
		var boardType = "${param.board_type}";
		var boardNo = ${param.board_no};
		
		//게시글 목록 버튼 클릭
		$("#listBtn").click(function(){
			location.href = "boardList?board_type="+boardType;
		});
		
		//게시글 삭제 버튼 클릭
		$("#deleteBtn").click(function(){
			location.href = "BoardDelete?board_no="+boardNo+"&board_type="+boardType;
		});
		
		//댓글 링크 클릭시(동적 태그 이벤트) 
		$(document).on("click",".replyBtn",function(){
			if($('.replyAdd').length){
				$("li.replyAdd").remove();	
				$('.replyBtn').html("답글");
				$("#reply_group").remove();
			}else{
				$("#reply_group").remove();
				//댓글의 그룹번호 가져오기
				var replyGroup = $(this).parents("li.clearfix").find(".replyGroup").val();
				alert(replyGroup);
				// hidden으로 replyGroup 값설정
				var input ='<input type="hidden" id="reply_group" name="reply_group" value="'+replyGroup+'">';
				// form 태그에 input데이터 추가
				var replyWrite = $("#replyWrite").append(input);
				// 
				var replyForm = $(".replyForm").html();
				/* $("#reply_group").val(replyGroup); */
				/* var replyForm = $(".replyForm").html(); */
				var textInput='<li class="left clearfix replyAdd">'+replyForm+'</li>';
				$(this).parents("li.clearfix").after(textInput);
				$(this).html("답글취소");
			}
		});
		
		//댓글 쓰기 버튼 클릭
		$(document).on("click","#save",function(){
			
			$.ajax({
				type : "post",
				url: "${pageContext.request.contextPath}/ReplyWrite",
				data: $("#replyWrite").serialize(), //serialize()사용으로 form에 있는 데이터를 한번에 url파라미터 형식 테스트 문자열로 변환
				error : function(request,status,error){
	                alert('실패');
	            },
	            success : function(data){
	            	$("#replyText").val(""); 
	            	listReply();
	            }
			});
		});
		
		listReply();
		//댓글 목록
		function listReply(){
			$.ajax({
				type :"post",
				url : "${pageContext.request.contextPath}/ReplyList",
				data : {"board_no" : $("#board_no").val(), 
						"reply_board_type" : $("#reply_board_type").val() },
				error : function(request,status,error){
			    	alert('실패');
			    },
			    
				success: function(result){
					var output="";
					for(var i in result){
						output += '<li class="left clearfix">';
						output += '<span class="chat-img pull-left"><img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar" class="img-circle"></span>';
						output += '<div class="chat-body clearfix">';
						output += '<div class="header">';
						output += '<input class="replyGroup" type="hidden" value="'+result[i].reply_group+'">';
						output += '<strong class="primary-font">'+result[i].reply_writer +'</strong>';
						output += '<small class="text-muted"> '+result[i].reply_date+'</small>';
						output += ' <i class="glyphicon glyphicon-share-alt text-muted"></i><small class="text-muted "><a class="replyBtn" href="#">답글</a></small>'
						output += '</div>';
						output += '<p>'+result[i].reply_contents+'</p>';
						output += '</div>';
						output += '</li>';
						}
					
					$('#replyInsert').html(output);
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
                	<!-- <div id="dataTables-example_filter" class="form-group input-group dataTables_filter"> -->
                	<label id="dataTables-example_filter" >
	                	<button id="listBtn" type="button" class="btn btn-outline btn-primary"><i class="fa fa-list"></i></button>
		            	<button type="button" class="btn btn-success">수정</button>
		            	<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal">삭제</button>
	            	</label>
            		<!-- </div> -->
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
                        <div class="panel-body" style="height: auto; min-height: 300px;">
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
                    </div>
                </div>
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
            
			<!-- 댓글목록 -->					
            <div class="row">
				<div class="col-sm-12">
    	        <div class="well">
	    	        <div class="panel-body">
	                    <ul id="replyInsert" class="chat">
	                    
	                    
	                    	<!-- 이 안에 댓글이 들어감 -->
	                    	
	                    	
	                    </ul> 
	                </div>
    	        
    	        	<!-- 댓글 입력 -->
    	        	<div class="replyForm">
	    	        	<form id="replyWrite" method="post">
		    	        	<div class="form-group input-group">
			                	<textarea class="form-control" rows="1" id="replyText" name="reply_contents" ></textarea>
								    <span class="input-group-btn">
								    	<!-- <input type="hidden" id="reply_group" name="reply_group"> -->
								    	<input type="hidden" id="reply_board_type" name="reply_board_type" value="${param.board_type}" >
								    	<input type="hidden" id="board_no" name="board_no" value="${param.board_no}" >
			                       		<button id="save" class="btn btn-primary" type="button"><i class="fa fa-comments"></i></button>
			                        </span>
		                    </div>
	                    </form>
                    </div>
	            </div>
    			</div>        
        	</div>
   		</div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header ">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">알림</h4>
            </div>
            <div class="modal-body">
            	정말로 삭제 하시겠습니까?
            </div>
            <div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            	<button id="deleteBtn" type="button" class="btn btn-primary">Delete</button>
       		</div>
     	</div>
	</div>
</div>

</body>
</html>