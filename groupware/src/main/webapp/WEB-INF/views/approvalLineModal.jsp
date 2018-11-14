<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- jquery-ui.js -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- jquery-serializeObject.js  -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-serializeObject.js"></script>
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
#droppable { width: 60px; height: 60px; float: left; }
</style>
<script type="text/javascript">
	$(document).ready(function() {
		//결재선 위치 바꾸고 index 다시 설정해주는 부분
	    $("#sortable").sortable({
	        items: "td:not(.ui-state-disabled)",
	        revert: "invalid",
	        deactivate: function( event, ui ) {
		    	for(var i = 1; i<6; i++){
					$('.modal_name[index=0]').parent().find('td:eq('+i+')').attr("index",i);
				}	
		    }
	    });
	    $( "#sortable td" ).disableSelection();
	    
	    //결재선 내의 사원명을 휴지통으로 드랍하면 사라지게 하는 부분
	    $("#droppable").droppable({
			drop: function( event, ui ) {
				for(var i = ui.draggable.attr("index"); i<index; i++){
					$('.modal_name[index='+i+']').html($('.modal_name[index='+(parseInt(i)+1)+']').html());
				}
				index--;
				sortDisabled(index);
			}
	    });
	    
	    //현재 index(결재선에 들어가있는 사람의 수) 다음 번호들(빈칸) sorting 금지
	    function sortDisabled(x){
	    	$('.modal_name').removeClass("ui-state-disabled");
	    	$('.modal_name[index=0]').addClass("ui-state-disabled");
	    	for(var i = x; i<6;i++){
	    		$('.modal_name[index='+i+']').addClass("ui-state-disabled");
	    	}
	    }
	    
		//현재 결재선이 몇번 까지 등록되어있는지 확인하는 변수
		var index=0;
		
		var arr = ${elist};
		
		//로그인한 사원의 번호를 세션에서 받아오기
		//모달테이블 index 0번에 자신의 아이디 입력 및 index 변수에 1 입력
		$('.modal_name[index=0]').html("<label><input type='hidden' name='approval[][employee][employee_no]' value=${sessionScope.loginInfo.employee_no}>${sessionScope.loginInfo.department.department_name}<br>(${sessionScope.loginInfo.employee_name} ${sessionScope.loginInfo.position})</label>");
		index=1;
		
		
		//결재선 불러오기 버튼을 클릭하면 ajax를 통해 내 결재선을 가져와 modal에서 목록을 보여준다
		function loadMyApprovalLine(){
			$.ajax({
				method : "GET",
				url : "/groupware/myApprovalLine",
				data : {
					"employee_no" : '${sessionScope.loginInfo.employee_no}'
				},
				error : function() {
					alert("내 결재선 불러오기 실패");
				},
				success : function(data) {
					$('.myApprovalLine').html('<option selected="selected" value="default">자주 사용하는 결재선</option>');
					for(var x in data){
						$('.myApprovalLine').append("<option value="+data[x].approval_path_no+">"+data[x].approval_path_name+"</option>");
					}
				}
			});
		}
		
		//modal내의 내 결재선 목록을 선택하면 해당 결재선에 포함된 정보들을 가져온다
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
						//modal내 테이블 초기화 및 해당하는 인덱스에 데이터 입력한다
						$('.modal_name').html("");
						index=0;
						for (var x in data){
							$('.modal_name[index='+x+']').html("<label><input type='hidden' name='approval[][employee][employee_no]' value="+data[x].employee.employee_no +">"+data[x].employee.department.department_name+"<br>("+data[x].employee.employee_name+" "+data[x].employee.position+")</label>");
							index++;
						}
						sortDisabled(index);
					}
				});
			}
		});
		
		//사원의 이름을 검색할 때 자동완성으로 도와준다
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
		
		//자동완성에 사용 되는 사원 정보 데이터 입력
	    var data = [];
	    for(var x in arr){
	    	data.push({label : arr[x].employee_name, category : arr[x].department.department_name, no : arr[x].employee_no, position : arr[x].position});
	    }
		
	    $( "#search" ).catcomplete({
	        delay: 0,
	        source: data,
	        //검색창에 값을 선택하면 테이블에 추가한다
	        select: function( event, ui ) {
	        	if(index>5){
	        		alert("결재선이 꽉 찼습니다. 최대 6명");
	        	}else{
		        	$('.modal_name[index='+index+']').html("<label><input type='hidden' name='approval[][employee][employee_no]' value="+ui.item.no +">"+ui.item.category+"<br>("+ui.item.label+" "+ui.item.position+")</label>");
					index++;
					sortDisabled(index);
	        	}
		    }
	    });
	   
	    $('#favorites').click(function(){
	    	$('#addFavorites').modal("show");
	    });
	    
	    $("#approvalLineSelect").on("shown.bs.modal", function() { 
	    	$("#search").catcomplete("option", "appendTo", "#approvalLineSelect");
			loadMyApprovalLine();
	    })
	    
	    //modal의 확인 버튼 클릭 시 모달내의 테이블을  현재 페이지의 결재선에 넣어준다
		$('#confirm').click(function(){
			$('#approvalLine').find('#paste').html($('#sortable').html());
		});
	    
		//즐겨찾기 추가
		$('#addConfirm').click(function(){
			var form = document.createElement("form");
		 	form.setAttribute("id","addFavoritesForm");
		 	form.setAttribute("hidden","hidden");
	        var hiddenField = document.createElement("input");
	        hiddenField.setAttribute("type", "hidden");
	        hiddenField.setAttribute("name", "approval_path_name");
	        hiddenField.setAttribute("value", $('#approval_path_name').val());
		 	 document.body.appendChild(form);
		    $('#addFavoritesForm').html($('#sortable').html());
		    //히든으로 값을 주입시킨다.
		 
		   	form.appendChild(hiddenField);
		 
			tmpArr = $("form#addFavoritesForm").serializeObject();
			
			console.log(tmpArr);
			$.ajax({
				method : "post",
				url : "/groupware/addFavorite",
				contentType: "application/json;charset=UTF-8",
				data :  JSON.stringify(tmpArr),
				error : function(error) {
					alert("전송 실패");
				},
				success : function(data) {
					
					window.location.href = data;
				}
			}); 
			
			
			 $('#addFavoritesForm').html("");
		});
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
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<div class="panel-heading">결재 요청할 사원의 이름을 검색하세요.</div>
								<input type="text" id="search" class="form-control" autofocus="autofocus" value="${fvo.form_name}" width="100%">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default" id="approvalLineLoad">
								<table class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline sendTable" role="grid" aria-describedby="dataTables-example_info" style="width: 100%;">
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
												<i class="fas fa-arrow-right"></i>
											</th>
										</tr>
										<tr id="sortable">
											<td class="modal_name ui-state-disabled" index=0></td>
											<td class="modal_name" index=1></td>
											<td class="modal_name" index=2></td>
											<td class="modal_name" index=3></td>
											<td class="modal_name" index=4></td>
											<td class="modal_name" index=5></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<i class="far fa-trash-alt fa-3x ui-sortable-handle" id="droppable" style="float: left;"></i>
					<button type="button" class="btn btn-default" id="favorites">즐겨찾기 추가</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="confirm">확인</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="addFavorites" tabindex="-1" z-index="1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="modalLabel" >즐겨찾기 추가
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
								<div class="panel-heading">현재 선택한 결재선을 즐겨찾기에 추가 하시려면 제목을 적고 확인을 누르세요.</div>
								<div class="panel-body">
									<input type="text" style="width: 100%;" id="approval_path_name">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="addConfirm">확인</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>