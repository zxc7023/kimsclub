<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<!-- 공통 JS, CSS를 모아서 불러오는 헤더-->
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<script>
	$(document).ready(function() {
		//양식 활성화,비활성화 버튼 클릭 시 form_activation 수정
		$('.btn-form').click(function() {
			var check=0;
			checkSelect();
			var checkArr = [];
			var checkNum = 0;
			
			if(check==0){
				//체크된 번호들 배열에 입력 및 개수 구하기
				$('.check:checked').each(function() {
					$(this).parent().next().addClass('select');
					checkArr.push($(this).val());
					checkNum++;
				});
				//ajax내 배열 사용하기위한 설정
				jQuery.ajaxSettings.traditional = true;
	
				//삭제 버튼 클릭
				if ($(this).val() == '삭제') {
					var result = confirm('정말로 삭제하시겠습니까?');
					if (result) {
						$.ajax({
							method : "post",
							url : "/groupware/form/removeForm",
							data : {
								"form_no" : checkArr
							},
							error : function() {
								alert('삭제 실패!!');
								$('.select').removeClass('select');
							},
							success : function(data) {
								$('.select').parent().remove();
								alert("총" + checkNum + "개의 양식이 삭제되었습니다.");
								$('.select').removeClass('select');
							}
						});
					} else {
						$('.select').removeClass('select');
					}
				}
	
				//활성화 비활성화 버튼 클릭시
				else {
					$.ajax({
						method : "GET",
						url : "/groupware/form/useForm",
						data : {
							"use" : $(this).val(),
							"form_no" : checkArr
						},
						error : function() {
							alert(data + '변경실패!!');
							$('.select').removeClass('select');
						},
						success : function(data) {
							$('.select').html(data);
							alert("총" + checkNum + "개의 양식이 " + data + " 되었습니다.");
							$('.select').removeClass('select');
						}
					});
				}
			}
			//아무 양식도 선택 안했을 시 alert 알림
			 function checkSelect(){
				if($('.check:checked').val()==null){
					check=1;
					alert("선택된 양식이 없습니다.");
				}
			}

		});

		//모든 체크박스 선택 함수
		$('.check-all').click(function() {
			$('.check').prop('checked', this.checked);
		});

		// 페이지당 보여줄 개수 변경시 호출
		$('.pg-scale').change(function() {
			location.href = 'formList?page_scale=' + $(this).val()+'&keyword=${map.keyword}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>';
		});
		

	});//ready end
</script>
<title>양식 목록</title>
</head>
<body>
	<!-- 전체 div-->
	<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper" style="min-height: 927px;">

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">양식 관리</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<button onclick="location='createForm'" class="btn btn-default">양식 생성</button>
							<button class="btn btn-default btn-form" type="button" value="삭제">양식 삭제</button>
							<button class="btn btn-default btn-form" type="button" value="활성화">양식 활성화</button>
							<button class="btn btn-default btn-form" type="button" value="비활성화">양식 비활성화</button>
						</div>
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
									<form action="formList">
										<input type="hidden" name="page_scale" value="${page.page_scale}">
										<div class="col-lg-3">
											<label><input type="checkbox" name="searchOption" value="form_name" checked="checked" multiple="multiple">이름 </label> <label><input type="checkbox" name="searchOption" value="form_desc" multiple="multiple">설명 </label> <label><input type="checkbox" name="searchOption" value="form_contents" multiple="multiple">내용</label>
										</div>
										<div class="col-lg-4">
											<div id="dataTables-example_filter" class="dataTables_filter">
												<label>Search: <input type="search" class="form-control input-sm search" placeholder="" name="keyword" value="${map.keyword}">
												</label>
												<button class="btn btn-primary btn-sm">
													<i class="fa fa-search"></i>
												</button>
											</div>
										</div>
									</form>
								</div>
								<table class="table table-bordered" id="dataTable">
									<thead>
										<tr role="row">
											<th><p>
													<input type="checkbox" name="check-all" class="check-all">양식 번호
												</p></th>
											<th>사용 여부</th>
											<th>양식 이름</th>
											<th>양식 설명</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${formList}" var="list">
											<tr>
												<td><input type="checkbox" name="check" class="check" value="${list.form_no}"> ${list.form_no}</td>
												<td>${list.form_activation}</td>
												<td><a href="modifyForm?form_no=${list.form_no}">${list.form_name}</a></td>
												<td>${list.form_desc}</td>
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
														<a href="formList?cur_page=${page.prevPage}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">Previous</a>
													</c:if></li>
												<c:forEach var="num" begin="${page.blockBegin}" end="${page.blockEnd }">
													<li class="paginate_button <c:if test="${num == page.curPage}"> active</c:if>" aria-controls="dataTables-example" tabindex="0"><a href="formList?cur_page=${num}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">${num}</a></li>
												</c:forEach>
												<li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next"><c:if test="${page.curBlock <= page.totBlock}">
														<a href="formList?cur_page=${page.nextPage}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">Next</a>
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