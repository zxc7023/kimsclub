<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<!-- 공통 JS, CSS를 모아서 불러오는 헤더-->
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<!-- jquery-serializeObject.js  -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-serializeObject.js"></script>
<title>완료 문서함</title>
<style type="text/css">
#sign td{
height: 80px;
}
</style>
<script>
$(document).ready(function() {
	var send = {
			document_no : ${dvo.document_no}
	};
	//체크된 부서나 사원 가져오기
	$('#checkDepAndEmp').click(function(){
		var send = [];
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = treeObj.getCheckedNodes(true);
	   	var method = method || "post"; // 전송 방식 기본값을 POST로
	    
	    
	    var form = document.createElement("form");
	    form.setAttribute("method", method);
	    form.setAttribute("action", "/groupware/sendDoc");
		
		for (var key in nodes) {
			if (!nodes[key].parent) {
				 var hiddenField = document.createElement("input");
			        hiddenField.setAttribute("type", "hidden");
			        hiddenField.setAttribute("name", "employee_no");
			        hiddenField.setAttribute("value", nodes[key].no.split('e')[1]);
				
			        form.appendChild(hiddenField);
			}
		}
		var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "document_no");
        hiddenField.setAttribute("value", ${dvo.document_no});
        form.appendChild(hiddenField);
		document.body.appendChild(form);
	    console.log(document.body);
	    form.submit();
		
	});
	
	
	$("#sendPublic-btn").click(function(){
		if(confirm("이 문서를 전 사원이 볼 수 있는 공람문서함으로 보내시겠습니까?")){

			console.log(send);
			post_to_url('/groupware/sendPublicDoc',send);
		}
	});
    if('${dayOff}'==1){
        $('#department_name').html("${dvo.approval[0].employee.department.department_name}");
    }
	
	//결재한 사람 확인해서 sign 넣어주기
	var arr = {
			approval_state: [],
			approval_no: [],
			employee_no: []
	}
	<c:forEach items="${dvo.approval}" var="approval">
		arr.approval_state.push("${approval.approval_state}");
		arr.approval_no.push("${approval.approval_no}");
		arr.employee_no.push("${approval.employee.employee_no}");
	</c:forEach>
	
	/* for(var i = 0; i<arr.approval_state.length; i++){
		if(arr.approval_state[i]==1){
			alert(arr.employee_no[i]);
			$("#sign[index='"+i+"']").html("<img src='${pageContext.request.contextPath}/resources/images/"+arr.employee_no[i]+".jpg' onError='javascript:noImageError(this)'>");
		}
	}
});
	function noImageError(obj){
		if(obj != null){
			obj.src = "${pageContext.request.contextPath}/resources/images/kimsClubSign.jpg";
		}
	} */
	
	for(var i = 0; i<arr.approval_state.length; i++){
		if(arr.approval_state[i]==1){
			
			$("#sign[index='"+i+"']").html("<img src='${pageContext.request.contextPath}/resources/images/kimsClubSign.jpg'>");
		}
	}
}); 

//폼생성하여 post 방식으로 값 보내기 
function post_to_url(path, params, method) {
    method = method || "post"; // 전송 방식 기본값을 POST로
 
 	console.log(params);
    var form = document.createElement("form");
    form.setAttribute("method", method);
    form.setAttribute("action", path);
 
    //히든으로 값을 주입시킨다.
    for(var key in params) {
        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", key);
        hiddenField.setAttribute("value", params[key]);
 
        form.appendChild(hiddenField);
    }
    
   	document.body.appendChild(form);
 	console.log(document.body);
	form.submit();
}
</script>
<style type="text/css">
#sign img{
width: 65px;
height: 65px;
}
</style>
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
					<h1 class="page-header">완료 문서</h1>
				</div>
			</div>
			
			<div class="row">
			<form class="col-sm-12" method="post">
				<div class="panel panel-default">
					<div class="panel-heading">
						<button type="button" id="tree-btn" class="btn btn-default">지정하여 문서 보내기</button>
						<button id="sendPublic-btn"  type="button" class="btn btn-default">공람문서함 보내기</button>
						<input type="button" class="btn btn-default" onclick="location.href='/groupware/completeDocList'" value="돌아가기">
					</div>
					<div class="panel-body">
						<div role="row">
							<!--<div class="col-lg-12">
								 <div class="panel panel-default" id="approvalLine">  -->
							<table
								class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline"
								role="grid" aria-describedby="dataTables-example_info"
								style="width: 100%;">
								<colgroup>
									<col width="15%">
									<col width="17%">
									<col width="17%">
									<col width="17%">
									<col width="17%">
									<col width="17%">
								</colgroup>
								<tbody class="t-body">
									<tr>
										<th colspan="6">결재 순서
											<p class="fa fa-long-arrow-right"></p>
										</th>
									</tr>
									<tr id="paste">
										<c:forEach begin="0" end="5" varStatus="i">
											<td class="name" index="${i.index}"
												style="text-align: center;">${dvo.approval[i.index].employee.department.department_name}<br>
												${dvo.approval[i.index].employee.employee_name}
												${dvo.approval[i.index].employee.position}
											</td>
										</c:forEach>
									</tr>
									<tr>
										<c:forEach begin="0" end="5" varStatus="i">
											<td index="${i.index}" style="text-align: center;">

												<div>
													<fmt:formatDate
														value="${dvo.approval[i.index].approval_date}"
														pattern="yyyy/MM/dd" />
												</div>
											</td>
										</c:forEach>
									</tr>
									<tr>
										<c:forEach begin="0" end="5" varStatus="i">
											<td id=sign index="${i.index}" style="text-align: center;"
												width="50px;" height="50px;"></td>
										</c:forEach>
									</tr>
								</tbody>
							</table>
						</div>


						<table class="table table-bordered dataTable no-footer dtr-inline"
							id="dataTables-example" role="grid"
							aria-describedby="dataTables-example_info">
							<colgroup>
								<col width="20%">
								<col width="30%">
								<col width="20%">
								<col width="30%">
							</colgroup>
							<tbody>

								<tr>
									<td class="odd">작성자</td>
									<td colspan="3">${dvo.employee.employee_name}</td>
								</tr>
								<tr>
									<td class="odd">문서 제목<br>
									</td>
									<td colspan="3">${dvo.document_title}</td>
								</tr>
								<tr>
									<td class="odd">문서 생성일</td>
									<td><fmt:formatDate value="${dvo.document_date}"
											pattern="yyyy/MM/dd" /></td>
									<td class="odd">문서 상태</td>
									<td>${dvo.document_state}</td>
								</tr>
								<tr>
									<td colspan="4" class="odd">문서 내용</td>
								</tr>
								<tr>
									<td colspan="4">
										<div class="col-lg-12">${dvo.document_contents}</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</form>
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
