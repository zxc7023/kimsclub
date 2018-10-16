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
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	var today = new Date();//오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
	var date = new Date();//today의 Date를 세어주는 역할
/* 	function prevCalendar() {//이전 달
		// 이전 달을 today에 값을 저장하고 달력에 today를 넣어줌
		//today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
		//getMonth()는 현재 달을 받아 오므로 이전달을 출력하려면 -1을 해줘야함
		today = new Date(today.getFullYear(), today.getMonth() - 1, today
				.getDate());
		buildCalendar(); //달력 cell 만들어 출력 
	} */

/* 	function nextCalendar() {//다음 달
		// 다음 달을 today에 값을 저장하고 달력에 today 넣어줌
		//today.getFullYear() 현재 년도//today.getMonth() 월  //today.getDate() 일 
		//getMonth()는 현재 달을 받아 오므로 다음달을 출력하려면 +1을 해줘야함
		today = new Date(today.getFullYear(), today.getMonth() + 1, today
				.getDate());
		buildCalendar();//달력 cell 만들어 출력
	} */
	
	function buildCalendar() {
		//현재 달 달력 만들기
		var doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
		//이번 달의 첫째 날,
		//new를 쓰는 이유 : new를 쓰면 이번달의 로컬 월을 정확하게 받아온다.     
		//new를 쓰지 않았을때 이번달을 받아오려면 +1을 해줘야한다. 
		//왜냐면 getMonth()는 0~11을 반환하기 때문
		var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
		//이번 달의 마지막 날
		//new를 써주면 정확한 월을 가져옴, getMonth()+1을 해주면 다음달로 넘어가는데
		//day를 1부터 시작하는게 아니라 0부터 시작하기 때문에 
		//대로 된 다음달 시작일(1일)은 못가져오고 1 전인 0, 즉 전달 마지막일 을 가져오게 된다
		var tbCalendar = document.getElementById("calendar");
		//날짜를 찍을 테이블 변수 만듬, 일 까지 다 찍힘
		var tbCalendarYM = document.getElementById("tbCalendarYM");
		//테이블에 정확한 날짜 찍는 변수
		//innerHTML : js 언어를 HTML의 권장 표준 언어로 바꾼다
		//new를 찍지 않아서 month는 +1을 더해줘야 한다. 
		tbCalendarYM.innerHTML = today.getFullYear() + "년 "
				+ (today.getMonth() + 1) + "월";

		/*while은 이번달이 끝나면 다음달로 넘겨주는 역할*/
		while (tbCalendar.rows.length > 2) {
			//열을 지워줌
			//기본 열 크기는 body 부분에서 2로 고정되어 있다.
			tbCalendar.deleteRow(tbCalendar.rows.length - 1);
			//테이블의 tr 갯수 만큼의 열 묶음은 -1칸 해줘야지 
			//30일 이후로 담을달에 순서대로 열이 계속 이어진다.
		}
		var row = null;
		row1 = tbCalendar.insertRow();
		row2 = tbCalendar.insertRow();
		//테이블에 새로운 열 삽입//즉, 초기화
		var cnt = 0;// count, 셀의 갯수를 세어주는 역할
		// 1일이 시작되는 칸을 맞추어 줌
/* 		for (i = 0; i < doMonth.getDay(); i++) {
			//이번달의 day만큼 돌림
			cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
			cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
		} */
		//달력 출력
		for (i = 0; i < 15; i++) {
			cell = row1.insertCell();//요일을 나타낼 셀(td)
			cell2 = row2.insertCell();//일자를 나타낼 셀(td)
			var cell_date = new Date(today.getFullYear(), today.getMonth(),today.getDate()+i);
			cell.innerHTML = week[cell_date.getDay()];
			cell2.innerHTML = cell_date.getDate();//현재일로부터 15일뒤의 날까지 보여준다.
			cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
/* 			if (cnt % 7 == 1) {//일요일 계산
				//1주일이 7일 이므로 일요일 구하기
				//월화수목금토일을 7로 나눴을때 나머지가 1이면 cnt가 1번째에 위치함을 의미한다
				cell.innerHTML = "<font color=#F79DC2>" + i
				//1번째의 cell에만 색칠
			}
			if (cnt % 7 == 0) {//1주일이 7일 이므로 토요일 구하기
				//월화수목금토일을 7로 나눴을때 나머지가 0이면 cnt가 7번째에 위치함을 의미한다
				cell.innerHTML = "<font color=skyblue>" + i
				//7번째의 cell에만 색칠
				row = calendar.insertRow();
				//토요일 다음에 올 셀을 추가
			}
			//오늘의 날짜에 노란색 칠하기
			if (today.getFullYear() == date.getFullYear()
					&& today.getMonth() == date.getMonth()
					&& i == date.getDate()) {
				//달력에 있는 년,달과 내 컴퓨터의 로컬 년,달이 같고, 일이 오늘의 일과 같으면
				cell.bgColor = "#FAF58C";//셀의 배경색을 노랑으로 
			} */
		}
	}
</script>
<title>휴가 신청</title>
</head>
<body>
	<section>
		<div class="container-fluid">
		<div class="row">
				<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>
				<div class="col-10 back cont-wrap">
					<table class='day_selection_wrap'>
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
									<table id="calendar" border="3" align="center" style="border-color: #3333FF">
										<tr>
											<!-- label은 마우스로 클릭을 편하게 해줌 -->
											<td>
												<label onclick="prevCalendar()"><</label>
											</td>
											<td align="center" id="tbCalendarYM" colspan="5">yyyy년 m월</td>
											<td>
												<label onclick="nextCalendar()">> </label>
											</td>
										</tr>
									</table>
									<script language="javascript" type="text/javascript">
										buildCalendar();//
									</script>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			</div>
	</section>
</body>
</html>