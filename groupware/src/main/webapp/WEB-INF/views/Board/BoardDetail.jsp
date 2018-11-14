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
		var searchOption = "${param.searchOption}";
		var keyword = "${param.keyword}"; 
		var curPage = "${param.curPage}";
		var replyDelBtn = "board";
		var reply_no;
		
		
		//게시글 목록 버튼 클릭
		$("#listBtn").click(function(){
			location.href = "boardList?board_type="+boardType+"&searchOption="+searchOption+"&keyword="+keyword+"&curPage="+curPage;
		});
		
		
		//게시글 수정 버튼 클릭
		$("#boardUpdateBtn").click(function(){
			$("#boardUpdateForm").submit();
		});
				
		//게시글 삭제 버튼, 댓글 삭제 버튼 클릭
		$("#deleteBtn").click(function(){
			//댓글 삭제 버튼 클릭시
			if(replyDelBtn=="reply"){
				$.ajax({
					type : "get",
					url: "${pageContext.request.contextPath}/ReplyDelete",
					data: {"reply_no" : reply_no,
							"reply_board_type" : boardType},
					error : function(request,status,error){
		            },
		            success : function(data){
		            	listReply();
		            	replyCnt();
		            }
				});
				replyDelBtn = "board";
			//게시글 삭제 버튼 클릭시
			}else{
				location.href = "BoardDelete?board_no="+boardNo+"&board_type="+boardType;
			}
		});
		
		
		listReply();
		replyCnt();
		
		//댓글 목록 ajax
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
						for(var j=0;j < result[i].reply_depth ; j++ ){//댓글의 댓글 depth
							output += '<span class="chat-img pull-left" style="padding-left:1%">&nbsp;</span>';
						}
						output += '<span class="chat-img pull-left"><div style="background-color: #fff; line-height: 50px; font-size: 1.4em; text-align: center; border-radius: 50% 50% 50% 50%; width: 50px; height: 50px; color: #999999;" class="timeline-badge"><i class="glyphicon glyphicon-user  "></i></div></span>';
						output += '<div class="chat-body clearfix">';
						output += '<div class="header">';
						output += '<input class="replyNo" type="hidden" value="'+result[i].reply_no+'">';
						output += '<input class="replyDepth" type="hidden" value="'+result[i].reply_depth+'">';
						output += '<input class="replyOrder" type="hidden" value="'+result[i].reply_order+'">';
						output += '<input class="replyGroup" type="hidden" value="'+result[i].reply_group+'">';
						output += '<strong class="primary-font">'+result[i].reply_writer +'</strong>';
						output += '<small class="text-muted"> '+result[i].reply_date+'</small>';
						output += ' <i class="glyphicon glyphicon-share-alt text-muted"></i><small class="text-muted "><a class="replyBtn" href="#">답글</a></small>'
						if(result[i].reply_writer_no == '${sessionScope.loginInfo.employee_no}'){//작성자가 작성한 댓글은 수정,삭제버튼 보이게
						output += '<small class="pull-right text-muted"><button type="button" class="replyrevBtn btn btn-outline btn-success">R</button><button type="button" value="reply" class="replyDelBtn btn btn-outline btn-danger" data-toggle="modal" data-target="#myModal">D</button></small>';
						}
						output += '</div>';
						output += '<p>'+result[i].reply_contents+'</p>';
						output += '</div>';
						output += '</li>';
						}
					$('#replyInsert').html(output);
				}
			});
		}
		
		//댓글 삭제 버튼
		$(document).on("click",".replyDelBtn", function(){
			//댓글 list중 삭제하기 위한 댓글의 버튼을 구분하기 위한 값 가져오기
			replyDelBtn=$(".replyDelBtn").val();
			//해당 댓글의 댓글번호를 가져와서 reply_no 전역 변수에 저장
			reply_no = $(this).parents("li.clearfix").find(".replyNo").val();
		});
		
		//댓글 수정 버튼
		$(document).on("click",".replyrevBtn", function(){
			if($('.replyAdd').length){
				$("li.replyAdd").remove();
				$(".replyHidden").remove();
			}else{
				//해당 댓글 번호 가져오기
				reply_no = $(this).parents("li.clearfix").find(".replyNo").val();
				//해당 댓글의 내용 가져오기
				var replyContent = $(this).parents("li.clearfix").find("p").text();
				//hidden 댓글 번호 추가
				var inputReplyRev ='<input type="hidden" class="replyHidden" id="reply_no" name="reply_no" value="'+reply_no+'">';
				//replyWrite form 안에 댓글번호 hidden 적용
				var replyRevise =$("#replyWrite").append(inputReplyRev);
				//댓글 입력 form 전체 가져오기
				var replyRevForm = $(".replyForm").html();
				//댓글 list에 댓글 수정 입력 form 적용
				var replyTextInput = '<li class="left clearfix replyAdd">'+replyRevForm+'</li>';
				//버튼클릭시 p태그(댓글내용) 아래 댓글 수정 입력form 나타내기 
				$(this).parents("li.clearfix").find("p").append(replyTextInput);
				//댓글 내용을 댓글입력폼 textarea안에 적용하여 나타내기
				$(this).parents("li.clearfix").find("#replyText").text(replyContent);
				//해당 댓글 입력 버큰 id값 변경
				$(this).parents("li.clearfix").find("#save").attr("id","replyRevise");
				$(this).parents("li.clearfix").find("#replyWrite").attr("id","replyUpdate");
			}
		});
		
		//댓글 수정 ajax
		$(document).on("click","#replyRevise",function(){
			$.ajax({
				type : "get",
				url: "${pageContext.request.contextPath}/ReplyUpdate",
				data: $("#replyUpdate").serialize(), //serialize()사용으로 form에 있는 데이터를 한번에 url파라미터 형식 테스트 문자열로 변환
				error : function(request,status,error){
	                alert('실패');
	            },
	            success : function(data){
	            	$("#replyText").val(""); 
	            	listReply();
	            	replyCnt();
	            }
			});
			$(".replyHidden").remove();
		});
		
		//댓글 링크 클릭시(동적 태그 이벤트) 
		$(document).on("click",".replyBtn",function(){
			if($('.replyAdd').length){
				$("li.replyAdd").remove();	
				$('.replyBtn').html("답글");
				$(".replyHidden").remove();
			}else{
				$(".replyHidden").remove();
				//댓글의 그룹번호 가져오기
				var replyGroup = $(this).parents("li.clearfix").find(".replyGroup").val();
				var replyOrder = $(this).parents("li.clearfix").find(".replyOrder").val();
				var replyDepth = $(this).parents("li.clearfix").find(".replyDepth").val();
				var replyNo = $(this).parents("li.clearfix").find(".replyNo").val();
				// hidden으로 replyGroup 값설정
				var input = '<input type="hidden" class="replyHidden" id="reply_group" name="reply_group" value="'+replyGroup+'">';
				input += '<input type="hidden" class="replyHidden" id="reply_order" name="reply_order" value="'+replyOrder+'">';
				input += '<input type="hidden" class="replyHidden" id="reply_depth" name="reply_depth" value="'+replyDepth+'">';
				input += '<input type="hidden" class="replyHidden" id="reply_no" name="reply_no" value="'+replyNo+'">';
				// form 태그에 input데이터 추가
				var replyWrite = $("#replyWrite").append(input);
				var replyForm = $(".replyForm").html();
				var textInput='<li class="left clearfix replyAdd">'+replyForm+'</li>';
				$(this).parents("li.clearfix").after(textInput);
				$("li.replyAdd").find("#save").attr("id","replyOfreply");
				$("li.replyAdd").find("#replyWrite").attr("id","replyOfreplyWrite");
				$(this).html("답글취소");
			}
		});
		
		//댓글 쓰기 버튼 클릭시 ajax
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
	            	replyCnt();
	            }
			});
			
			$(".replyHidden").remove();
		});	
		
		//댓글의 답글 버튼 클릭시 ajax
		$(document).on("click","#replyOfreply",function(){
			
			$.ajax({
				type : "post",
				url: "${pageContext.request.contextPath}/ReplyWrite",
				data: $("#replyOfreplyWrite").serialize(), //serialize()사용으로 form에 있는 데이터를 한번에 url파라미터 형식 테스트 문자열로 변환
				error : function(request,status,error){
	                alert('실패');
	            },
	            success : function(data){
	            	$("#replyText").val("");
	            	listReply();
	            	replyCnt();
	            }
			});
			
			$(".replyHidden").remove();
		});	
		
		//댓글 조회수 ajax
		function replyCnt(){
			$.ajax({
				type :"post",
				url : "${pageContext.request.contextPath}/ReplyCnt",
				data : {"board_no" : $("#board_no").val(), 
						"reply_board_type" : $("#reply_board_type").val() },
				error : function(request,status,error){
			    	alert('실패');
			    },
				success: function(result){
					$(".replyCount").text("댓글"+"["+result+"]");
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
                <form action="BoardUpdate" id="boardUpdateForm" method="post" >
                	<!-- <div id="dataTables-example_filter" class="form-group input-group dataTables_filter"> -->
                	<label id="dataTables-example_filter" >
                	
	                	<button id="listBtn" type="button" class="btn btn-outline btn-primary"><i class="fa fa-list"></i></button>
	                	<c:if test="${sessionScope.loginInfo.employee_no == detailVO.board_writer_no}">
		                	<input type="hidden" name="board_no" value="${param.board_no}">
		                	<input type="hidden" name="board_type" value="${param.board_type}">
		                	<input type="hidden" name="board_title" value="${detailVO.board_title}">
		                	<input type="hidden" name="board_contents" value='${detailVO.board_contents}'>
			            	<button type="button" id="boardUpdateBtn" class="btn btn-success">수정</button>
			            	<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal">삭제</button>
		            	</c:if>
	            	</label>
				</form>
                </div>
            </div>
			
			<div class="row">
            	<div class="col-lg-12">
                	<div class="panel panel-default">
                    	<!-- 작성자, 작성일, 조회수 -->
                        <div class="panel-heading">
	                    	<i class="glyphicon glyphicon-user"></i> ${detailVO.board_writer} | ${detailVO.board_date}
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
            		<div class="dataTables_info replyCount" id="dataTables-example_info" role="status" aria-live="polite">
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
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">알림</h4>
            </div>
            <div class="modal-body">
            	정말로 삭제 하시겠습니까?
            </div>
            <div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            	<button id="deleteBtn" type="button" class="btn btn-primary" data-dismiss="modal">Delete</button>
       		</div>
     	</div>
	</div>
</div>

</body>
</html>