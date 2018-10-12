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

	});//ready end
</script>
</head>
<body>
<div id="content">
	<div id="content_title">양식 관리</div><!-- content_title end -->
	<div id="wrap">
		<div id="approval_menu">
			<ul>
				<li><a href="">양식 생성</a></li>
				<li><a href="">양식 삭제</a></li>
				<li><a href="">양식 활성화</a></li>
				<li><a href="">양식 비활성화</a></li>
			</ul>
		</div><!-- approval_menu end -->
		<div id="approval_list_table">
			<table>
				<tr>
					<th></th>
					<th>사용 여부</th>
					<th>양식명</th>
					<th>설명</th>
				</tr>
			</table>
		</div><!-- approval_list_table end -->
		<div id="approval_page"></div><!-- approval_page end -->
	</div><!-- wrap end -->
</div><!-- content end -->
</body>
</html>