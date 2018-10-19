<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>양식 관리 페이지</title>
<script src="resources/js/jquery-3.2.1.min.js"></script>
<!-- navigation -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.0.2/TweenMax.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>
<link rel="stylesheet" href="resources/css/default.css">
<link rel="stylesheet" href="resources/css/navigation.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<script src="resources/ckeditor/ckeditor.js"></script>
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
<body class="bg-dark">
<div class="card card-register mx-auto mt-5">
	<div class="card-header">양식 생성</div>
	<div class="card-body">
		<form>
		<div class="form-group">
			<div class="form-row">
				<div class="col-md-6">
					<div class="form-label-group">
                    	<input type="text" id="form_name" class="form-control" placeholder="양식 이름" required="required" autofocus="autofocus">
					</div>
				</div>
				<div class="col-md-6"></div>
			</div>
		</div>
		<div class="col-lg-12">
			<textarea name="ckeditor" id="ckeditor"></textarea>
		</div>
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
						<input type="radio" id="unUseForm" name="form_use_flag" class="mgl_20" value="N" ><label for="unUseForm">미사용</label>
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
			<a class="btn btn-primary btn-block" href="/groupware/createform">확인</a>
		</form>
	</div><!-- wrap end -->
</div><!-- content end -->
</body>
</html>