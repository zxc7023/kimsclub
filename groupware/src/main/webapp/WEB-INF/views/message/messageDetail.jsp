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
		
		//게시글 목록 버튼 클릭
		$("#listBtn").click(function(){
			location.href = "messageList?box=${box}&curPage=${map.curPage}&page_scale=${map.page_scale}&searchOption=${map.searchOption}&keyword=${keyword}";
		});
		
		//
		
		//버튼(보관,답장,삭제) 클릭시
		$(".btn-form").click(function(){
						
		//보관 버튼 클릭
			if($(this).val()=='keep'){
				//보관 버튼을 클릭했을때
					var result = confirm("쪽지를 보관했습니다.");
					if(result){
						$.ajax({
							method : "POST",
							url : "${pageContext.request.contextPath}/keepMessage",
							data : {"message_no" : '${detailvo.message_no}'},
							error : function() {
								alert("보관실패");
							},
							success : function(data) {
								alert("보관완료");
							}
							});
						}
					}//keep end
		//답장 버튼 클릭			
			else if($(this).val()=='answer'){
				$("#answerForm").submit();
			}		
					
		//삭제 버튼을 클릭
			else{
					var result = confirm("쪽지를 삭제하시겠습니까?");
					if(result){
						$.ajax({
							method : "POST",
							url : "${pageContext.request.contextPath}/deleteMessage",
							data : {"message_no" : "${detailvo.message_no}",
									"box" : "${box}"
									},
							error : function() {
								alert("삭제 실패");
							},
							success : function(data) {
								location.href = "messageList?box=${box}"
								}
							});
						}
			}//delete end
			
		});
		
		//보낸 쪽지
		if('${box}' == 'outBox'){
			$(".page-header").text('보낸쪽지');
			$("title").text('보낸쪽지');
			$("#senderAndreceiver").text('받는사람');
		}
		//받은 쪽지
		else if('${box}' == 'inBox'){
			$(".page-header").text('받은쪽지');
			$("title").text('받은쪽지');
			$("#senderAndreceiver").text('보낸사람');
			
		}
		//내게쓴쪽지
		else if('${box}' == 'myBox'){
			$("#keepBtn").hide();
			$(".page-header").text('내게쓴쪽지');
			$("title").text('내게쓴쪽지');
			$("#senderAndreceiver").text('보낸사람');
		}
		//보관 쪽지
		else{
			$("#keepBtn").hide();
			$(".page-header").text('쪽지보관');
			$("title").text('쪽지보관');
			$("#senderAndreceiver").text('보낸사람');
		}
		
	});
</script>

<title>쪽지보기</title>
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
                    <h1 class="page-header"></h1>
                </div>
                
                <!-- 목록,수정,삭제 버튼 -->
                <div class="col-lg-12">
                	<label id="dataTables-example_filter" >
	                	<button id="listBtn" type="button" class="btn btn-outline btn-primary"><i class="fa fa-list"></i></button>
	                	<button id="answerBtn" type="button" class="btn btn-primary btn-form" value="answer">답장</button>
	                	<button id="keepBtn" type="button" class="btn btn-success btn-form"  value="keep">보관</button>
						<button type="button" class="btn btn-danger btn-form"  value="del">삭제</button>
	            	</label>
	            	<form id="answerForm" action="messageAnswer" method="post"  >
	            		<input type="hidden" name="message_sender_no" value="${detailvo.message_sender_no}" >
	            	</form>
                </div>
            </div>
			
			<div class="row">
            	<div class="col-lg-12">
                	<div class="panel panel-default">
                    	<!-- 작성자, 작성일, 조회수 -->
                        <div class="panel-heading">
	                    	<i class="fa  fa-envelope"></i> ${detailvo.message_senderAndReceiver_name} | ${detailvo.message_date}
                        </div>
                        
                        <!-- 게시글 내용 -->
						<!-- css등록 style -->                        
                        <div class="panel-body" style="height: auto; min-height: 300px;">
                            <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                            	<!-- 제목 입력 -->
                            	<div class="row">
		                            <div class="col-lg-12">
		                          		<div class="form-group">
		                          		   ${detailvo.message_contents}
                                    	</div>
	                          		</div>
                          		</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>			
   		</div>
</div>

</body>
</html>