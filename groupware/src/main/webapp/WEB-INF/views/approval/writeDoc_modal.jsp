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

<!-- ckeditor -->
<script src="resources/ckeditor/ckeditor.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
.odd {
background-color: #f5f5f5;
}
</style>
<script>
$(document).ready(function() {
	
	var arr = ${elist};
	$('#approval0').html("<label name='employee_no' no='"+arr[0].employee_no +"'>"+arr[0].department.department_name+"<br>("+arr[0].employee_name+" "+arr[0].position+")</label>");
	$('.myApprovalLine').change(function() {
		$.ajax({
			method : "GET",
			url : "/groupware/selectMyApprovalLine",
			data : {
				"approval_path_no" : $('.myApprovalLine option:selected').val()
			},
			error : function() {
				alert("양식 불러오기 실패");
			},
			success : function(data) {
				$('.ap').html("");
				$('.t-body>tr>td').removeClass("next");
				for (var i = 1; i < data.length; i++) {
					$('#approval'+i).removeClass("next");
					$('#approval'+i).html("<label name='employee_no' no='"+data[i].employee.employee_no +"'>"+data[i].employee.department.department_name+"<br>("+data[i].employee.employee_name+" "+data[i].employee.position+")</label>");
					$('#approval'+(i+1)).addClass("next");
				}
			}
		});
	});
	
		    $.widget( "custom.catcomplete", $.ui.autocomplete, {
		      _create: function() {
		        this._super();
		        this.widget().menu( "option", "items", "> :not(.ui-autocomplete-category)" );
		      },
		      _renderMenu: function( ul, items ) {
		        var that = this,
		          currentCategory = "";
		        $.each( items, function( index, item ) {
		          var li;
		          if ( item.category != currentCategory ) {
		            ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
		            currentCategory = item.category;
		          }
		          li = that._renderItemData( ul, item );
		          if ( item.category ) {
		            li.attr( "aria-label", item.category + " : " + item.label );
		          }
		        });
		      }
		    });
		    var data = [];
		    for(var x in arr){
		    	data.push({label : arr[x].employee_name, category : arr[x].department.department_name, no : arr[x].employee_no, position : arr[x].position});
		    }

		    $( "#search" ).catcomplete({
			    delay: 0,
			    source: data,
			    select: function( event, ui ) {
					$('.next').html("<label name='employee_no' no='"+ui.item.no +"'>"+ui.item.category+"<br>("+ui.item.label+" "+ui.item.position+")</label>");
					$('.next').addClass("temp");
					$('.next').removeClass("next");
					console.log($(this));
					$('.temp').next().addClass("next");
					$('.temp').removeClass("temp");
			    }
		    });
	

	$("#loadApprovalLineModal").on("shown.bs.modal", function() { $("#search").catcomplete("option", "appendTo", "#loadApprovalLineModal") });
	
	$(function(){
	    CKEDITOR.replace( 'ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
			width:'100%',
	    	height:'400px',
	    	filebrowserUploadUrl: '${pageContext.request.contextPath}/upload/ckeditor_upload.asp'
	    });        
	});
	
	$('.selectForm').change(function() {
		if($(this).val()!='default'){
			if(CKEDITOR.instances.ckeditor.getData()!=''){
				$('#deleteCheckModal').modal('show'); //This can also be $("#deleteCheckModal").modal({ show: true });
			}else{
				loadForm();
			}
		}
	});
});//ready end

function loadForm(){
	$.ajax({
		method : "GET",
		url : "/groupware/loadForm",
		data : {
			"form_no" : $('.selectFormNo:selected').val()
		},
		error : function() {
			alert("양식 불러오기 실패");
		},
		success : function(data) {
			CKEDITOR.instances.ckeditor.setData(data);
		}
	});
}

//결재선 불러오기
function loadApprovalLine(){
	$.ajax({
		method : "GET",
		url : "/groupware/approvalLine",
		error : function() {
			alert("조직도 불러오기 실패");
		},
		success : function(data) {
			CKEDITOR.instances.ckeditor.setData(data);
		}
	});
}
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
					<div class="panel-heading">문서 작성</div>
					<div class="panel-body">
						<div class="panel panel-default">
							<div class="panel-heading">
								<button onclick="location='approvalDoc'" class="btn btn-info">기안하기</button>
								<button onclick="location='approvalNewDoc'" class="btn btn-info">임시저장</button>
							</div>
							<div class="panel-body">
								<form class="col-sm-12">
									<table class="table table-bordered dataTable no-footer dtr-inline" id="dataTables-example" role="grid" aria-describedby="dataTables-example_info">
										<colgroup>
											<col width="150">
											<col width="auto">
										</colgroup>
										<tbody>
											<tr role="row">
												<td class="odd">문서 양식</td>
												<td>
													<select class="selectForm">
														<option selected="selected" value="default">양식 선택</option>
														<c:forEach items="${flist}" var="fvo">
															<option class="selectFormNo" value="${fvo.form_no}">${fvo.form_name}</option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr role="row">
												<td class="odd">작성자</td>
												<td>사원이름</td>
											</tr>
											<tr role="row">
												<td class="odd">결재</td>
												<td id="approvalLine">
													<button class="btn-ApprovalLine" type="button" data-toggle="modal" data-target="#loadApprovalLineModal">결재선 선택</button>
												</td>
												
											</tr>
											<tr role="row">
												<td colspan="2" class="odd">문서 내용</td>
											</tr>
											<tr role="row">
												<td  colspan="2">
													<div class="col-lg-12">
														<textarea name="form_contents" id="ckeditor" class="form"></textarea>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 양식 수정 체크 modal -->
	<div class="modal fade" id="deleteCheckModal"
		aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="modalLabel" >주의!
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</h3>
				</div>
				<div class="modal-body">
					저장하지 않은 문서 양식이 삭제 될 수 있습니다. 정말로 진행하시겠습니까?
					<!--해당 글 삭제하는 주소값받는 input 태그-->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="loadForm();" data-dismiss="modal">확인</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 결재선 불러오기 modal -->
	<div class="modal fade" id="loadApprovalLineModal"
		aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="modalLabel" >결재선 불러오기
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</h3>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<div class="panel-heading">내 결재선</div>
								<div class="panel-body">
									<select class="form-control myApprovalLine" style="width: 100%;" id="select_menuline">
										<c:forEach items="${alist}" var="alist">
											<option value="${alist.approval_path_no}">${alist.approval_path_name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<h5>결재 요청할 사원의 이름을 검색하세요.</h5>
								<input type="text" id="search" class="form-control" autofocus="autofocus" value="${fvo.form_name}" width="100%">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<form>
									<table width="100%" class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline" id="dataTables-example" role="grid" aria-describedby="dataTables-example_info" style="width: 100%;">
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
											<tr>
												<td id="approval0"></td>
												<td id="approval1" class="ap next"></td>
												<td id="approval2" class="ap"></td>
												<td id="approval3" class="ap"></td>
												<td id="approval4" class="ap"></td>
												<td id="approval5" class="ap"></td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="loadForm();" data-dismiss="modal">확인</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
