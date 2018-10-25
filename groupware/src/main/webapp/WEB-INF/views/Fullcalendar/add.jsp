<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>일정 등록</title>
<!--부트스트램 css 날짜  -->
<link rel="stylesheet"href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>

<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap-datepicker.kr.js "></script>
<!-- 일정 -->
<script src="${pageContext.request.contextPath}/resources/js/moment.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/fullcalendar.min.css" rel='stylesheet' />
<link href="${pageContext.request.contextPath}/resources/css/fullcalendar.css" rel='stylesheet' />
<link href="${pageContext.request.contextPath}/resources/css/fullcalendar.print.min.css" rel='stylesheet' media='print' />
<script src="${pageContext.request.contextPath}/resources/js/fullcalendar.min.js"></script>
<!--풀캘린더 한국어  -->
<script src="${pageContext.request.contextPath}/resources/locale/ko.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/gcal.js'></script> 

<!--데이터타임  -->
<script type='text/javascript'>

$(document).ready(function() {

    $('#calendar').fullCalendar({
    		  header: {
    	    	  left: 'title',
    				center: 'agendaDay,agendaWeek,month',
    				right: 'prev,next today'
    			},
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      selectable: true,
      selectHelper: true,
      eventLimit: true, // allow "more" link when too many events
      googleCalendarApiKey : "AIzaSyCDfUSkgM9JFdDtehs-JcJD9tVgPtzmUtQ",
      eventSources : [
          // 대한민국의 공휴일
          {
                googleCalendarId : "qansohiecib58ga9k1bmppvt5oi65b1q@import.calendar.google.com"
              , className : "Holidays"
              , color : "#FFFFFF"
              , textColor : "#FF0000"          
          }],
      events: [
          {
              title: 'All Day Event',
              start: '2018-03-01'
            },
            {
              title: 'Long Event',
              start: '2018-03-07',
              end: '2018-03-10'
            },
            {
              id: 999,
              title: 'Repeating Event',
              start: '2018-03-09T16:00:00'
            },
            {
              id: 999,
              title: 'Repeating Event',
              start: '2018-03-16T16:00:00'
            },
            {
              title: 'Conference',
              start: '2018-03-11',
              end: '2018-03-13'
            },
            {
              title: 'Meeting',
              start: '2018-10-10T10:30:00',
              end: '2018-10-10T12:30:00'
            },
            {
              title: 'Lunch',
              start: '2018-10-12T12:00:00'
            },
            {
              title: 'Meeting',
              content: 'description for Click for Google',
              start: '2018-10-12T14:30:00'
              
            },
            {
              title: 'Happy Hour',
              start: '2018-10-12T17:30:00'
            },
            {
              title: 'Dinner',
              start: '2018-10-24T20:00:00'
            },
            {
              title: 'Birthday Party',
              start: '2018-10-24T10:30:00',
              end: '2018-10-24T12:30:00'
            }
           
      ]
    
     	 
  	});

      
    });




	$(function() {
		$('#input').datepicker({
			calendarWeeks : false,
			todayHighlight : true,
			autoclose : true,
			format : "yyyy/mm/dd",
			language : "kr"
		});

	});
	$(function() {
		$('#output').datepicker({
			calendarWeeks : false,
			todayHighlight : true,
			autoclose : true,
			format : "yyyy/mm/dd",
			language : "kr"
		});

	});
</script>

<style>

