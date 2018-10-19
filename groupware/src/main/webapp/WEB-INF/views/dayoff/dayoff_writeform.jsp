<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- header 및 navigation을 불러오기 위해서 사용해야하는 자원들 아래 다 복사해서 붙여넣기 하세요. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap Core CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Core CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>





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
		var tbCalendar = $("#calendar");

		//초기에 테이블이의 row(tr)이 존재하는경우 초기화
		if (tbCalendar.find("tr").length > 0) {
			tbCalendar.find("tr").remove();
		}

		var cnt = 0;
		var flag = 0;

		var tr = "<tr></tr>";
		var td = "<td></td>";
		var thead = tbCalendar.find("thead");
		var tbody = tbCalendar.find("tbody");

		//thead의 첫 번째 row 추가 및 변수 선언
		thead.append(tr);
		var row1 = tbCalendar.find("thead tr:last-child")
				.addClass("year_month");

		//thead의 두 번째 row 추가 및 변수 선언
		thead.append(tr);
		var row2 = tbCalendar.find("thead tr:nth-child(2)").addClass("day");

		//thead의 세 번째 row 추가 및 변수 선언
		thead.append(tr);
		var row3 = tbCalendar.find("thead tr:nth-child(3)")
				.addClass("day-name");

		//tbody의 첫 번째 row 추가 및 변수 선언
		tbody.append(tr);
		var row4 = tbCalendar.find("tbody tr");

		for (i = 0; i < 15; i++) {
			row2.append(td);
			row3.append(td);
			row4.append(td);

			var cell_date = new Date(cal_start_date.getFullYear(),
					cal_start_date.getMonth(), cal_start_date.getDate() + i);
			var cell2 = row2.find("td:last-child").text(
					week[cell_date.getDay()]);
			var cell3 = row3.find("td:last-child").text(cell_date.getDate());
			var cell4 = row4.find("td:last-child");
			cell4.attr("data-dayoff_date", cell_date.getFullYear() + "/"
					+ cell_date.getMonth() + "/" + cell_date.getDate());

			if (flag == 0) {
				if (cell_date.getDate() == last_date.getDate()) {
					flag = 1;
				}
				cnt++;
			}
		}

		row4.find("td").each(function() {
			$(this).click(function() {
				var div = "<div></div>";
				console.log($(this).prop('tagName'));
				console.log($(this));
				switch ($(this).attr("class")) {
				case "full_absence":
					alert("오전반차를 선택했습니다.");
					$(this).find("div").attr("class", "am_absence");
					break;
				case "am_absence":
					alert("오후반차를 선택했습니다.");
					$(this).find("div").attr("class", "pm_absence");
					break;
				case "pm_absence":
					alert("없음을 선택했습니다.");
					$(this).find("div").removeAttr("class");
					break;
				default:
					alert('풀차를 선택했습니다.');
					$(this).append("<div class='full_absence'></div>");

				}

				//alert($(this).data("dayoff_date"));

			});
		});

		//첫번째 tr에 cell 하나 추가
		row1.append(td);
		var cell1_1 = row1.find("td:last-child").attr("colspan", cnt);
		cell1_1.text(cal_start_date.getFullYear() + "."
				+ month[cal_start_date.getMonth()]);
		if (cnt < 15) {
			row1.append(td);
			var cell1_2 = row1.find("td:last-child").attr("colspan", 15 - cnt);
			cell1_2_date = new Date(cal_start_date.getFullYear(),
					cal_start_date.getMonth() + 1, 1);
			cell1_2.text(cell1_2_date.getFullYear() + "."
					+ month[cell1_2_date.getMonth()]);
		}

	}
</script>
<title>휴가 신청</title>
</head>
<body>

	<!-- 아래의 구조로 복사하시오 -->
	<!-- 전체 div-->
	<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper" style="min-height: 927px;">

			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">휴가 신청</h1>
				</div>
			</div>

			<div class="col-lg-12">
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
									<thead></thead>
									<tbody></tbody>
								</table>
								<button id="before" onclick="prevCalendar()">앞</button>
								<button id="next" onclick="nextCalendar()">뒤</button>
								<script type="text/javascript">
									buildCalendar();
								</script>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 				<div class="panel panel-primary">
					<div class="panel-heading">판넬의 헤딩</div>
					<div class="panel-body">판넬의 바디</div>
				</div> -->
			</div>



		</div>
	</div>
</body>
</html>