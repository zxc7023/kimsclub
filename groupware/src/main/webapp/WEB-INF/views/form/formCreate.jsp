<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>양식 관리 페이지</title>
<script src="resources/ckeditor/ckeditor.js"></script>
<script src="resources/js/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function() {
	 $(function(){
      	    CKEDITOR.replace( 'ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
	            width:'100%',
	            height:'400px',
	        	filebrowserUploadUrl: '${pageContext.request.contextPath}/upload/ckeditor_upload.asp'
	        });
	         
	         
	        CKEDITOR.on('dialogDefinition', function( ev ){
	            var dialogName = ev.data.name;
	            var dialogDefinition = ev.data.definition;
	          
	            switch (dialogName) {
	                case 'image': //Image Properties dialog
	                    //dialogDefinition.removeContents('info');
	                    dialogDefinition.removeContents('Link');
	                    dialogDefinition.removeContents('advanced');
	                    break;
	            }
	        });
	         
	    });
});//ready end
</script>
</head>
<body>
<div id="content">
	<div id="content_title">양식 생성</div><!-- content_title end -->
	<div id="wrap">
		<div id="approval_menu">
			<ul>
				<li><a href="/groupware/createform">확인</a></li>
			</ul>
		</div><!-- form_menu end -->
		<div id="setting">
		<table class="setting_table">
			<caption>기본 설정 입력 양식</caption>
			<colgroup>
				<col style="width:20%">
				<col style="width:30%">
				<col style="width:20%">
				<col style="width:30%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">양식명</th>
					<td>
							<label><input type="text" class="txt-input" title="양식명" name="form_title" value="" maxlength="20"></label>
					</td>
					<th scope="row">사용 여부</th>
					<td>
						<input type="radio" id="useForm" name="form_use_flag" value="Y"><label for="useForm">사용</label>
						<input type="radio" id="unUseForm" name="form_use_flag" class="mgl_20" value="N" checked=""><label for="unUseForm">미사용</label>
					</td>
				</tr>
				<tr>
					<th scope="row">설명</th>
					<td colspan="3">
						<label><input type="text" class="txt-input" title="설명" name="form_comment" value="" maxlength="150"></label>
					</td>
			</tbody>
		</table>
		</div><!-- setting end -->
		<div id="form_content">
			<form class="form-horizontal" role="form" id="editorForm" method="post" action="/">
		    <div class="form-group">
		        <div class="form-group">
		            <div class="col-lg-12">
		                <textarea name="ckeditor" id="ckeditor"></textarea>
		            </div>
		        </div>
		        <div class="form-group">
		            <div class="col-lg-12" align="right">
		                <button type="submit" class="btn btn-default">저장</button>
		            </div>
		        </div>
		    </div>
			</form>
		</div><!-- form_content end -->
	</div><!-- wrap end -->
</div><!-- content end -->
</body>
</html>