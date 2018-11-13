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
<script src="http://www.treejs.cn/v3/js/jquery.ztree.core.js"></script>

<!-- z-tree CSS -->
<link href="http://www.treejs.cn/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">

<style type="text/css">

#sign td{
height: 80px;
}
</style>
<script>
var setting = {
		view: {
			selectedMulti: false
		},
		data: {
			key: {
				isParent: "isParent",
				name:"department_name"
				
			},
			simpleData: {
				enable: true,
				idKey : "department_no",
				pIdKey : "department_parent_no",
				cnt : "department_people_cnt"
			}
		},
		callback: {
			beforeClick: beforeClick,
			beforeCollapse: beforeCollapse,
			beforeExpand: beforeExpand,
			onCollapse: onCollapse,
			onExpand: onExpand
		}
	};

var zNodes =[];
var object1 = {
		  isParent: true
		};
var log, className = "dark";
function beforeClick(treeId, treeNode) {
	if (treeNode.isParent) {
		return true;
	} else {
		alert("This Demo is used to test the parent node expand / collapse...\n\nGo to click parent node... ");
		return false;
	}
}
function beforeCollapse(treeId, treeNode) {
	className = (className === "dark" ? "":"dark");
	showLog("[ "+getTime()+" beforeCollapse ]&nbsp;&nbsp;&nbsp;&nbsp;" + treeNode.name );
	return (treeNode.collapse !== false);
}
function onCollapse(event, treeId, treeNode) {
	showLog("[ "+getTime()+" onCollapse ]&nbsp;&nbsp;&nbsp;&nbsp;" + treeNode.name);
}		
function beforeExpand(treeId, treeNode) {
	className = (className === "dark" ? "":"dark");
	showLog("[ "+getTime()+" beforeExpand ]&nbsp;&nbsp;&nbsp;&nbsp;" + treeNode.name );
	return (treeNode.expand !== false);
}
function onExpand(event, treeId, treeNode) {
	showLog("[ "+getTime()+" onExpand ]&nbsp;&nbsp;&nbsp;&nbsp;" + treeNode.name);
}
function showLog(str) {
	if (!log) log = $("#log");
	log.append("<li class='"+className+"'>"+str+"</li>");
	if(log.children("li").length > 8) {
		log.get(0).removeChild(log.children("li")[0]);
	}
}
function getTime() {
	var now= new Date(),
	h=now.getHours(),
	m=now.getMinutes(),
	s=now.getSeconds(),
	ms=now.getMilliseconds();
	return (h+":"+m+":"+s+ " " +ms);
}

function expandNode(e) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
	type = e.data.type,
	nodes = zTree.getSelectedNodes();
	if (type.indexOf("All")<0 && nodes.length == 0) {
		alert("Please select one parent node at first...");
	}

	if (type == "expandAll") {
		zTree.expandAll(true);
	} else if (type == "collapseAll") {
		zTree.expandAll(false);
	} else {
		var callbackFlag = $("#callbackTrigger").attr("checked");
		for (var i=0, l=nodes.length; i<l; i++) {
			zTree.setting.view.fontCss = {};
			if (type == "expand") {
				zTree.expandNode(nodes[i], true, null, null, callbackFlag);
			} else if (type == "collapse") {
				zTree.expandNode(nodes[i], false, null, null, callbackFlag);
			} else if (type == "toggle") {
				zTree.expandNode(nodes[i], null, null, null, callbackFlag);
			} else if (type == "expandSon") {
				zTree.expandNode(nodes[i], true, true, null, callbackFlag);
			} else if (type == "collapseSon") {
				zTree.expandNode(nodes[i], false, true, null, callbackFlag);
			}
		}
	}
}
$(document).ready(function() {
	$('#test-btn').click(function(){
		$.ajax({
			method : "get",
			contentType : 'application/json;charset=UTF-8',
			url : "/groupware/humanResources/departmentList",
			async: false,
			error : function() {
				alert("전송 실패");
			},
			success : function(server_result) {
				zNodes = JSON.parse(server_result);
				console.log(zNodes);
				for(var i = 0; i<=zNodes.length; i++){
					$.extend(zNodes[i],object1);
				}
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
				$("#expandBtn").bind("click", {type:"expand"}, expandNode);
				$("#collapseBtn").bind("click", {type:"collapse"}, expandNode);
				$("#toggleBtn").bind("click", {type:"toggle"}, expandNode);
				$("#expandSonBtn").bind("click", {type:"expandSon"}, expandNode);
				$("#collapseSonBtn").bind("click", {type:"collapseSon"}, expandNode);
				$("#expandAllBtn").bind("click", {type:"expandAll"}, expandNode);
				$("#collapseAllBtn").bind("click", {type:"collapseAll"}, expandNode);
			} 
		});
		$('#testTreeModal').modal('show');
	});
});//ready end
</script>
</head>
<body>

	<!-- 아래의 구조로 복사하시오 -->
	<!-- 전체 div-->
	<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper"  >

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">결재</h1>
				</div>
			</div>

			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-heading">문서 작성</div>
					<div class="panel-body">
						<form class="col-sm-12" method="post">
							<div class="panel-heading">
								<button type="button" id="test-btn" class="btn btn-info">test</button>
								
								<button type="button" onclick="location.href='modifyNewDoc?document_no=${dvo.document_no}'" class="btn btn-info">수정하기</button>
								<input type="button" class="btn btn-info" onclick="location.href='/groupware/newDocList'" value="돌아가기">
							</div>
							<div class="panel-body">
								<table
									class="table table-bordered dataTable no-footer dtr-inline"
									id="dataTables-example" role="grid"
									aria-describedby="dataTables-example_info">
									<colgroup>
										<col width="150">
										<col width="auto">
									</colgroup>
									<tbody>
										<tr>
											<td class="odd">작성자</td>
											<td>${dvo.employee.employee_name}</td>
										</tr>
										<tr>
											<td class="odd">문서 제목<br>
											</td>
											<td>${dvo.document_title}</td>
										</tr>
										<tr>
											<td colspan="2" class="odd">문서 내용</td>
										</tr>
										<tr>
											<td colspan="2">
												<div class="col-lg-12">
													${dvo.document_contents}
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</form>
					</div>
				</div>
			</div>

		</div>
	</div>
	<!-- tree-test modal -->
	<div class="modal fade" id="testTreeModal"
		aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="modalLabel">
						주의!
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</h3>
				</div>
				<div class="modal-body">
					<div class="content_wrap">
						<div class="zTreeDemoBackground left">
							<ul id="treeDemo" class="ztree">
							</ul>
						</div>
						
						<ul id="log" class="log">
						</ul>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	
</body>
</html>
