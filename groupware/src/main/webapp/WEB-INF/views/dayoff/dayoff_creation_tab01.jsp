<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
	$(document).ready(function() {

	});
</script>
<div class="dayoff-create-recode">
	<h3>휴가 생성 내역</h3>
	<table class="table" id="myTable">
		<colgroup>
			<col width="20%">
			<col width="10%">
			<col width="10%">
			<col width="20%">
			<col width="50%">
		</colgroup>
		<thead>
			<tr>
				<th>생성일</th>
				<th>발생일</th>
				<th>최종일</th>
				<th>내용</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="creation" items="${requestScope.createList}">
				<tr>
					<td><fmt:formatDate value="${creation.generation_date}" pattern="yyyy.MM.dd" /></td>
					<td>${creation.effect_day }</td>
					<td>${creation.real_day }</td>
					<c:if test="${creation.dayoff_type eq 1}">
						<td>정기 휴가</td>
						<td>금년 발생일(${creation.effect_day}), 최종일(${creation.real_day })
					</c:if>
					<c:if test="${creation.dayoff_type eq 2}">
						<td>포상 휴가</td>
						<td>포상(${creation.effect_day}), 최종일(${creation.real_day})</td>
					</c:if>
					<c:if test="${creation.dayoff_type eq 3}">
						수동 입력
					</c:if>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<h4>
		올해 사용 현황 : <small> 생성 : ${requestScope.myDayoff.annual_dayoff + requestScope.myDayoff.reward_dayoff + requestScope.myDayoff.previous_dayoff} 일 / 사용 : ${requestScope.useReward + requestScope.useRegular} 일 / 잔여 : ${(requestScope.myDayoff.annual_dayoff - requestScope.useRegular) + (requestScope.myDayoff.reward_dayoff - requestScope.useReward)} 일 ( 정기 : ${requestScope.myDayoff.annual_dayoff - requestScope.useRegular} , 포상 : ${requestScope.myDayoff.reward_dayoff - requestScope.useReward} ) </small>
	</h4>
</div>