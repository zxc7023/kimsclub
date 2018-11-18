<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- header 및 navigation을 불러오기 위해서 사용해야하는 자원들 아래 다 복사해서 붙여넣기 하세요. -->
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


<!-- DataTables CSS -->
<!-- <link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet"> -->

<!-- DataTables Responsive CSS -->
<!-- <link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet"> -->

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/jquery.orgchart.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery.orgchart.js"></script>

<!-- z-tree js -->
<script src="http://www.treejs.cn/v3/js/jquery.ztree.core.js"></script>
<script src="http://www.treejs.cn/v3/js/jquery.ztree.excheck.js"></script>

<!-- z-tree CSS -->
<link href="http://www.treejs.cn/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">


<script>
var org_chart;

function onDepClick(treeId, treeNode) {
	   if (treeNode.parent) {
		  var preDep_no = $("input[type=hidden]").val();
		   //parent 구분하기위해 부서 명 앞에 d적은 거 자르기
	      var nextDepartment_no = treeNode.no.split('d')[1];
	      $('#testTreeModal').modal('hide');
	      org_chart.beforeMoveCheck(preDep_no,nextDepartment_no);
	   }

	}

	$(document).ready(function() {
		var department_json = ${requestScope.department_json};
		console.log(department_json);
		org_chart = $('#orgChart').orgChart({
			data : department_json, //데이터
			showControls : true, //보여줄지말지
			allowEdit : true, //제목이 수정가능할지 아닐지
			onAddNode : function(parent_node) {
				$.ajax({
					method : "post",
					dataType : "json",
					contentType : 'application/json;charset=UTF-8',
					url :  "${pageContext.request.contextPath}/humanResources/getDepartmentSeq",
					error : function() {
						alert('전송 실패');
					},
					success : function(server_result) {
						console.log("성공");
					}
				}).done(function(server_result){
					var server_json = server_result;
					department_no_seq = server_json.department_no;
					org_chart.newNode(department_no_seq,parent_node.data.department_no);
				});
				console.log(org_chart.getData());
			},
			onDeleteNode : function(node) {
				org_chart.deleteNode(node.data.department_no);
			},
			onDeleteNodeDB : function(node){
				console.log(node);
				$.ajax({
					method : "post",
					dataType : "json",
					data : JSON.stringify(node),
					contentType : 'application/json;charset=UTF-8',
					url :  "${pageContext.request.contextPath}/humanResources/removeDepartments",
					error : function() {
						alert('전송 실패');
					},
					success : function(server_result) {
						var server_json = server_result;
						result = server_json.result;
						console.log(result);
					}
				});
			},
			onClickNode : function(node) {
				// log('Clicked node '+node.data.department_no);
			},
			onChangedNodeDB : function(node){
				console.log(node);
				$.ajax({
					method : "post",
					dataType : "json",
					data : JSON.stringify(node),
					contentType : 'application/json;charset=UTF-8',
					url :  "${pageContext.request.contextPath}/humanResources/modifyDepartmentName",
					error : function() {
						alert('전송 실패');
					},
					success : function(server_result) {
						var server_json = server_result;
						result = server_json.result;
						console.log(result);
					}
				});
			},
			onAddNodeDB : function(node){
				console.log(node);
				$.ajax({
					method : "post",
					dataType : "json",
					data : JSON.stringify(node),
					contentType : 'application/json;charset=UTF-8',
					url :  "${pageContext.request.contextPath}/humanResources/addDepartment",
					error : function() {
						alert('전송 실패');
					},
					success : function(server_result) {
						var server_json = server_result;
						result = server_json.result;
						console.log(result);
					}
				})
			},
			onMoveNode : function(node){
				console.log(node);
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
    									cnt : "cnt",
    									
    								}
    							},
    							callback: {
    								beforeClick : onDepClick,
    							},
    							edit: {
    							      enable: true,
    							      drag: {
    							         autoOpenTime: 0
    							      }
    							}
    						};
    					
    					var tree = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
    					tree.expandAll(true);
    					$('#testTreeModal').modal('show');
    					$("input[type=hidden]").val(node.data.department_no);
    				} 
    			});
    			
   
			},
			
			checkNodes : function(prev,next){
				var department = {};
				department.prev = prev;
				department.next = next;
				if(prev == next){
					alert("현재 위치를 선택하였습니다. 확인 후 다시 선택하세요.");
					return false;
				}
				$.ajax({
					method : "post",
					dataType : "json",
					data : JSON.stringify(department),
					contentType : 'application/json;charset=UTF-8',
					url :  "${pageContext.request.contextPath}/humanResources/checkChildren",
					error : function() {
						alert('전송 실패');
					},
					success : function(server_result) {
						var server_json = server_result;
						if(server_json == 1){
							alert("이동시킬 조직의 하위조직으로는 이동할 수 없습니다.");
							return false;
						}else{
							org_chart.moveNode(prev,next);
						}
					}
				})
			},
			onMoveNodeDB : function(node){
				
			}
		});
		$("#orgSave").click(function() {
			console.log(org_chart.getData());
		});
	});
</script>
<title>예제</title>
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
					<div id="orgChart">

					</div>
				</div>
			</div>
		</div>
	</div>


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
					<button type="button" id="checkDepAndEmp" class="btn btn-primary" data-dismiss="modal">확인</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden">
</body>
</html>