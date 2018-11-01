<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(document).ready(function() {
	   	
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
	    var data = [];
	    for(var x in arr){
	    	data.push({label : arr[x].employee_name, category : arr[x].department.department_name, no : arr[x].employee_no, position : arr[x].position});
	    }
		
	    $( "#search" ).catcomplete({
	        delay: 0,
	        source: data,
	        minLength : 2,
	        select: function( event, ui ) {
                alert(ui.item.no);
                tmpObj = ui.item;
             }

	      });
	    
	    $("#approvalLine").on("shown.bs.modal", function() { $("#search").catcomplete("option", "appendTo", "#approvalLine") })    
	});
</script>
	<div class="modal fade" id="approvalLine" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
	</div>