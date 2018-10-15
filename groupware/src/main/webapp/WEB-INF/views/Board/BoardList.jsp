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
<table border="2">
	<tr><td>번호</td><td>작성자</td><td>제목</td><td>작성일시</td><td>조회</td></tr>
<c:forEach items="${BoardList}" var="list">
	<tr>
		<td>${list.board_no}</td>
		<td>${list.board_writer}</td>
		<td>${list.board_title}</td>
		<td>${list.board_date}</td>
		<td>${list.board_viewcount}</td>
	</tr>
</c:forEach>
</table>
</body>
</html>