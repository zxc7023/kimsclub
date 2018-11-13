<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%-- 
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
 --%>
<!-- z-tree js -->
<script src="http://www.treejs.cn/v3/js/jquery.ztree.core.js"></script>
<script src="http://www.treejs.cn/v3/js/jquery.ztree.excheck.js"></script>

<!-- z-tree CSS -->
<link href="http://www.treejs.cn/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">

<style type="text/css">

#sign td{
height: 80px;
}
</style>
<script>
//Tree.beforeClick = true;
//요청 타입
var load_type = ${param.load_type};

//zTree 세팅 부분
var setting = {
		view: {
			selectedMulti: false
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
				cnt : "cnt"
				
			}
		},
		callback: {
			beforeClick : beforeClick,
			beforeCheck: beforeCheck,
			onCheck: onCheck
		}
	};
var zNodes =[];
var department = {
		  isParent: true
		};
		
var log,code, className = "dark";

function beforeCheck(treeId, treeNode) {
	className = (className === "dark" ? "":"dark");
	showLog("[ beforeCheck ]&nbsp;&nbsp;&nbsp;&nbsp;" + treeNode.name );
	return (treeNode.doCheck !== false);
}
function onCheck(e, treeId, treeNode) {
	showLog("[ onCheck ]&nbsp;&nbsp;&nbsp;&nbsp;" + treeNode.name );
}		
function showLog(str) {
	if (!log) log = $("#log");
	log.append("<li class='"+className+"'>"+str+"</li>");
	if(log.children("li").length > 6) {
		log.get(0).removeChild(log.children("li")[0]);
	}
}
//클릭 했을시 호출되는 함수 사용하는 페이지에서 복사
/*function beforeClick(treeId, treeNode) {
	if (treeNode.isParent) {
		alert("부서 클릭 : "+treeNode.department_name+":"+treeNode.department_no);
		//return true;
	} else {
		alert("사원 클릭");
		//return false;
	}
}*/


$(document).ready(function() {
	/* 	테스트- 테스트버튼 클릭시 ajax로 departmentList 가져와 zNodes에 넣어준다 
		$.fn.zTree.init($("#treeDemo"), setting, zNodes)-로 zNodes의 내용을 세팅,시작 
		모달창으로 보여줌
		*/
	$('#tree-btn').click(function(){
		if(load_type==0 ){
			$.ajax({
				method : "get",
				contentType : 'application/json;charset=UTF-8',
				url : "/groupware/humanResources/departmentList?load_type="+load_type,
				error : function() {
					alert("전송 실패");
				},
				success : function(server_result) {
					zNodes = JSON.parse(server_result);
					console.log(zNodes);
					/* for(var i = 0; i<=zNodes.length; i++){
						$.extend(zNodes[i],department);
					} */
					
					$.fn.zTree.init($("#treeDemo"), setting, zNodes);
					console.log($.fn.zTree);
				} 
			});
		}else if(load_type == 1){
			$.ajax({
				method : "get",
				contentType : 'application/json;charset=UTF-8',
				url : "/groupware/humanResources/departmentList?load_type="+load_type,
				error : function() {
					alert("전송 실패");
				},
				success : function(server_result) {
					zNodes = JSON.parse(server_result);
					console.log(zNodes);
					
					var tree = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
					tree.setting.check.enable=true;
					console.log(tree);
				} 
			});
		}
		$('#testTreeModal').modal('show');
	});
});//ready end
</script>
</head>
<body>
	<!-- tree-test modal -->
	<div class="modal fade" id="testTreeModal"
		aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="modalLabel">
						부서 및 사원 선택
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
