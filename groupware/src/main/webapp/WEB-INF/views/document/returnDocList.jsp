<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<!-- 공통 JS, CSS를 모아서 불러오는 헤더-->
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<title>반려 문서함</title>
<script>
$(document).ready(function() {
	// 페이지당 보여줄 개수 변경시 호출
	$('.pg-scale').change(function() {
		location.href = 'returnDocList?page_scale=' + $(this).val()+'&keyword=${map.keyword}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>';
	});
});

//폼생성하여 post 방식으로 값 보내기 
function post_to_url(path, params, method) {
    method = method || "post"; // 전송 방식 기본값을 POST로
 
    
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
    form.submit();
}
</script>


</head>
<body>
	<!-- 전체 div-->
	<div id="wrapper">
		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper">

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">반려 문서함</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading"></div>
						<div class="panel-body">
							<div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
								<div class="row">
									<div class="col-lg-5">
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
									<form action="returnDocList">
										<input type="hidden" name="page_scale" value="${page.page_scale}">
										<div class="col-lg-3">
											<label><input type="checkbox" name="searchOption" value="document_title" checked="checked" multiple="multiple">제목 </label><label><input type="checkbox" name="searchOption" value="document_contents" multiple="multiple">내용</label>
										</div>
										<div class="col-lg-4">
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
											<th>문서 번호</th>
											<th>제목</th>
											<th>문서 생성일</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${dlist}" var="list">
											<tr>
												<td><input type="radio" name="check" class="check" value="${list.document_no}"> ${list.document_no}</td>
												<td><a href="javascript:post_to_url('/groupware/viewDoc',{'document_type':'3','document_no':'${list.document_no}'})">${list.document_title}</a></td>
												<td><fmt:formatDate value="${list.document_date}" pattern="yyyy/MM/dd" /></td>
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
														<a href="returnDocList?cur_page=${page.prevPage}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">Previous</a>
													</c:if></li>
												<c:forEach var="num" begin="${page.blockBegin}" end="${page.blockEnd }">
													<li class="paginate_button <c:if test="${num == page.curPage}"> active</c:if>" aria-controls="dataTables-example" tabindex="0"><a href="returnDocList?cur_page=${num}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">${num}</a></li>
												</c:forEach>
												<li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next"><c:if test="${page.curBlock <= page.totBlock}">
														<a href="returnDocList?cur_page=${page.nextPage}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">Next</a>
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
</body>
</html>