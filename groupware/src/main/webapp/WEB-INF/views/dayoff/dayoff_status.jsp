<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css">
<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>
<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js"></script>
<script type='text/javascript'src='${pageContext.request.contextPath}/resources/js/gcal.js'></script>

<!-- dayoff_writeform.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dayoff/day_status.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css">
<script src="${pageContext.request.contextPath}/resources/locale/ko.js"></script>
<script type="text/javascript">

var department_no = 1;

function beforeClick(treeId, treeNode) {
	   if (treeNode.parent) {
	      
		   //parent 구분하기위해 부서 명 앞에 d적은 거 자르기
	      department_no = treeNode.no.split('d')[1];
	      $('#testTreeModal').modal('hide');
	      $('#calendar').fullCalendar('rerenderEvents');
	      $("#tree-btn").text(treeNode.name);
	      
	      //return true;
	   } else {
	      alert("사원 클릭 : "+name+":"+no);
	      //return false;
	   }

	}

	$(document).ready(function(){
		
		$("#applyDetailModal").on("click","#approval_cancel",function(){
			var move = confirm('기안을 취소하시겠습니까?');
			if(move) {  
				/* window.location.replace("/groupware/retrieveDoc?document_no=201"); */
			}
			else { //no
			}
			
	

		});
		
		
		var eventList;
	
		$("#calendar").fullCalendar({
			header : {
				left : '',
				center : 'prev title next',
				right : ''
			},
			defaultView: 'month',
			views: {
			    month: {
			      eventLimit: 3 // adjust to 6 only for agendaWeek/agendaDay
			    }
			},
			eventLimit : true,
			events: function(start, end, timezone, callback) {
	               var d = $(calendar).fullCalendar('getDate');
	               var month = moment(d).format("MM");
	               var year = moment(d).format("YYYY");
	               var data = { month: month, year: year};
	               $.ajax({
	                 url: '${pageContext.request.contextPath}/dayoff/dayoffCal',
	                 dataType: 'json',
	               contentType : 'application/json;charset=UTF-8',
	                 method: 'POST',
	                 data: JSON.stringify(data),
	                 success: function(applyVo) {
	                     var events = [];
	                     for (var i=0;i<applyVo.length;i++){
	                        var details = applyVo[i].dayoff_apply_detail;
	                        for(var j=0;j<details.length;j++){
	                           var tmpObj = {};
	                           var start;
	                           var end;
	                           var color;
	                           if(applyVo[i].dayoff_apply_detail[j].oneorhalf ==0){
	                               start =applyVo[i].dayoff_apply_detail[j].dayoff_day + " 09:00";
	                               end = applyVo[i].dayoff_apply_detail[j].dayoff_day + " 18:00";
	                               color ="#007bff";
	                            }else if(applyVo[i].dayoff_apply_detail[j].oneorhalf ==1){
	                               start =applyVo[i].dayoff_apply_detail[j].dayoff_day + " 09:00";
	                               end = applyVo[i].dayoff_apply_detail[j].dayoff_day + " 14:00";
	                               color ="#21ff00";
	                            }else if(applyVo[i].dayoff_apply_detail[j].oneorhalf ==2){
	                               start =applyVo[i].dayoff_apply_detail[j].dayoff_day + " 14:00";
	                               end = applyVo[i].dayoff_apply_detail[j].dayoff_day + " 18:00";
	                               color ="#ffbf00";
	                            }
	                          
	                           tmpObj.id =applyVo[i].dayoff_no;
	                           tmpObj.title = applyVo[i].employee.employee_name;
	                           tmpObj.start = start;
	                           tmpObj.end = end;
	                           tmpObj.color = color;
	                           tmpObj.oneorhalf = applyVo[i].dayoff_apply_detail[j].oneorhalf;
	                           tmpObj.className = "dayoffApply";
	                           tmpObj.department_no = applyVo[i].employee.department.department_no;
	                           tmpObj.department_name = applyVo[i].employee.department.department_name;
	                           tmpObj.dayoff_name = applyVo[i].dayoff_kind.dayoff_name;
	                           events.push(tmpObj);//this is displaying!!!   
	                        }
	                     }
	                     eventList=events;
	                     callback(events);
	                 }
	               });
	         },
	         eventRender: function(event, element, view) {
	        	 element.on('click', function(e){
	        	        if (element.closest('.Holidays').length) {
	        	            e.preventDefault();
	        	        }
	        	 });
	        	 var arrayParam = new Array();
	        	 $("input:checkbox[name=oneorhalf]:checked").each(function(){
	        		 arrayParam.push($(this).val());
	        	 });
	        	 if(event.className[0] == "dayoffApply"){
		        	 if(arrayParam.indexOf(event.oneorhalf) == -1){
		        		 return false;
		             }	        		 
	        	 }
	        	 
	        	 if(department_no != 1){
	        		 if(event.department_no != department_no){
	        		 	return false;
	        	 	}
	        	 }
	        	 return true;

	       	},
			timeFormat: 'HH:mm',
			googleCalendarApiKey : "AIzaSyCDfUSkgM9JFdDtehs-JcJD9tVgPtzmUtQ",
		    eventSources : [{
		         googleCalendarId : "qansohiecib58ga9k1bmppvt5oi65b1q@import.calendar.google.com",
		         className : "Holidays",
		         color : "#FFFFFF",
		         textColor : "#FF0000",
		    }],
			locale: 'ko',
			eventClick: function(calEvent, jsEvent, view) {
			
				var sameIdArr = [];
				var trStream = '';
				for(var i =0; i < eventList.length ; i++){
					if(eventList[i].id == calEvent.id){
						sameIdArr.push(eventList[i]);
						trStream += "<tr><td>"+eventList[i].start+"</td><td>"+eventList[i].end+"</td></tr>";
					} 
				}
				console.log(sameIdArr);
				$("#myModalCalLabel").text(calEvent.title +"/"+calEvent.department_name + "  "+calEvent.dayoff_name+ "휴가내역");
				$("#myModalCalTable tbody").html(trStream);
				
				
				$("#myDayoffCal").modal("show");
				jsEvent.preventDefault();
			},
			dayClick : function(){
				alert("캘린더선택");
			}
		});
 
	  	 $("input[type=checkbox]").change(function () {
	  		arrayParam = new Array();
	  		$("input:checkbox[name=oneorhalf]:checked").each(function(){
				arrayParam.push($(this).val());
			});
	  		var tmpArr = [];
	  		for(var i=0; i<eventList.length; i++){
	  			
	  	 		if(arrayParam.indexOf(eventList[i].oneorhalf) != -1){
	  				tmpArr.push(eventList[i]);
	  			} 
	  		
	  		}


 	  		$('#calendar').fullCalendar('removeEvents',function(event){
 	  			//공휴일만 삭제
 	  			if(event.className.length > 0){
 	  				return true;
 	  			}
 	  			return false;
 	  		});

	  		$('#calendar').fullCalendar('renderEvents',tmpArr);
	  		
	  	 });
		
		
		$("#dayoff_use_recode_tb").on("click","a",function(){
			var dayoffApply = {};
			dayoffApply.dayoff_no = $(this).attr("href"); 
			$.ajax({
				method : "post",
				dataType : "json",
				contentType : 'application/json;charset=UTF-8',
				url : "${pageContext.request.contextPath}/dayoff/dayoffApplyDetailList",
				data : JSON.stringify(dayoffApply),
				error : function() {
					alert("전송 실패");
				},
				success : function(server_result) {
					console.log(server_result);
					
					var applyVO = server_result;
					var documentVO = applyVO.document;
					var applyDetailList = applyVO.dayoff_apply_detail;
					var approvalList = documentVO.approval;
					console.log(approvalList);
					$("#approvalLineTb tbody td").empty();
					for(var i=0; i <approvalList.length; i++){
						$("#approvalLineTb tbody tr:eq(0) td").eq(i).text(approvalList[i].employee.employee_name);
						var stateTxt;
						if(approvalList[i].approval_state == 0){
							stateTxt= "";
						}else if(approvalList[i].approval_state == 1){
							$("#approvalLineTb tbody tr:eq(1) td").eq(i).html("<img src='${pageContext.request.contextPath}/resources/images/kimsClubSign.jpg' style='width:80px;height:80px;'></img>")
						}else if(approvalList[i].approval_state == 2){
							stateTxt= "반려";
						}
					}
					$("#document_date").text(documentVO.document_date);
					$("#document_state").text(documentVO.document_state);
					$("#user_name").text(applyVO.employee.employee_name);
					$("#applicant_name").text(documentVO.employee.employee_name);
					$("#department_name").text(applyVO.employee.department.department_name);
					$("#dayoff_name").text(applyVO.dayoff_kind.dayoff_name);
					$("#total_days").text(applyVO.total_days);
					var dateText ='';
					for(var i=0 ; i <applyDetailList.length; i++){
						var oneorhalf = applyDetailList[i].oneorhalf;
						if(oneorhalf == 0){
							oneorhalf = "일차";
						}else if(oneorhalf ==1){
							oneorhalf ="오전반차"
						}else if(oneorhalf == 2){
							oneorhalf = "오후반차"
						}
						dateText += applyDetailList[i].dayoff_day +"[" + oneorhalf +"]" + "<br>";
					}
					$("#dayoff_day").html(dateText);
					$(".modal-footer").empty();
					$(".modal-footer").append("<button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>")
					var approvalCnt =0;
					for(var i=1 ; i<approvalList.length; i++){
						if(approvalList[i].approval_state == 1 || approvalList[i].approval_state == 2 ){
							approvalCnt++;
						}
					}

					if(documentVO.document_state != '취소'){
						if(approvalCnt == 0){
							var btn = "<button type='button' class='btn btn-danger' id='approval_cancel''>기안 취소</button>";
							$("#applyDetailModal .modal-footer").prepend(btn);
						}	
					}
					
						
					
		 			/* if(documentVO.document_state.indexOf("완료") == -1){
						var btn = "<button type='button' class='btn btn-danger' id='approval_cancel''>기안 취소</button>";
						$("#applyDetailModal .modal-footer").append(btn);
					} */
					 
					$("#dayoff_reason").text(applyVO.dayoff_reason);
					$("#applyDetailModal").modal('show');	
				}
			});
			return false;
		});
				
			
		$("select").change(function(){
			var selectArr = $("select option:selected");
			
			var dayoffApply = {};
			dayoffApply.dayoff_kind = {};
			dayoffApply.dayoff_kind.dayoff_type_code = selectArr[0].value; 
			dayoffApply.document = {};
			dayoffApply.document.document_date = new Date().setFullYear(selectArr[1].value);
			$.ajax({
				method : "post",
				dataType : "json",
				contentType : 'application/json;charset=UTF-8',
				url : "${pageContext.request.contextPath}/dayoff/dayoffApplyList",
				data : JSON.stringify(dayoffApply),
				error : function() {
					alert("전송 실패");
				},
				success : function(server_result) {
					var applyList = server_result;
					console.log(applyList.length);
					var $table = $("#dayoff_use_recode_tb");
					$table.find("tbody").empty();
					for(var i=0;i <applyList.length;i++){
						var dayoffApply = applyList[i];
						var row = "<tr>";
						row += "<td>" + (applyList.length-i) +"</td>";
						row += "<td>" + dayoffApply.document.employee.employee_name +"</td>";
						row += "<td>" + dayoffApply.dayoff_kind.dayoff_name +"</td>";
						row += "<td>" + dayoffApply.total_days + "</td>"
						row += "<td>" + dayoffApply.start_date + "~" + dayoffApply.end_date + "</td>";
						row += "<td>" + dayoffApply.document.document_state  + "</td>";
						row += "<td> <a href='"+dayoffApply.dayoff_no+"'>상세</a></td>";
						row += "</tr>";
						$table.find("tbody").append(row);
					}
				} 
			});
		});
		
	});
