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

<!-- z-tree js -->
<%-- <script src="${pageContext.request.contextPath}/resources/js/jquery.ztree.core.js"></script>
 --%>
 <script src="http://www.treejs.cn/v3//js/jquery.ztree.core.js"></script>
<!-- z-tree CSS -->
<link href="http://www.treejs.cn/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">


<script type="text/javascript">
	$(document).ready(function() {
		$('#menu1').click(function(){
			$.ajax({
				method : "get",
				contentType : 'application/json;charset=UTF-8',
				url : "/groupware/humanResources/departmentList?load_type=0",
				error : function() {
					alert("전송 실패");
				},
				success : function(server_result) {
					zNodes = JSON.parse(server_result);
					console.log(zNodes);
					
					var tree = $.fn.zTree.init($("#dropdown-menu"), setting, zNodes);
					tree.expandAll(true);
				} 
			});
		});
	});
	var setting = {
			view: {
				selectedMulti: false,
				addDiyDom:removeButton
			},
			//체크박스 사용 여부 부분
			check: {
				enable: false,
				chkStyle: "checkbox"
			},
			data: {
				key: {
					isParent: "parent",
					name:"name"
					
				},
				simpleData: {
					enable: true,
					idKey : "no",
					pIdKey : "pNo",
					cnt : "cnt",
					
				}
			},
			callback: {
				beforeClick : beforeClick
			},
			edit: {
			      enable: true,
			      drag: {
			         autoOpenTime: 0
			      }
			}
		};
	var zNodes =[];
	function beforeClick(treeId, treeNode) {
		$('#selected-menu').html(treeNode.name);
	}
	function removeButton(){
		$('span').removeClass("button");
	}
	
</script>
<title>Kim's Club</title>
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
					<h1 class="page-header">사용자 관리</h1>
				</div>
			</div>

			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<button type="button" id="addEmployee" class="btn btn-default">사용자 추가</button>

					</div>
					<div class="panel-body">
						<div class="panel">
							<div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
								<div class="row">
									<div class="col-sm-5">
										<div class="dropdown">
											<button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">
												<span id="selected-menu">보기</span><span class="caret"></span>
											</button>
											<ul class="dropdown-menu ztree" id="dropdown-menu" role="menu" aria-labelledby="menu1">
											</ul>
										</div>
									</div>
									<div class="col-sm-4" style="float: right;">
										<label>Search: <input type="search" class="form-control input-sm search" placeholder="이름,사원번호로 검색" autofocus="autofocus" name="keyword">
										</label>
										<button class="btn btn-primary btn-sm">
											<i class="fa fa-search"></i>
										</button>
									</div>
								</div>
								<table class="table table-bordered" id="dataTable">
									<thead>
										<tr role="row">
											<th>사원번호</th>
											<th>이름</th>
											<th>비밀번호</th>
											<th>부서명</th>
											<th>직위</th>
											<th>입사일</th>
											<th>이메일</th>
											<th>전화번호</th>
											<th>상태</th>
										</tr>
										<tr id="addUserField">
											<td class="C"></td>
											<td><label class="bmax v2"><input type="text" name="employee_name" class="textbox_insa" placeholder="이름 입력"></label></td>
											<td><label class="bmax v2"><input id="password" autocomplete="new-password" name="password" class="textbox_insa" placeholder="비밀번호 입력"></label></td>
											<td>
												<div class="dropdown">
													<button class="btn btn-default dropdown-toggle textbox_insa" type="button" id="menu2" data-toggle="dropdown">
														<span id="selected-menu">부서 선택</span>
													</button>
													<ul class="dropdown-menu ztree" id="dropdown-menu" role="menu" aria-labelledby="menu2">
													</ul>
												</div>
											</td>
											<td><label class="bmax v2 Mr0"> <select id="add_position" name="position" class="select_insa">
														<option value="-1">직위 선택</option>
														<option value="969">대표이사(회장)</option>
														<option value="1098">대표이사</option>
														<option value="423">회장</option>
														<option value="611">사장</option>
														<option value="350"></option>
														<option value="845">부사장</option>
														<option value="844">전무</option>
														<option value="843">상무</option>
														<option value="1096">상무이사</option>
														<option value="842">이사</option>
														<option value="1097">공장장</option>
														<option value="31">부장</option>
														<option value="838">차장</option>
														<option value="1099">팀장</option>
														<option value="5">과장</option>
														<option value="841">계장</option>
														<option value="23">대리</option>
														<option value="840">주임</option>
														<option value="992">백기사</option>
														<option value="6">사원</option>
														<option value="991">흑기사</option>
														<option value="849">태양신</option>
														<option value="972">기사</option>
												</select>
											</label></td>
											<td><label class="bmax v2"><input type="text" id="joindate" name="joindate" class="textbox_insa" placeholder="입사일 입력"></label></td>
											<td><label class="bmax v2"><input type="text" id="email" name="email" class="textbox_insa" placeholder="이메일 입력"></label></td>
											<td><label class="bmax v2"><input type="text" id="cell" name="cell" class="textbox_insa" placeholder="휴대전화 입력"></label></td>
											<td><a class="blue_color" href="javascript:void(0)" onclick="usermanage.addDirectMember();">저장</a></td>
										</tr>
									</thead>
									<tbody>
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
														<a href="approvalDocList?cur_page=${page.prevPage}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">Previous</a>
													</c:if></li>
												<c:forEach var="num" begin="${page.blockBegin}" end="${page.blockEnd }">
													<li class="paginate_button <c:if test="${num == page.curPage}"> active</c:if>" aria-controls="dataTables-example" tabindex="0"><a href="approvalDocList?cur_page=${num}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">${num}</a></li>
												</c:forEach>
												<li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next"><c:if test="${page.curBlock <= page.totBlock}">
														<a href="approvalDocList?cur_page=${page.nextPage}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">Next</a>
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
