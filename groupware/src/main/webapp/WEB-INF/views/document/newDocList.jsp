<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<!-- header 및 navigation을 불러오기 위해서 사용해야하는 자원들 아래 다 복사해서 붙여넣기 하세요. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap Core CSS -->
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

<script>
$(document).ready(function() {
	$("#delete-btn").click(function(){
		if($('.check:checked').val()==null){
			alert("선택한 문서가 없습니다.");
		}else{
			var result = confirm('정말로 삭제하시겠습니까?');
			if (result) {
				$.ajax({
					method : "GET",
					url : "/groupware/removeDoc",
					data : {
						"document_no" : $('.check:checked').val()
					},
					error : function() {
						alert('삭제 실패!!');
					},
					success : function(data) {
						alert("총" + checkNum + "개의 양식이 삭제되었습니다.");
					}
				});
			}
		}
	});
});
</script>

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
					<h1 class="page-header">결재</h1>
				</div>
			</div>

			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">새 문서함</div>
					<div class="panel-body">
						<div class="panel panel-default">
							<div class="panel-heading">
								<button onclick="location='writeDoc'" class="btn btn-info">기안하기</button>
								<button onclick="location='writeDoc'" class="btn btn-info">수정하기</button>
								<button id="delete-btn" class="btn btn-info">삭제하기</button>
								<button onclick="location='writeDoc'" class="btn btn-info">새 문서 작성</button>
							</div>
							<div class="panel-body">
								<div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
									<div class="row">
										<div class="col-sm-5">
											<div class="dataTables_length" id="dataTables-example_length">
												<label>Show <select name="page_scale" class="form-control input-sm pg-scale">
														<option value="10" <c:if test="${page.page_scale==10}">selected="selected"</c:if>>10</option>
														<option value="25" <c:if test="${page.page_scale==25}">selected="selected"</c:if>>25</option>
														<option value="50" <c:if test="${page.page_scale==50}">selected="selected"</c:if>>50</option>
														<option value="100" <c:if test="${page.page_scale==100}">selected="selected"</c:if>>100</option>
												</select> entries
												</label>
											</div>
										</div>
										<form action="newDocList">
											<input type="hidden" name="page_scale" value="${page.page_scale}">
											<div class="col-sm-3">
												<label><input type="checkbox" name="searchOption" value="document_title" checked="checked" multiple="multiple">제목   </label><label><input type="checkbox" name="searchOption" value="document_contents" multiple="multiple">내용</label>
											</div>
											<div class="col-sm-4">
												<div id="dataTables-example_filter" class="dataTables_filter">
													<label>Search: <input type="search" class="form-control input-sm search" placeholder="" name="keyword">
													</label>
													<button class="btn btn-primary btn-sm">
														<i class="fa fa-search"></i>
													</button>
												</div>
											</div>
										</form>
									</div>
									<table class="table table-bordered" id="dataTable">
										<colgroup>
											<col width="15%">
											<col width="70%">
											<col width="15%">
										</colgroup>
										<thead>
											<tr role="row">
												<th>번호</th>
												<th>제목</th>
												<th>기안일</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${dlist}" var="list">
												<tr>
													<td><input type="radio" name="check" class="check" value="${list.document_no}"> ${list.document_no}</td>
													<td><a href="viewNewDoc?document_no=${list.document_no}">${list.document_title}</a></td>
													<td>${list.document_date}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<div class="row">
										<div class="col-sm-6">
											<div class="dataTables_info" id="dataTables-example_info" role="status" aria-live="polite">Showing ${page.pageBegin} to ${page.pageEnd} of ${page.count} entries</div>
										</div>
										<div class="col-sm-6">
											<div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
												<ul class="pagination">
													<li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous"><c:if test="${page.curBlock > 1}">
															<a href="newDocList?cur_page=${page.prevPage}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">Previous</a>
														</c:if></li>
													<c:forEach var="num" begin="${page.blockBegin}" end="${page.blockEnd }">
														<li class="paginate_button <c:if test="${num == page.curPage}"> active</c:if>" aria-controls="dataTables-example" tabindex="0"><a href="newDocList?cur_page=${num}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">${num}</a></li>
													</c:forEach>
													<li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next"><c:if test="${page.curBlock <= page.totBlock}">
															<a href="newDocList?cur_page=${page.nextPage}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">Next</a>
														</c:if></li>
												</ul>
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
	</div>
</body>
</html>