</script>
<title>휴가현황</title>
</head>
<body>
	<jsp:useBean id="now" class="java.util.Date" /> 
	<fmt:formatDate var="year" value="${now}" pattern="yyyy" /> 
	
	<!-- 아래의 구조로 복사하시오 -->
	<!-- 전체 div-->
	<div id="wrapper">
		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>
		<!-- content div -->
		<div id="page-wrapper">
			<div class="row">
				<div class="col-sm-12">
					<h1 class="page-header">휴가현황</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" id="myTab">
						<li class="active"><a href="#tab01" data-toggle="tab">내 휴가</a></li>
						<li><a href="#tab02" data-toggle="tab">휴가 캘랜더 </a></li>
					<!-- 	<li><a href="#tab03" data-toggle="tab">휴가 신청 관리</a></li> -->
					</ul>
					<!-- Tab panes -->
					<div class="tab-content">
						<div class="tab-pane fade in active" id="tab01">
							<div class="dayoff-create-recode_div">
								<h3>휴가 생성 내역</h3>
								<table class="table" id="dayoff_create_recode_tb">
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
													<td>${creation.create_reason} / 최종일(${creation.real_day }) / 생성 관리자 사번 : ${creation.dayoff_generator}
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
							<div class="dayoff-use-recode-div">
								<h3>휴가 신청 내역</h3>
								<div class="form-group">
									<select name="dayoff_type_code">
										<option selected="selected" value="0">모든 휴가</option>
										<c:forEach items="${requestScope.kindsList}" var="dayoffKind">
											<option value="${dayoffKind.dayoff_type_code}">${dayoffKind.dayoff_name }</option>
										</c:forEach>
									</select>
									<select name="document_write_date">
										<option selected="selected">${year }</option>
										<option>${year -1}</option>
										<option>${year -2}</option>
										<option>${year -3}</option>
										<option>${year -4}</option>
									</select>
								</div>

								<table class="table" id="dayoff_use_recode_tb">
									<thead>
										<tr>
											<th>번호</th>
											<th>신청자</th>
											<th>휴가 종류</th>
											<th>일수</th>
											<th>기간</th>
											<th>상태</th>
											<th>상세보기</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${requestScope.applyList}" var="dayoffApply" varStatus="st">
											<tr>
												<td>${fn:length(requestScope.applyList) - st.index}</td>
												<td>${dayoffApply.document.employee.employee_name}</td>
												<td>${dayoffApply.dayoff_kind.dayoff_name}</td>
												<td>${dayoffApply.total_days }</td>
												<td><fmt:formatDate value="${dayoffApply.start_date}" pattern="yyyy.MM.dd" /> ~ <fmt:formatDate value="${dayoffApply.end_date}" pattern="yyyy.MM.dd" /></td>
												<td>${dayoffApply.document.document_state }</td>
												<td><a href="${dayoffApply.dayoff_no }">상세</a></td>
												
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							
						</div>
						<div class="tab-pane fade" id="tab02">
							<div>
								<span>부서:<a id="tree-btn">모든 조직</a></span>
								<input type="checkbox" name="oneorhalf" value="0" checked="checked">일차
							 	<input type="checkbox" name="oneorhalf" value="1" checked="checked">오전반차
							 	<input type="checkbox" name="oneorhalf" value="2" checked="checked">오후반자
							</div>
							<div id="calendar" class="calendar col-lg-12"></div>
						</div>
		<%-- 				<div class="tab-pane fade" id="tab03">
							<div>
								<table>
									<caption>휴가 신청 내역</caption>
									<colgroup>
										<col width="7%">
										<col width="12%">
										<col width="12%">
										<col width="10%">
										<col width="12%">
										<col width="12%">
										<col width="12%">
										<col width="12%">
									</colgroup>
									<thead>
										<tr>
											<th scope="row">번호</th>
											<th scope="row">신청자</th>
											<th scope="row">휴가 종류</th>
											<th scope="row">일수</th>
											<th scope="row">기간</th>
											<th scope="row">상태</th>
											<th scope="row">상세</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td>김준기</td>
											<td>연차</td>
											<td>1</td>
											<td>
												<p>2018.01.02 ~ 2018.01.02</p>
											</td>
											<td>결재 완료</td>
											<td>
												<button>상세</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div> --%>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="applyDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">휴가신청 상세</h4>
				</div>
				<div class="modal-body">
						<div class="container-fluid">
							<div class="row">
								<div class="col-lg-12">
									<table class="table table-bordered no-footer" id="approvalLineTb">
										<colgroup>
											<col width="16%"></col>
											<col width="16%"></col>
											<col width="16%"></col>
											<col width="16%"></col>
											<col width="16%"></col>
											<col width="16%"></col>
										</colgroup>
										<thead>
											<tr>
												<th colspan="6">결재 진행도</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
												<td></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12">
									<table class="table table-bordered no-footer">
										<colgroup>
											<col width="20%">
											<col width="30%">
											<col width="20%">
											<col width="30%">
										</colgroup>
										<tbody>
											<tr>
												<th>신청일시</th>
												<td id="document_date"></td>
												<th>상태</th>
												<td id="document_state"></td>
											</tr>
											<tr>
												<th>사용자</th>
												<td id="user_name"></td>
												<th>신청자</th>
												<td id="applicant_name"></td>
											</tr>
											<tr>
												<th>소속</th>
												<td colspan="3" id="department_name"></td>
											</tr>
											<tr>
												<th>종류</th>
												<td id="dayoff_name"></td>
												<th>일수</th>
												<td id="total_days"></td>
											</tr>
											<tr>
												<th>기간</th>
												<td colspan="3" id="dayoff_day"></td>
											</tr>
											<tr>
												<th>사유</th>
												<td colspan="3" id="dayoff_reason"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
				</div>
				<div class="modal-footer">
				</div>
			</div>
		</div>
	</div>
	
		<div class="modal fade" id="myDayoffCal" tabindex="-1" role="dialog" aria-labelledby="myModalCalLabel" aria-hidden="true">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalCalLabel"></h4>
				</div>
				<div class="modal-body">
						<div class="container-fluid">
							<div class="row">
								<div class="col-lg-12">
									<table id="myModalCalTable" class="table table-bordered no-footer">
										<thead>
											<tr>
												<th>시작일시</th>
												<th>종료일시</th>
											</tr>
										</thead>
										<tbody>
											<tr>
											
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
				</div>
				<div class="modal-footer">
				</div>
			</div>
		</div>
	</div>
	
	
	   <!-- 결재선 불러오기 modal -->
   <!-- 사용려는 곳에 버튼 만든뒤 id에 tree-btn만들기 -->
   <!-- value 0 : 부서만 1: 사원 포함 -->
   <jsp:include page="/WEB-INF/views/treeModal.jsp">
      <jsp:param value="0" name="load_type" />
      <jsp:param value="beforeClick" name="beforeClick" />
      <jsp:param value="beforeCheck" name="beforeCheck" />
   </jsp:include>
</body>
</html>