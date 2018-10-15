<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html >
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="resources/js/jquery-3.2.1.min.js"></script>
<script src="resources/SmartEditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

	$(document).ready(function() {
		var oEditors = []; 
		$(function(){ 
			nhn.husky.EZCreator.createInIFrame({ 
				oAppRef: oEditors, 
				elPlaceHolder: "ir1", 
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
					oEditors.getById["ir1"].exec("PASTE_HTML", ["기존 DB에 저장된 내용을 에디터에 적용할 문구"]); 
					},
					fCreator: "createSEditor2" 
					}); 
			}); 
	});
	
</script>
	<form action="">
		<table style="height: 50px; width: 1300px">
			<tr>
			<td>제목</td>
			<td><input type="text"></td>
			</tr>
			
			<tr>
			<td>파일첨부</td><td><input type="file"> </td>
			</tr>
			
			<tr>
			<td>내용</td>
			<td><textarea rows="35" id="ir1" cols="90"></textarea></td>
			</tr>
			
			<tr>
			<td colspan="2"><input type="submit" value="확인"><input type="submit" value="취소"></td>
			</tr>
		</table>
	</form>
</body>
</html>