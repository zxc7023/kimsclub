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

<style type="text/css">

</style>
<script type="text/javascript">
	$(document).ready(function() {
		
		//메세지 답장할 경우
		if('${messageAnswer}' == 'messageAnswer'){
			$(".page-header").text("답장하기");
			$(".input-group-btn").remove();
			$("#userName").val('${answervo.message_senderAndReceiver_name}');
			//messageAnswer로 보낼 form만들기
			var hiddenField = document.createElement("input");
	        hiddenField.setAttribute("type", "hidden");
	        hiddenField.setAttribute("name", "message_receiver_no");
	        hiddenField.setAttribute("value", '${answervo.message_sender_no}');
			$(".form-group").append(hiddenField);
		}		
		else{
		//체크된 부서나 사원 가져오기
		$('#checkDepAndEmp').click(function(){
			$(".empNoCheck").remove();
			$("#userName").val("");
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			var nodes = treeObj.getCheckedNodes(true);
		   	var method = method || "post"; // 전송 방식 기본값을 POST로
		    var receiverName="";
		    var tmp= "";
		    
			for (var key in nodes) {
				if (!nodes[key].parent) {
					tmp+=(nodes[key].name+",");
					var hiddenField = document.createElement("input");
				        hiddenField.setAttribute("type", "hidden");
				        hiddenField.setAttribute("class", "empNoCheck");
				        hiddenField.setAttribute("name", "message_receiver_no");
				        hiddenField.setAttribute("value", nodes[key].no.split('e')[1]);
						$(".form-group").append(hiddenField);
				}
			}
			var receiverName = tmp.substring(0, tmp.length-1);
			$("#userName").val(receiverName);			
		});	
		}
		
		//쪽지 보내기 버튼
		$("#sendBtn").click(function(){
			if($("#userName").val()==""){
				alert("받는 사람을 입력해주세요.");
			}
			else{
			
			$("#messageSave").submit();
			}
		});
		
	});
</script>
<title>쪽지작성</title>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-6">
				<h1 class="page-header">쪽지작성</h1>
			</div>
		</div>
            
		<div class="row">
			<div class="col-lg-6">
				<div class="panel panel-primary">
					<div class="panel-heading">
            <!-- 게시판 타입명  -->${sessionScope.loginInfo.employee_name}
					</div>
				<div class="panel-body">
			<!-- 받는이 선택 --> 
					<form id="messageSave" action="messageWrite" method="post">
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group input-group">
									<span class="input-group-addon">받는이</span>
										<input id="userName" type="text" class="form-control" readonly="readonly" placeholder="Username">
                                    	<span class="input-group-btn">
                                    		<button id="tree-btn" class="btn btn-warning searchBtn" type="button"><i class="fa fa-search"></i></button>
                                		</span>
								</div>
							</div>
						</div>
			<!-- 쪽지 내용 입력  -->
						<div class="row">
							<div class="col-sm-12">
							<textarea id="textMsg" style="resize: none;" class="form-control" rows="15" cols="80" name="message_contents" ></textarea>
                           	</div>
						</div>
					</form>    
				</div>
    		<!-- 쪽지 보내기  -->                        
                        <div class="panel-footer">
                            <div class="dataTables_info" id="dataTables-example_info" role="status" aria-live="polite">
								<button id="sendBtn" type="button" class="btn btn-primary">send</button>
	                        </div>
                        </div>
                    </div>
                </div>
            </div>
	</div>
</div>
<!-- 결재선 불러오기 modal -->
	<!-- 사용려는 곳에 버튼 만든뒤 id에 tree-btn만들기 -->
	<!-- value 0 : 부서만 1: 사원 포함 -->
	<jsp:include page="/WEB-INF/views/treeModal.jsp">
		<jsp:param value="1" name="load_type" />
		<jsp:param value="null" name="beforeClick" />
		<jsp:param value="beforeCheck" name="beforeCheck" />
	</jsp:include>
</body>
</html>