.fc-today .fc-day-number {
  background: #d9534f;
  color: white;
  font-weight: bold;
  width: 20px;
  border-radius: 50%;
  text-align: center;
  margin: 2px;
}
  
  .fc-sun {color:#e31b23}
.fc-sat {color:#007dc3}

</style>
</head>
<body>

 <div id='calendar'></div>





	<div class="container">
		<div class="row">
			<div class="col-md-5 mx-auto">
				<div id="first">
					<div class="myform form ">
						<div class="logo mb-3">
							<div class="col-md-12 text-center">
								<h1>일정등록</h1>
							</div>
						</div>
						<form action="" method="post" name="add">
							<div class="form-group">
								<label for="exampleInputEmail1">일정제목</label> <input type="text"
									name="title" class="form-control" id="title"
									aria-describedby="emailHelp">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">일정내용</label>
								<textarea rows="5" cols="30" name="contents" id="contents"
									class="form-control" aria-describedby="emailHelp"></textarea>
							</div>
							<!--시작날짜  -->
							<div class="form-group">
								<label for="exampleInputEmail1">시작날짜</label>
								<div class="input-group date" id="input">
									<input type="text" class="form-control"><span
										class="input-group-addon"><i
										class="glyphicon glyphicon-calendar"></i></span>
								<select type="text"  class="form-control" size="1">
    <option>am 0:00</option><option>am 0:30</option><option>am 1:00</option><option>am 1:30</option><option>am 2:00</option>
    <option>am 2:30</option><option>am 3:00</option><option>am 3:30</option><option>am 4:00</option><option>am 4:30</option>
    <option>am 5:00</option><option>am 5:30</option><option>am 6:00</option><option>am 6:30</option><option>am 7:00</option>
    <option>am 7:30</option><option>am 8:00</option><option>am 8:30</option><option>am 9:00</option><option>am 9:30</option>
    <option>am 10:00</option><option>am 10:30</option><option>am 11:00</option><option>am 11:30</option><option>am 12:00</option>
    <option>am 12:30</option><option>pm 1:00</option><option>pm 1:30</option><option>pm 2:00</option><option selected="selected">pm 2:30</option>
    <option>pm 3:00</option><option>pm 3:30</option><option>pm 4:00</option><option>pm 4:30</option><option>pm 5:00</option>
    <option>pm 5:30</option><option>pm 6:00</option><option>pm 6:30</option><option>pm 7:00</option><option>pm 07:30</option>
    <option>pm 8:00</option><option>pm 8:30</option><option>pm 9:00</option><option>pm 9:30</option><option>pm 10:00</option>
    <option>pm 10:30</option><option>pm 11:00</option><option>pm 11:30</option></select>
							</div></div>

							<!--종료날짜  -->
							<div class="form-group">
								<label for="exampleInputEmail1">종료날짜</label>
								<div class="input-group date" id="output">
									<input type="text" class="form-control"><span
										class="input-group-addon"><i
										class="glyphicon glyphicon-calendar"></i></span>
										<select type="text"  class="form-control" size="1">
    <option>am 0:00</option><option>am 0:30</option><option>am 1:00</option><option>am 1:30</option><option>am 2:00</option>
    <option>am 2:30</option><option>am 3:00</option><option>am 3:30</option><option>am 4:00</option><option>am 4:30</option>
    <option>am 5:00</option><option>am 5:30</option><option>am 6:00</option><option>am 6:30</option><option>am 7:00</option>
    <option>am 7:30</option><option>am 8:00</option><option>am 8:30</option><option>am 9:00</option><option>am 9:30</option>
    <option>am 10:00</option><option>am 10:30</option><option>am 11:00</option><option>am 11:30</option><option>am 12:00</option>
    <option>am 12:30</option><option>pm 1:00</option><option>pm 1:30</option><option>pm 2:00</option><option selected="selected">pm 2:30</option>
    <option>pm 3:00</option><option>pm 3:30</option><option>pm 4:00</option><option>pm 4:30</option><option>pm 5:00</option>
    <option>pm 5:30</option><option>pm 6:00</option><option>pm 6:30</option><option>pm 7:00</option><option>pm 07:30</option>
    <option>pm 8:00</option><option>pm 8:30</option><option>pm 9:00</option><option>pm 9:30</option><option>pm 10:00</option>
    <option>pm 10:30</option><option>pm 11:00</option><option>pm 11:30</option></select>
								</div>
							</div>
							<!--  -->
							
							<div class="col-md-12 text-center ">

								<button class=" btn btn-block mybtn tx-tfm">취소</button>
								<button type="submit" class=" btn btn-block mybtn btn-primary tx-tfm">저장</button>
							</div>

						</form>

					</div>
				</div>

			</div>
		</div>
	</div>

</body>
</html>