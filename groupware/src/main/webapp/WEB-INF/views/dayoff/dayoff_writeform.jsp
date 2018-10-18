<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.0.2/TweenMax.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href=" ${pageContext.request.contextPath}/resources/css/default.css">
<link rel="stylesheet" href=" ${pageContext.request.contextPath}/resources/css/navigation.css">
<link rel="stylesheet" href=" ${pageContext.request.contextPath}/resources/css/dayoff/day_selection.css">
<script type="text/javascript">
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	var month = new Array('1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
			'11', '12');

	var today = new Date();
	var cal_start_date = today;
	var last_date;

	function prevCalendar() {
		cal_start_date = new Date(cal_start_date.getFullYear(), cal_start_date
				.getMonth(), cal_start_date.getDate() - 15);
		buildCalendar();
	}

	function nextCalendar() {
		cal_start_date = new Date(cal_start_date.getFullYear(), cal_start_date
				.getMonth(), cal_start_date.getDate() + 15);
		buildCalendar();
	}

	function buildCalendar() {

		//start_date 시작일이 포함된 달의 마지막 날을 담은 date 객체
		last_date = new Date(cal_start_date.getFullYear(), cal_start_date
				.getMonth() + 1, 0);

		//캘린더 html 요소를 찾아서 변수에 저장.
		var tbCalendar = document.getElementById("calendar");

		//왼쪽,오른쪽 버튼을 눌렀을때 초기화 작업.
		while (tbCalendar.rows.length > 0) {
			tbCalendar.deleteRow(tbCalendar.rows.length - 1);
		}

		//첫번재 tr 연도.달
		//월을 나타내줄 tr
		var cnt = 0;
		var flag = 0;

		var row1 = tbCalendar.insertRow(0);
		//두번째 tr : 요일
		row2 = tbCalendar.insertRow(1);
		//세번째 tr : 일자
		row3 = tbCalendar.insertRow(2);
		row4 = tbCalendar.insertRow(3);
		for (i = 0; i < 15; i++) {
			cell2 = row2.insertCell();//요일을 나타낼 셀(td)
			cell3 = row3.insertCell();//일자를 나타낼 셀(td)
			cell4 = row4.insertCell();//일자를 나타낼 셀(td)
			var cell_date = new Date(cal_start_date.getFullYear(),
					cal_start_date.getMonth(), cal_start_date.getDate() + i);
			cell2.innerHTML = week[cell_date.getDay()];
			cell3.innerHTML = cell_date.getDate();
			if (flag == 0) {
				if (cell_date.getDate() == last_date.getDate()) {
					flag = 1;
				}
				cnt++;
			}
		}
		//첫번째 tr에 cell 하나 추가
		cell1 = row1.insertCell();

		cell1.colSpan = cnt;
		cell1.innerHTML = cal_start_date.getFullYear() + "."
				+ month[cal_start_date.getMonth()];
		if (cnt < 15) {
			cell2 = row1.insertCell();
			cell2.colSpan = 15 - cnt;
			cell2_date = new Date(cal_start_date.getFullYear(), cal_start_date
					.getMonth() + 1, 1);
			cell2.innerHTML = cell2_date.getFullYear() + "."
					+ month[cell2_date.getMonth()];
		}

	}
</script>

<script>
	$(document).ready(function() {
		$("#calendar tr").click(function(){
			
		});
		
	});
</script>

<title>휴가 신청</title>
</head>
<body>
	<section>
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>
				<div class="col-10 back cont-wrap">
					<div class="row">
						<table class='day_selection_wrap col-10'>
							<colgroup>
								<col width="150">
								<col width="auto">
							</colgroup>
							<tbody>
								<tr>
									<th>현황</th>
									<td colspan="3">휴가 현황을 보여줄 예정입니다.</td>
								</tr>
								<tr>
									<th>작성자</th>
									<td colspan="3">사원이름</td>
								</tr>
								<tr>
									<th>처리</th>
									<td>
										<button>결재선 선택</button>
									</td>
								</tr>
								<tr>
									<th>휴가 기간</th>
									<td colspan="3" class="calendar_wrap">
										<table id="calendar" class="col-10">
										</table>
										<button onclick="prevCalendar()">앞</button>
										<button onclick="nextCalendar()">뒤</button>
										<script type="text/javascript">
											buildCalendar();
										</script>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>