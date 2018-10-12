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
<script src="resources/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

	});
	
</script>
	<form action="">
		<table>
			<tr>
			<td>제목</td>
			<td><input type="text"></td>
			</tr>
			
			<tr>
			<td>파일첨부</td><td><input type="file"> </td>
			</tr>
			
			<tr>
			<td>내용</td>
			<td><textarea rows="30" cols="75"></textarea></td>
			</tr>
			
			<tr>
			<td colspan="2"><input type="submit" value="확인"><input type="submit" value="취소"></td>
			</tr>
		</table>
	</form>
</body>
</html>