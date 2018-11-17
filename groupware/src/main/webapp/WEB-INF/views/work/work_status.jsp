<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- header 및 navigation을 불러오기 위해서 사용해야하는 자원들 아래 다 복사해서 붙여넣기 하세요. -->
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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css">
<!-- 전용css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/work/work_status.css">
<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>
<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>
<script>
	//캘린더 html 요소를 찾아서 변수에 저장.
	var today = new Date();
	var cal_start_date = new Date(today.getFullYear(),today.getMonth(),1);
	
	var month = new Array('1', '2', '3', '4', '5', '6', '7', '8', '9', '10','11', '12');
	function prevWeekCalendar() {
		cal_start_date = new Date(cal_start_date.getFullYear(),cal_start_date.getMonth(),1);
		buildCalendar();
	}

	function nextWeekCalendar() {
		cal_start_date = new Date(cal_start_date.getFullYear(),cal_start_date.getMonth(),16);
		buildCalendar();
	}

	function prevMonCalendar() {
		cal_start_date = new Date(cal_start_date.getFullYear(),cal_start_date.getMonth()-1,1);
		buildCalendar();
	}

	function nextMonCalendar() {
		cal_start_date = new Date(cal_start_date.getFullYear(),cal_start_date.getMonth()+1,1);
		buildCalendar();
	}

	function buildCalendar() {
		var tbCalendar = $("#calendar");

		//초기에 테이블이의 row(tr)이 존재하는경우 초기화
		if (tbCalendar.find("tr").length > 0) {
			tbCalendar.find("tr").remove();
		}

		var cnt = 0;

		var tr = "<tr></tr>";
		var td = "<td></td>";
		var thead = tbCalendar.find("thead");
		var tbody = tbCalendar.find("tbody");

		//thead의 첫 번째 row 추가 및 변수 선언
		thead.append(tr);
		var row1 = tbCalendar.find("thead tr:last-child").addClass("year_month");

		//thead의 두 번째 row 추가 및 변수 선언
		thead.append(tr);
		var row2 = tbCalendar.find("thead tr:nth-child(2)").addClass("date");
		if (cal_start_date.getDate()==1) {
			
			for (var i = 0; i < 15; i++) {
				row2.append(td);
				var cell_date = new Date(cal_start_date.getFullYear(), cal_start_date.getMonth(),
						cal_start_date.getDate() + i);
				row2.find("td:last-child").text(cell_date.getDate());
			}
			row2.append(td);
			var next = "<button type='button' id='nextWeek()' onclick='nextWeekCalendar()' class='glyphicon glyphicon-chevron-right'></button>";
			row2.find("td:last-child").html(next);
			cnt = 16;
		} else {
			var lastDateObj = new Date(cal_start_date.getFullYear(),cal_start_date.getMonth()+1,0);
			var lastDateTerms = lastDateObj.getDate()-15;
			for (var i = 0; i < lastDateTerms; i++) {
				
				//두번째 tr 내용 만드는작업
				row2.append(td);
				var cell_date = new Date(cal_start_date.getFullYear(), cal_start_date.getMonth(),cal_start_date.getDate() + i)
				row2.find("td:last-child").text(cell_date.getDate());
				
				
			}
			row2.append(td);
			var next = "<button type='button' id='prevWeek()' onclick='prevWeekCalendar()' class='glyphicon glyphicon-chevron-left'></button>";
			row2.find("td:last-child").html(next);
			cnt = lastDateTerms+1;
		}
		
		row1.append(td);
		var cell= row1.find("td:last-child").attr("colspan", cnt);
		var leftBtn = "<button type='button' id='prevMonthBtn' onclick='prevMonCalendar()' class='glyphicon glyphicon-chevron-left'></button>";
		var rightBtn = "<button type='button' id='nextMonthBtn' onclick='nextMonCalendar()' class='glyphicon glyphicon-chevron-right'></button>";
		cell.html(leftBtn + cal_start_date.getFullYear() + "." +  month[cal_start_date.getMonth()] + rightBtn);

	}
	$(document).ready(function() {

	});
</script>
<title>근태현황</title>
</head>
<body>
	<!-- 아래의 구조로 복사하시오 -->
	<!-- 전체 div-->
	<div id="wrapper">
		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>
		<!-- content div -->
		<div id="page-wrapper">
			<div class="row">
				<div class="col-sm-12">
					<h1 class="page-header">근태현황</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<table id="calendar">
						<thead></thead>
						<tbody></tbody>
					</table>
					<script type="text/javascript">
						buildCalendar();
					</script>
				</div>
			</div>
		</div>
	</div>
</body>
</html>