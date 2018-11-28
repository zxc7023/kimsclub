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
<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>
<script>
	
	//처음시작 됫을때 오늘날짜를 지정하는작업 
	var today = new Date();
	var cal_start_date = new Date(today.getFullYear(), today.getMonth(), 1);
	
	//처음에 출근/퇴근시간이 저장된 VO객체를 DOM tree가 시작 됫을때 json스트링으로 받아옴?
	var work_setting;

	//캘린더 month의 값을 표기하기위해 사용
	var month = new Array('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12');
	
	//간략통계에서 cal_start_date 기준 1일에서 ~ 15일까지의 데이터를 받아옴
	function prevWeekCalendar() {
		cal_start_date = new Date(cal_start_date.getFullYear(), cal_start_date.getMonth(), 1);
		getCalDataAjax(buildCalendar, cal_start_date);
	}
	//간략통계에서 cal_start_date기준 16일에서 ~ 마지막일까지의 데이터를 받아옴
	function nextWeekCalendar() {
		cal_start_date = new Date(cal_start_date.getFullYear(), cal_start_date.getMonth(), 16);
		getCalDataAjax(buildCalendar, cal_start_date);
	}

	//간략통계에서 cal_start_date 기준 이전달의 데이터를 받아옴
	function prevMonCalendar() {
		cal_start_date = new Date(cal_start_date.getFullYear(), cal_start_date.getMonth() - 1, 1);
		getCalDataAjax(buildCalendar, cal_start_date);
	}

	//간략통계에서 cal_start_date 기준 다음달 데이터를 받아옴
	function nextMonCalendar() {
		cal_start_date = new Date(cal_start_date.getFullYear(), cal_start_date.getMonth() + 1, 1);
		getCalDataAjax(buildCalendar, cal_start_date);
	}

	//처음시작할때 cal_start_date를 기준으로 시작함
	var getCalDataAjax = function(callback, cal_start_date) {
		$.ajax({
			method : "post",
			dataType : "json",
			contentType : 'application/json;charset=UTF-8',
			data : JSON.stringify(cal_start_date),
			url : "${pageContext.request.contextPath}/work/getMyWorkStatus",
			error : function() {
				alert('전송 실패');
			},
			success : function(result) {

				if (callback) {
					callback(result);
				}
			}
		});
	};

	function buildCalendar(result) {
		
		//ajax로받은 
		var workRecode = result;
		console.log(workRecode);
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

		//년-월
		thead.append(tr);
		var row1 = tbCalendar.find("thead tr:last-child").addClass("year_month");

		//일자
		thead.append(tr);
		var row2 = tbCalendar.find("thead tr:nth-child(2)").addClass("date");

		tbody.append(tr);
		var row3 = tbCalendar.find("tbody tr:nth-child(1)").addClass("am");

		tbody.append(tr);
		var row4 = tbCalendar.find("tbody tr:nth-child(2)").addClass("pm");
		
		
		
		
		//첫 번째 tr (년-월 일)에 해당하는 tr을 출력하는부분
		row1.append(td);
		var cell = row1.find("td:last-child").attr("colspan", workRecode.length +1);
		var leftBtn = "<button type='button' id='prevMonthBtn' onclick='prevMonCalendar()' class='glyphicon glyphicon-chevron-left'></button>";
		var rightBtn = "<button type='button' id='nextMonthBtn' onclick='nextMonCalendar()' class='glyphicon glyphicon-chevron-right'></button>";
		cell.html(leftBtn + cal_start_date.getFullYear() + "." + month[cal_start_date.getMonth()] + rightBtn);
		
		
		
		//두 번째 tr (일자)를 출력해주는 부분
		for(var i=0; i < workRecode.length ; i++){
			row2.append(td);
			var cell_date = new Date(cal_start_date.getFullYear(), cal_start_date.getMonth(), cal_start_date.getDate() + i);
			row2.find("td:last-child").text(cell_date.getDate());
		}
		
		//이전 주 혹은 다음 주를 선택하는 버튼을 만드는부분
		row2.append(td);
		console.log(cal_start_date.getDate());
		var prevOrNext;
		if(cal_start_date.getDate() == 1){
			prevOrNext = "<button type='button' id='nextWeek()' onclick='nextWeekCalendar()' class='glyphicon glyphicon-chevron-right'></button>";		
		}else{
			prevOrNext = "<button type='button' id='prevWeek()' onclick='prevWeekCalendar()' class='glyphicon glyphicon-chevron-left'></button>";
		}
		row2.find("td:last-child").html(prevOrNext);
		
		
		
		
		
		//tr 3번째, 4번째를 출력하는 부분
		for (var i = 0; i < workRecode.length; i++) {
			row3.append(td);
			row4.append(td);
			var am_work_data = "-";
			var pm_work_data = "-";

			//휴가를 쓴 경우를 맨처음 거른다.
			if (workRecode[i].dayoffApply != null) {
				var detail = workRecode[i].dayoffApply.dayoff_apply_detail[0];
				switch (detail.oneorhalf) {
				case "0":
					am_work_data = workRecode[i].dayoffApply.dayoff_kind.dayoff_name.substring(0, 1);
					pm_work_data = workRecode[i].dayoffApply.dayoff_kind.dayoff_name.substring(0, 1);
					break;
				case "1":
					am_work_data = workRecode[i].dayoffApply.dayoff_kind.dayoff_name.substring(0, 1);
					break;
				case "2":
					pm_work_data = workRecode[i].dayoffApply.dayoff_kind.dayoff_name.substring(0, 1);
					break;
				default:
					break;
				}
			} else {//휴가자가 아닌경우
				if (workRecode[i].attendance_time != null) {//출근했는경우
					var attend_hour = new Date(workRecode[i].attendance_time);
					console.log("출근시간: " + attend_hour.getHours());
					am_work_data = "정";
					if (attend_hour.getHours() >= work_setting.start_hour) {
						if (attend_hour.getMinutes() >= work_setting.start_minute) {
							am_work_data = "지";
						}
					}
				} else {//안했는경우
					am_work_data = "-";
				}

				if (workRecode[i].leave_time != null) {//출근했는경우
					var leave_hour = new Date(workRecode[i].leave_time);
					console.log("출근시간: " + leave_hour.getHours());
					am_work_data = "정";
					if (leave_hour.getHours() <= work_setting.end_hour) {
						if (leave_hour.getMinutes() <= work_setting.end_minute) {
							am_work_data = "조";
						}
					}
				} else {//안했는경우
					pm_work_data = "-";
				}
			}

			row3.find("td:last-child").text(am_work_data);
			row4.find("td:last-child").text(pm_work_data);
		}

		row3.append(td);
		row4.append(td);
		


	}
	$(document).ready(function() {
		work_setting = ${requestScope.workSetting};
		employee = ${requestScope.employee};
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
					<div class="panel panel-default">
						<div class="panel-heading">간략 보기</div>
						<div class="panel-body">
							<div class="select_mon_year"><span>보기:<a id="conditions">월단위</a></span></div>
							<div>
								<table id="calendar" class="table table-bordered">
									<thead></thead>
									<tbody></tbody>
								</table>
								<script type="text/javascript">
									getCalDataAjax(buildCalendar, cal_start_date);
								</script>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>