<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="resources/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	
	});
	
</script>
<%-- <c:out value="${param.boardType}"/> --%>
	<form id="frm" action="BoardWrite" method="post">
		<table width="100%">
			<tr>
			<td>제목</td>
			<td><input type="text" name="board_title"></td>
			</tr>
			
			<!-- <tr>
			<td>파일첨부</td><td><input type="file"> </td>
			</tr> -->
			
			<tr>
			<td>내용</td>
			<td><textarea rows="35" id="ir1" cols="90" name="board_contents"></textarea></td>
			</tr>
		</table>
		<input type="hidden" id="boardType" name="board_type" value="${param.boardType}" >
		<input type="submit" id="save" value="저장">
	</form>
</body>
</html>