<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>일정</title>
<!-- 모달 -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script> 
<script src="${pageContext.request.contextPath}/resources/js/moment.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/fullcalendar.min.css" rel='stylesheet' />
<link href="${pageContext.request.contextPath}/resources/css/fullcalendar.print.min.css" rel='stylesheet' media='print' />
<script src="${pageContext.request.contextPath}/resources/js/fullcalendar.min.js"></script>


<!--  달력-->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>



<!-- 모달 -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<!--풀캘린더 한국어  -->
<script src="${pageContext.request.contextPath}/resources/locale/ko.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/gcal.js'></script> 
<script>

  $(document).ready(function() {

    $('#calendar').fullCalendar({
    		  header: {
    	    	  left: 'title',
    				center: 'agendaDay,agendaWeek,month',
    				right: 'prev,next today myCustomButton'
    			},
    	    	  customButtons: {
    	    		    myCustomButton: {
    	    		      text: '일정추가',
    	    		      click: function() {

    	    		    	  $('.modal').modal('show');
    	 
    	    		      }
    	    		    }
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
           
      ],
      eventClick: function(event, element) {
          // Display the modal and set the values to the event values.
          $('.modal').modal('show');
          $('.modal').find('#title').val(event.title);
          $('.modal').find('#content').val(event.content);
          $('.modal').find('#starts-at').val(event.start);
          $('.modal').find('#ends-at').val(event.end);

      }
       
     	 
  	});
    $('#save-event').on('click', function() {
        var title = $('#title').val();
        if (title) {
            var eventData = {
           	  id : hello,
                title: title,
                content:content,
                start: $('#starts-at').val(),
                end: $('#ends-at').val()
            };
            $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
        }
        $('#calendar').fullCalendar('unselect');

        // Clear modal inputs
        $('.modal').find('input').val('');

        // hide modal
        $('.modal').modal('hide');
        
      });
      
    });
    	
</script>

<script>
$(function() {
      $("#starts-at").datepicker({
         /* dateFormat:'y/mm/dd',  */
          monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
          dayNamesMin:['일','월','화','수','목','금','토'],
          changeMonth:true, // 월변경가능
          changeYear:true,  // 년변경가능
          showMonthAfterYear:true, // 년 뒤에 월표시
          calendarWeeks: false,
          todayHighlight: true,
          autoclose: true,

                              
      });
      $("#ends-at").datepicker({
          /* dateFormat:'y/mm/dd',  */
           monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
           dayNamesMin:['일','월','화','수','목','금','토'],
           changeMonth:true, // 월변경가능
           changeYear:true,  // 년변경가능
           showMonthAfterYear:true, // 년 뒤에 월표시
           calendarWeeks: false,
           todayHighlight: true,
           autoclose: true,

                               
       });
     });
</script>

<style>


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
 <!--모든  -->
 <div class="container">
<!-- 버튼 -->
<!-- 	
	<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" >
	  Launch demo modal
	</button> -->

	<!-- 모달 팝업 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
		<h4 class="modal-title" id="myModalLabel">일정등록</h4>
	      </div>
	      <div class="modal-body"><!--내용  -->
			<div class="container">
		<div class="row">
			<div class="col-md-5 mx-auto">
				<div id="first">
					<div class="myform form ">
						<form action="" method="post" name="add">
							<div class="form-group">
								<label for="exampleInputEmail1">일정제목</label> <input type="text"
									name="title" class="form-control" id="title">
							</div>
							<!--시작날짜  -->
							<div class="form-group">
								<label for="exampleInputEmail1">시작날짜</label>
								<table>
	<tr>
		<td ><input type="text"class="form-control" id="starts-at"></td>
		<td><select type="text"  class="form-control" size="1">
    <option>오전 0:00</option><option>오전 0:30</option><option>오전 1:00</option><option>오전 1:30</option><option>오전 2:00</option>
    <option>오전 2:30</option><option>오전 3:00</option><option>오전 3:30</option><option>오전 4:00</option><option>오전 4:30</option>
    <option>오전 5:00</option><option>오전 5:30</option><option>오전 6:00</option><option>오전 6:30</option><option>오전 7:00</option>
    <option>오전 7:30</option><option>오전 8:00</option><option>오전 8:30</option><option>오전 9:00</option><option>오전 9:30</option>
    <option>오전 10:00</option><option>오전 10:30</option><option>오전 11:00</option><option>오전 11:30</option><option>오전 12:00</option>
    <option>오전 12:30</option><option>오후 1:00</option><option>오후 1:30</option><option>오후 2:00</option><option selected="selected">오후 2:30</option>
    <option>오후 3:00</option><option>오후 3:30</option><option>오후 4:00</option><option>오후 4:30</option><option>오후 5:00</option>
    <option>오후 5:30</option><option>오후 6:00</option><option>오후 6:30</option><option>오후 7:00</option><option>오후 7:30</option>
    <option>오후 8:00</option><option>오후 8:30</option><option>오후 9:00</option><option>오후 9:30</option><option>오후 10:00</option>
    <option>오후 10:30</option><option>오후 11:00</option><option>오후 11:30</option></select> </td>
	</tr>
	</table>

							<!--종료날짜  -->
							<div class="form-group">
								<label for="exampleInputEmail1">종료날짜</label>
								<table>
	<tr>
		<td ><input type="text"class="form-control" id="ends-at"></td>
		<td><select type="text"  class="form-control" size="1">
    <option>오전 0:00</option><option>오전 0:30</option><option>오전 1:00</option><option>오전 1:30</option><option>오전 2:00</option>
    <option>오전 2:30</option><option>오전 3:00</option><option>오전 3:30</option><option>오전 4:00</option><option>오전 4:30</option>
    <option>오전 5:00</option><option>오전 5:30</option><option>오전 6:00</option><option>오전 6:30</option><option>오전 7:00</option>
    <option>오전 7:30</option><option>오전 8:00</option><option>오전 8:30</option><option>오전 9:00</option><option>오전 9:30</option>
    <option>오전 10:00</option><option>오전 10:30</option><option>오전 11:00</option><option>오전 11:30</option><option>오전 12:00</option>
    <option>오전 12:30</option><option>오후 1:00</option><option>오후 1:30</option><option>오후 2:00</option><option selected="selected">오후 2:30</option>
    <option>오후 3:00</option><option>오후 3:30</option><option>오후 4:00</option><option>오후 4:30</option><option>오후 5:00</option>
    <option>오후 5:30</option><option>오후 6:00</option><option>오후 6:30</option><option>오후 7:00</option><option>오후 7:30</option>
    <option>오후 8:00</option><option>오후 8:30</option><option>오후 9:00</option><option>오후 9:30</option><option>오후 10:00</option>
    <option>오후 10:30</option><option>오후 11:00</option><option>오후 11:30</option></select> </td>
	</tr>
	</table>
						
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">일정내용</label>
								<textarea rows="5" cols="30" name="contents" id="content"
									class="form-control"></textarea>
							</div>
							<!--  -->
							
<!-- 							<div class="col-md-12 text-center ">

							<button class=" btn btn-block mybtn tx-tfm"data-dismiss="modal">취소</button>
								<button type="submit" class=" btn btn-block mybtn btn-primary tx-tfm">저장</button>
							</div> -->

						</form>

					</div>
				</div>

			</div>
		</div>
	</div>
	      </div>
	      <div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		<button type="button" class="btn btn-primary" id="save-event">저장</button>
	      </div>
	    </div>
	  </div>
	</div>

</div>

  
 
</body>
</html>