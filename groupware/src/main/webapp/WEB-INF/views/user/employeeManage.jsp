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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css"
	integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>

<script src="http://www.treejs.cn/v3//js/jquery.ztree.core.js"></script>
<script src="http://www.treejs.cn/v3/js/jquery.ztree.excheck.js"></script>
<!-- z-tree CSS -->
<link href="http://www.treejs.cn/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">


<style type="text/css">
.setting_field input[type=text].textbox_insa, input[type=text].textbox_insa
	{
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
	var tree;
	var setting = {
		view : {
			selectedMulti : false,
			showIcon : false
		},
		//체크박스 사용 여부 부분
		check : {
			enable : false,
			chkStyle : "checkbox"
		},
		data : {
			key : {
				isParent : "parent",
				name : "department_name"
			},
			simpleData : {
				enable : true,
				idKey : "department_no",
				pIdKey : "department_parent_no"
			}
		},
		callback : {
			beforeClick : beforeClick,
			onClick : departmentClick
		},
		edit : {
			enable : true,
			drag : {
				autoOpenTime : 0
			}
		}
	};

	//DepartmentList를 통해 부서목록을 받아오고 callback함수로 Ztree를 준비한다.
	getDepartmentList(prepareZtree);

	function getEmployeeWithCreteria() {
		console.log($("form[name=searchCriteria]").serialize());
		$.ajax({
			method : "get",
			contentType : 'application/json;charset=UTF-8',
			url : "/groupware/humanResources/getEmpWithCreteria",
			error : function() {
				alert("전송 실패");
			},
			success : function(result) {
				if (callback) {
					callback(result);
				}
			}
		});
	}
	
	function prepareData(result){
		employeeList();
		pagination();
	}
	
	function employeeList(){
		
	}
	function paginaton(){
		
	}

	//부서 클릭했을때 이벤트
	function beforeClick(treeId, treeNode) {
	}

	// 부서를 클릭하고나서 해야할 작업들
	function departmentClick() {
		var zTree = $.fn.zTree.getZTreeObj("org_list");
		var nodes = zTree.getSelectedNodes();
		$("#result_menu").text(nodes[0].department_name);
		$("input[name=department_no]").val(nodes[0].department_name);
		hideMenu();
		getEmployeeWithCreteria();
	}

	//ajax로 Department번호를 가져온다.
	function getDepartmentList(callback) {
		$.ajax({
			method : "get",
			contentType : 'application/json;charset=UTF-8',
			url : "/groupware/humanResources/departmentList2",
			error : function() {
				alert("전송 실패");
			},
			success : function(result) {
				if (callback) {
					callback(result);
				}
			}
		});
	}

	//Ajax를 통해 받은결과를 가지고 tree를 만든다
	function prepareZtree(result) {
		var zNodes = [];
		var rootObj = {
			department_parent_no : 0,
			department_name : "모든 사용자"
		};
		var noDepartmentObj = {
			department_parent_no : 0,
			department_name : "소속 없음"
		};
		zNodes.push(rootObj);
		zNodes.push(noDepartmentObj);
		var items = zNodes.concat(JSON.parse(result));
		console.log(items);
		tree = $.fn.zTree.init($("#org_list"), setting, items);
		tree.expandAll(true);
	}

	function showMenu() {
		var menuObj = $("#menu1");
		var menuOffset = $("#menu1").offset();
		$("#menuContent").css({
			left : menuOffset.left + "px",
			top : menuOffset.top + menuObj.outerHeight() + "px"
		}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	}

	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}

	function onBodyDown(event) {
		if (!(event.target.id == "menu1" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
			hideMenu();
		}
	}

	$(document).ready(function() {
		//초기값으로 검색한다.
		getEmployeeWithCreteria();
		
		//보기 클릭시 어느 부서를 볼 지 정할 수 있다.
		$('#menu1').click(function() {
			//모달을 보여준다.
			showMenu();
		});
	});
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

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<a class="btn btn-default" href="addEmployee">사용자 추가</a>
						</div>
						<div class="panel-body">
							<div class="row">
								<form name="searchCriteria" class="form-inline">
									<div class="col-sm-5 text-left">
										부서 : <a id="menu1"> <input name="department_no" type="hidden" value="모든 사용자"> <span id="result_menu">모든 사용자</span><span class="caret"></span>
										</a>
									</div>
									<div class="col-sm-7 text-right">
										<select name="searchType">
											<option value="employee_name" selected="selected">이름</option>
											<option value="employee_no">사원번호</option>
										</select>
										<input type="search" class="form-control input-sm search" placeholder="검색어를 입력하세요." autofocus="autofocus" name="keyword">
										<button type="button" id="search-btn" class="btn btn-primary btn-sm">
											<i class="fa fa-search"></i>
										</button>
									</div>
								</form>
							</div>
							<div class="row">
								<div class="col-lg-12">
									<table class="table table-striped table-bordered table-hover no-footer dtr-inline" id="employee_table">
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
										</thead>
										<tbody>
										</tbody>
									</table>
									<div class="row">
										<div class="col-sm-12 text-center"></div>
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
	<div id="menuContent" class="menuContent" style="display: none; position: absolute;">
		<ul id="org_list" class="ztree"
			style="margin-top: 0; width: 160px; border: 1px solid #617775; background: #f0f6e4; overflow-y: scroll; overflow-x: auto;">
		</ul>
	</div>
</body>
</html>
