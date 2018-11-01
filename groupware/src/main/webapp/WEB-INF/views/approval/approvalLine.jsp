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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
.ui-autocomplete-category {
  font-weight: bold;
  padding: .2em .4em;
  margin: .8em 0 .2em;
  line-height: 1.5;
}
</style>

<script type="text/javascript">
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
		$('.confirm').click(function(){
			$(opener.document).find('#approvalLine').html($('.t-body').parent().parent().html());
			window.close();
		});
		
		
		 $( function() {
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
			      source: data
			    });
			    
			    $("#search").keypress(function (e) {
		        if (e.which == 13){
		                  
		        }
			    
			});
		 
	});
</script>
</head>
<body>
	<!-- 아래의 구조로 복사하시오 -->
	<!-- 전체 div-->
	<div id="wrapper">
		<!-- content div -->
		<div id="page-wrapper">

			<div class="row">
				<div class="col-lg-12">
					<h3 class="page-header">결재선 선택</h3>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">내 결재선</div>
						<div class="panel-body">
							<select class="form-control myApprovalLine" style="width: 100%; height: 100px;" id="select_menuline" multiple="multiple">
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
										<td id="approval0" ></td>
										<td id="approval1" class="ap"></td>
										<td id="approval2" class="ap"></td>
										<td id="approval3" class="ap"></td>
										<td id="approval4" class="ap"></td>
										<td id="approval5" class="ap"></td>
									</tr>
								</tbody>
								

							</table>
						</form>
							<button type="button" class="btn btn-primary confirm">확인</button>
							<button type="button" class="btn btn-default" onclick="window.close();">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
