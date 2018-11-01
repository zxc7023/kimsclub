<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		var arr = ${elist};
		$('#approval0').html("<label name='employee_no' no='"+arr[0].employee_no +"'>"+arr[0].department.department_name+"<br>("+arr[0].employee_name+" "+arr[0].position+")</label>");
		
	    var data = [];
	    for(var x in arr){
	    	data.push({label : arr[x].employee_name, category : arr[x].department.department_name, no : arr[x].employee_no, position : arr[x].position});
	    }
		
	    $( "#search" ).catcomplete({
	        delay: 0,
	        source: data,
	        minLength : 2,
	        select: function( event, ui ) {
				$('.next').html("<label name='employee_no' no='"+ui.item.no +"'>"+ui.item.category+"<br>("+ui.item.label+" "+ui.item.position+")</label>");
				$('.next').addClass("temp");
				$('.next').removeClass("next");
				console.log($(this));
				$('.temp').next().addClass("next");
				$('.temp').removeClass("temp");
		    }
	        /* select: function( event, ui ) {
                alert(ui.item.no);
                tmpObj = ui.item;
                
             } */

	      });
	    
	    $("#approvalLineSelect").on("shown.bs.modal", function() { $("#search").catcomplete("option", "appendTo", "#approvalLineSelect") })    
	});
</script>
	<!-- <div class="modal fade" id="approvalLine" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">결재선 선택</h4>
				</div>
				<div class="modal-body">
					<div class="container-fluid">
						<div class="row">
							<div class="col-lg-3">
								<label for="search" class="control-label">이름</label>
							</div>
							<div class="col-lg-9">
								<input type="text" class="form-control" name="employee_name" id="search">
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="finish">완료</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div> -->
	
	
	<div class="modal fade" id="approvalLineSelect" tabindex="-1" role="dialog" aria-hidden="true">
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