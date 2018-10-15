<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>양식 관리 페이지</title>
<script src="resources/js/jquery-3.2.1.min.js"></script>
<script>
	$(document).ready(function(){
		 $( '.check-all' ).click( function() {
	          $( '.check' ).prop('checked', this.checked );
	     } );
	});//ready end
</script>
</head>
<body>
<div id="content">
	<div id="content_title">양식 관리</div><!-- content_title end -->
	<div id="wrap">
		<div id="form_menu">
			<ul>
				<li><a href="/groupware/createform">양식 생성</a></li>
				<li><a href="">양식 삭제</a></li>
				<li><a href="">양식 활성화</a></li>
				<li><a href="">양식 비활성화</a></li>
			</ul>
		</div><!-- form_menu end -->
		<div id="form_list_table">
			<table>
				<tr>
					<th><p><input type="checkbox" name="all" class="check-all"></p></th>
					<th>사용 여부</th>
					<th>양식명</th>
					<th>설명</th>
				</tr>
				<!-- 예시 -->
				<tr>
					<td><p><input type="checkbox" name="check" class="check"></p></td>
					<td>사용</td>
					<td>양식1</td>
					<td>설명</td>
				</tr>
				<tr>
					<td><p><input type="checkbox" name="check" class="check"></p></td>
					<td>사용</td>
					<td>양식2</td>
					<td>설명</td>
				</tr>
				<tr>
					<td><p><input type="checkbox" name="check" class="check"></p></td>
					<td>사용</td>
					<td>양식3</td>
					<td>설명</td>
				</tr>
			</table>
		</div><!-- form_list_table end -->
		<div id="form_page"></div><!-- form_page end -->
	</div><!-- wrap end -->
</div><!-- content end -->
</body>
</html>