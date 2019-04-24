<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>

<!-- 공통 JS, CSS를 모아서 불러오는 헤더-->
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<!-- 전용css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/work/work_status.css">

<script>

	var todayObj = new Date();
	var workhourObj;
	
	function getMyWorkRecode(callback,dateObj){
		$.ajax({
			method : "POST",
			dataType : "json",
			data : JSON.stringify(dateObj), 
			contentType : 'application/json;charset=UTF-8',
			url : "${pageContext.request.contextPath}/work/getMyWorkRecode",
			error : function() {
				alert('전송 실패');
			},
			success : function(result) {
				if(callback){
					callback(result);
				}
			}
		});
	}
	
	//받아온 근태 내역을 보여주는곳
	function prepareMyWorkData(result){
		var workList = result;
		console.log(workList);
		var work_recode_table = $(".work_recode_tb");
		var work_recode_tbody = work_recode_table.find("tbody");
		work_recode_tbody.empty();
		
		var tr ="<tr></tr>";
		
		for(var i=0 ; i < workList.length; i++){
			work_recode_tbody.append(tr);
			var last_tr = work_recode_tbody.find("tr:last-child");
		
			
			var start_time;
			if(workList[i].attendance_time != null){
				var start_date = new Date(workList[i].attendance_time);
				start_time = ("00" + start_date.getHours()).slice(-2)+":"+("00" + start_date.getMinutes()).slice(-2)+":"+("00" + start_date.getSeconds()).slice(-2);
			}else{
				start_time ="00:00:00";
			}
			
			var end_time;
			if(workList[i].leave_time != null){
				var leave_date = new Date(workList[i].leave_time); 
				end_time = ("00" + leave_date.getHours()).slice(-2)+":"+("00" + leave_date.getMinutes()).slice(-2)+":"+("00" + leave_date.getSeconds()).slice(-2);
			}else{
				end_time ="00:00:00";
			}
			
			var work_status ="-";
			if(workList[i].dayoffApply != null){
				var dayoff_name = workList[i].dayoffApply.dayoff_kind.dayoff_name;
				var oneorhalf;
				console.log(workList[i].dayoffApply.dayoff_apply_detail[0].oneorhalf);
				switch (workList[i].dayoffApply.dayoff_apply_detail[0].oneorhalf) {
				case "0":
					oneorhalf="일차";
					break;
				case "1":
					oneorhalf="오전반차";
					break;
				case "2":
					oneorhalf="오후반차";
					break;
				default:
					break;
				}
				work_status = dayoff_name + "/" + oneorhalf;
				console.log(work_status);
			}
			
			var tds = "<td>" + workList[i].work_date + "</td>"+ "<td>" + start_time + "</td>"+ "<td>" + end_time + "</td>"+"<td>"+work_status+"</td>";
			last_tr.append(tds);

		}
		
	
		
	}

	
	
	//ajax로 나의 입사년도,출퇴근 시간을 받아오고 callback 메소드에 전달
	function getInitalData(callback){
		$.ajax({
			method : "get",
			dataType : "json",
			contentType : 'application/json;charset=UTF-8',
			url : "${pageContext.request.contextPath}/work/getInitalData",
			error : function() {
				alert('전송 실패');
			},
			success : function(result) {
				if(callback){
					callback(result);
				}
			}
		});
	}
	
	//ajax로 받아온 나의 입사연도를 가지고 yaer, month에 대한 select option 태그 생성.
	function prepareSelectTag(result){
		console.log("prepareSelectTag 메소드");
		var hiredateObj  = new Date(result.hiredate);
		workhourObj = result.workhour;
		//select [name=year]
		var yearSelectTag = $("select[name=year]"); 
		for(var i = hiredateObj.getFullYear(); i <=todayObj.getFullYear() ; i++){
			var optionTag = "<option value='"+ i +"'>"+i+"년</option>";
			yearSelectTag.append(optionTag);
			if(todayObj.getFullYear()==i){
				yearSelectTag.find("option:last").prop("selected", true);
			}
		}
		
		//select [name=month]
		var monthSelectTag = $("select[name=month]");
		for(var i=1; i<=12; i ++){
			var optionTag = "<option value='"+ i +"'>"+i+"월</option>";
			monthSelectTag.append(optionTag);
			if(todayObj.getMonth()==(i-1)){
				monthSelectTag.find("option:last").prop("selected", true);
			}
		}
		//현재 년도월을 기준으로 데이터를 가져온다.		
		getMyWorkRecode(prepareMyWorkData,todayObj);
	}

	$(document).ready(function() {
		
		//입사연도를 기준으로 현재 연도까지의 연도수를 받아온다.
		getInitalData(prepareSelectTag);
		
		//select 이벤트 감지 
		$("select").change(function(){
			
			//선택한 값을 가지고 Date생성
			var send_date = new Date($("#year option:selected").val(),$("#month option:selected").val()-1,todayObj.getDate());
			
			//선택한 년월을 가지고 만든 Date 객체를 ajax를 통해 해당하는 날짜의 근무기록표를 가져온다. 
			getMyWorkRecode(prepareMyWorkData,send_date);
			return false;
		});
		
		
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
					<h1 class="page-header">근태 현황</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<form id="selects">
						<select name="year" id="year">
						</select> 
						<select name="month" id="month">
						</select>
					</form>
				</div>
				<div class ="col-sm-10">
					<table class="work_recode_tb table table-bordered">
						<colgroup>
							<col width="25%">
							<col width="30%">
							<col width="30%">
							<col width="15%">
						</colgroup>
						<thead>
							<tr>
								<th>날짜</th>
								<th>출근(시간/결과)</th>
								<th>퇴근(시간/결과)</th>
								<th>휴가종류/구분</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>