<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- <script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script> --%>

<style>
.ui-autocomplete-category {
  font-weight: bold;
  padding: .2em .4em;
  margin: .8em 0 .2em;
  line-height: 1.5;
}
.name{
 height: 50px;
}
.stamp{
 height: 84px;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		var arr = ${elist};
		$('#approval0').html("<label><input type='hidden' name='approval_employee_no' value="+arr[0].employee_no +">"+arr[0].department.department_name+"<br>("+arr[0].employee_name+" "+arr[0].position+")</label>");
		
		$('#confirm').click(function(){
			alert($('.sendTable').parent().html());
			$('#approvalLine').html($('.sendTable').parent().html());
		});
		function loadMyApprovalLine(){
			$.ajax({
				method : "GET",
				url : "/groupware/myApprovalLine",
				data : {
					"employee_no" : 4 //나중에 세션에서 받아온 사원번호로 변경 
				},
				error : function() {
					alert("내 결재선 불러오기 실패");
				},
				success : function(data) {
				}
			});
		}

		
		$('.myApprovalLine').change(function() {
			if($(this).val()!='default'){
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
						$('#approvalLineLoad').find('td').removeClass("next");
						for (var i = 1; i < data.length; i++) {
							$('#approval'+i).removeClass("next");
							$('#approval'+i).html("<label><input type='hidden' name='approval_employee_no' value="+data[i].employee.employee_no +">"+data[i].employee.department.department_name+"<br>("+data[i].employee.employee_name+" "+data[i].employee.position+")</label>");
							$('#approval'+(i+1)).addClass("next");
						}
					}
				});
			}
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
	        minLength : 2,
	        select: function( event, ui ) {
				$('.next').html("<label><input type='hidden' name='approval_employee_no' value="+ui.item.no +">"+ui.item.category+"<br>("+ui.item.label+" "+ui.item.position+")</label>");
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
	    
	    $("#approvalLineSelect").on("shown.bs.modal", function() { $("#search").catcomplete("option", "appendTo", "#approvalLineSelect");
		loadMyApprovalLine();
	    })    
	});
</script>	

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
										<option selected="selected" value="default">자주 사용하는 결재선</option> 
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
							<div class="panel panel-default" id="approvalLineLoad">
								<table width="100%"  heigt="250px" class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline sendTable" role="grid" aria-describedby="dataTables-example_info" style="width: 100%;">
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
											<td id="approval0" class="name"></td>
											<td id="approval1" class="name ap next"></td>
											<td id="approval2" class="name ap"></td>
											<td id="approval3" class="name ap"></td>
											<td id="approval4" class="name ap"></td>
											<td id="approval5" class="name ap"></td>
										</tr>
										<tr>
											<td class="stamp"></td>
											<td class="stamp"></td>
											<td class="stamp"></td>
											<td class="stamp"></td>
											<td class="stamp"></td>
											<td class="stamp"></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="confirm();" data-dismiss="modal" id="confirm">확인</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>