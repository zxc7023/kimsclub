<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>양식 관리 페이지</title>
<script src="resources/js/jquery-3.2.1.min.js"></script>
<script src="resources/SmartEditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script>
$(document).ready(function() {
	var oEditors = []; 
	$(function(){ 
		nhn.husky.EZCreator.createInIFrame({ 
			oAppRef: oEditors, 
			elPlaceHolder: "form", 
			//SmartEditor2Skin.html 파일이 존재하는 경로 
			sSkinURI: "resources/SmartEditor/SmartEditor2Skin.html", 
			htParams : { 
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseToolbar : true, 
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseVerticalResizer : true, 
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
				bUseModeChanger : true, 
				fOnBeforeUnload : function(){ 
				} 
			}, 
			fOnAppLoad : function(){
				//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용 
				oEditors.getById["form"].exec("PASTE_HTML", ["기존 DB에 저장된 내용을 에디터에 적용할 문구"]); 
				},
				fCreator: "createSEditor2" 
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
			<textarea rows="10" cols="30" id="form" name="content" style="width:766px; height:412px; "></textarea>
		</div><!-- form_content end -->
	</div><!-- wrap end -->
</div><!-- content end -->
</body>
</html>