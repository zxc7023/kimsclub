<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
	});
</script>
<table>
	<tr>
		<td>날짜</td><td>${detailVO.board_date}</td>
	</tr>
	<tr>
		<td>제목</td><td>${detailVO.board_title}</td>
	</tr>
	<tr>
		<td>작성자</td><td>${detailVO.board_writer}</td>
	</tr>
</table>
<table>	
	<tr>
		<td>내용</td>
	</tr>
	<tr>
	<td>${detailVO.board_contents}</td>
	</tr>
</table>
</body>
</html>