<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

 <script src="http://www.treejs.cn/v3//js/jquery.ztree.core.js"></script>
<!-- z-tree CSS -->
<link href="http://www.treejs.cn/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">


<style type="text/css">
.setting_field input[type=text].textbox_insa, input[type=text].textbox_insa {
    border: 1px #cfcfcf solid;
    padding: 0 4px;
    color: #444;
    height: 28px;
    line-height: 27px;
}

.bmax>.textbox_insa, .bmax>select {
    width: 100%;
}

</style>
<script type="text/javascript">
	$(document).ready(function() {

		//사용자 추가 부분에서 부서 선택클릭 시 부서 목록불러오기
		$('#menu2').click(function(){
			callTree("menu2");
		});
		
		//보기 클릭시 어느 부서를 볼 지 정할 수 있다.
		$('#menu1').click(function(){
			callTree("menu1");
		});
		function callTree(menu){
			$.ajax({
				method : "get",
				contentType : 'application/json;charset=UTF-8',
				url : "/groupware/humanResources/departmentList?load_type=0",
				error : function() {
					alert("전송 실패");
				},
				success : function(server_result) {
					zNodes = JSON.parse(server_result);
					
					var tree = $.fn.zTree.init($("#dropdown-"+menu), setting, zNodes);
					tree.menuType = menu;
					tree.expandAll(true);
					console.log(tree);
					
				} 
			});
		}
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
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var dep_no = treeNode.no.split('d')[1];
		window.location.href="/groupware/humanResources/employee?whereOption=d.department_no="+dep_no;
		$('#result-'+treeId).html(treeNode.name);
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
						<a class="btn btn-default" href="addEmployee">사용자 추가</a>
					</div>
					<div class="panel-body">
						<div class="panel">
						
							<div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">								
							<form action="employee">
							<div class="row">
									<div class="col-sm-5">
										<div class="dropdown">
											<button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown">
												<span id="result-dropdown-menu1">보기</span><span class="caret"></span>
											</button>
											<ul class="dropdown-menu ztree" id="dropdown-menu1" role="menu" aria-labelledby="menu1">
											</ul>
										</div>
									</div>
									<div class="col-sm-4" style="float: right;">
										<label>Search: <input type="hidden" name="searchOption" value="employee_name,employee_no"><input type="search" class="form-control input-sm search" placeholder="이름,사원번호로 검색" autofocus="autofocus" name="keyword">
										</label>
										<button id="search-btn" class="btn btn-primary btn-sm">
											<i class="fa fa-search"></i>
										</button>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-12">
										
											<table class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline">
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
													<!-- <tr id="addUserField">
														<td class="C"></td>
														<td><label class="bmax v2"><input type="text" name="employee_name" class="textbox_insa" placeholder="이름 입력" size="5"></label></td>
														<td><label class="bmax v2"><input id="password" autocomplete="new-password" name="password" class="textbox_insa" placeholder="비밀번호 입력" size="8"></label></td>
														<td><div class="dropdown">
																<button class="btn btn-default dropdown-toggle" type="button" value="selectDep" id="menu2" data-toggle="dropdown">
																	<span id="result-dropdown-menu2">부서 선택</span><span class="caret"></span>
																</button>
																<ul class="dropdown-menu ztree" id="dropdown-menu2" role="menu" aria-labelledby="menu2">
																</ul>
															</div></td>
														<td><label class="bmax v2 Mr0"> <select id="position" name="position" class="select_insa">
																	<option value="-1">직위 선택</option>
																	<option value="회장">회장</option>
																	<option value="사장">사장</option>
																	<option value="부사장">부사장</option>
																	<option value="전무">전무</option>
																	<option value="상무">상무</option>
																	<option value="이사">이사</option>
																	<option value="공장장">공장장</option>
																	<option value="부장">부장</option>
																	<option value="차장">차장</option>
																	<option value="팀장">팀장</option>
																	<option value="과장">과장</option>
																	<option value="대리">대리</option>
																	<option value="사원">사원</option>
															</select>
														</label></td>
														<td><label class="bmax v2"><input type="text" id="hiredate" name="hiredate" class="textbox_insa" placeholder="입사일 입력"></label></td>
														<td><label class="bmax v2"><input type="text" id="email" name="email" class="textbox_insa" placeholder="이메일 입력"></label></td>
														<td><label class="bmax v2"><input type="text" id="cell" name="cell" class="textbox_insa" placeholder="휴대전화 입력"></label></td>
														<td><a class="blue_color" href="javascript:void(0)" onclick="usermanage.addDirectMember();">저장</a></td>
													</tr> -->
												</thead>
												<tbody>
													<c:forEach items="${elist}" var="list">
														<tr>
															<td>${list.employee_no}</td>
															<td>${list.employee_name}</td>
															<td><input type="password" value="${list.password}" disabled="disabled" size="7"></td>
															<td>${list.department.department_name}</td>
															<td>${list.position}</td>
															<td><fmt:formatDate value="${list.hiredate}" pattern="yyyy/MM/dd" /></td>
															<td>${list.email}</td>
															<td>${list.phonenumber}</td>
															<td></td>
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
																	<a href="employee?cur_page=${page.prevPage}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">Previous</a>
																</c:if></li>
															<c:forEach var="num" begin="${page.blockBegin}" end="${page.blockEnd }">
																<li class="paginate_button <c:if test="${num == page.curPage}"> active</c:if>" aria-controls="dataTables-example" tabindex="0"><a href="employee?cur_page=${num}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">${num}</a></li>
															</c:forEach>
															<li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next"><c:if test="${page.curBlock <= page.totBlock}">
																	<a href="employee?cur_page=${page.nextPage}<c:forEach items="${map.searchOption}" var="searchOption">&searchOption=${searchOption}</c:forEach>&keyword=${map.keyword}&page_scale=${page.page_scale}">Next</a>
																</c:if></li>
														</ul>
													</div>
												</div>
											</div>
										</form>
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
