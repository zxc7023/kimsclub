<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>일정</title>


<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script> 
<script src="${pageContext.request.contextPath}/resources/js/moment.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/fullcalendar.min.css" rel='stylesheet' />

<link href="${pageContext.request.contextPath}/resources/css/fullcalendar.print.min.css" rel='stylesheet' media='print' />
<script src="${pageContext.request.contextPath}/resources/js/fullcalendar.min.js"></script>


<!--  달력-->

<!-- 모달 -->


<!--풀캘린더 한국어  -->
<script src="${pageContext.request.contextPath}/resources/locale/ko.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/gcal.js'></script> 
<script>

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
    	
</script>

<style>

   body {
    margin: 40px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 900px;
    margin: 0 auto;
  } 
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
 
  
 
</body>
</html>