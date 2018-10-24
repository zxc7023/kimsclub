<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>일정</title>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<%-- <link href="${pageContext.request.contextPath}/resources/css/materialFullCalendar.css" rel='stylesheet' /> --%>
 
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/moment.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/fullcalendar.min.css" rel='stylesheet' />
<link href="${pageContext.request.contextPath}/resources/css/fullcalendar.css" rel='stylesheet' />
<link href="${pageContext.request.contextPath}/resources/css/fullcalendar.print.min.css" rel='stylesheet' media='print' />
<script src="${pageContext.request.contextPath}/resources/js/fullcalendar.min.js"></script>

<!-- 모달 -->

<!--  -->
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
      googleCalendarApiKey : "AISyCDfUSkgM9JFdDtehs-JcJD9tVgPtzmUtQ",
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
      select: function(start, end) {
          // Display the modal.
          // You could fill in the start and end fields based on the parameters
          $('.modal').modal('show');

      },
      eventClick: function(event, element) {
          // Display the modal and set the values to the event values.
          $('.modal').modal('show');
          $('.modal').find('#title').val(event.title);
          $('.modal').find('#content').val(event.content);
          $('.modal').find('#starts-at').val(event.start);
          $('.modal').find('#ends-at').val(event.end);

      },
      editable: true,
      eventLimit: true // allow "more" link when too many events

  });

  // Bind the dates to datetimepicker.
  // You should pass the options you need
  $("#starts-at, #ends-at").datetimepicker();

  // Whenever the user clicks on the "save" button om the dialog
  $('#save-event').on('click', function() {
      var title = $('#title').val();
      alert(title);
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
  
  /* 삭제 */
  $('#delete-event').on('click', function() {
	 
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
  
  
     <nav class="navbar navbar-default">
        <div class="container-fluid">
            <p class="navbar-brand" id="todaysDate"></p>
        </div>
    </nav>

    <div class="container-fluid row">
        <div id='calendar1' class='calendar col-md-8'></div>
        <div id='calendar2' class='calendar col-md-4'></div>
    </div>

    <div class="modal fade" id="newEvent" role="dialog" aria-labelledby="eventFormLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="newEvent">New Apppointment</h4>
                </div>
                <form>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="title" class="form-control-label">Title</label>
                            <input type="text" class="form-control" id="title">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-success" id="submit">Create Event</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="editEvent" role="dialog" aria-labelledby="eventFormLabel" aria-hidden="true" data-persist="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
                    <h4 class="modal-title" id="editEvent">Update Apppointment</h4>
                </div>
                <form>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="title" class="form-control-label">Title</label>
                            <input type="text" class="form-control" id="editTitle">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger left" id="delete">Delete Event</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-success" id="update">Update Event</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>