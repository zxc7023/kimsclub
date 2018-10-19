<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>일정</title>

  <script
    type="text/javascript"
    src="//code.jquery.com/jquery-2.2.4.js"
    
  ></script>

    <link rel="stylesheet" type="text/css" href="/css/result-light.css">

<link href="${pageContext.request.contextPath}/resources/css/fullcalendar.min.css" rel='stylesheet' />
      <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
      <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.42/css/bootstrap-datetimepicker.min.css">
      <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.15.1/moment-with-locales.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/fullcalendar.min.js"></script>
      <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
      <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.42/js/bootstrap-datetimepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/locale/ko.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/gcal.js'></script> 
<script>

  $(document).ready(function() {
      var date = new Date(); 
      var d = date.getDate(); 
      var m = date.getMonth(); 
      var y = date.getFullYear(); 

    $('#calendar').fullCalendar({
    	  customButtons: {
    		    myCustomButton: {
    		      text: '일정추가',
    		      click: function() {
    		        alert('clicked the custom button!');
    		      }
    		    }
    		  },
      header: {
        left: 'prev,next today myCustomButton',
        center: 'title',
        right: 'month,basicWeek,basicDay'
      },
      navLinks: true, // can click day/week names to navigate views
      editable: true,
      eventLimit: true, // allow "more" link when too many events
      weekNumbers : true,
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectHelper: true,
      googleCalendarApiKey : "AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE",
      eventSources : [
          // 대한민국의 공휴일
          {
                googleCalendarId : "ko.south_korea#holiday@group.v.calendar.google.com"
              , className : "koHolidays"
              , color : "#FF0000"
              , textColor : "#FFFFFF"
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
          start: '2018-03-12T10:30:00',
          end: '2018-03-12T12:30:00'
        },
        {
          title: 'Lunch',
          start: '2018-03-12T12:00:00'
        },
        {
          title: 'Meeting',
          start: '2018-03-12T14:30:00'
        },
        {
          title: 'Happy Hour',
          start: '2018-03-12T17:30:00'
        },
        {
          title: 'Dinner',
          start: '2018-03-12T20:00:00'
        },
        {
          title: 'Birthday Party',
          start: '2018-03-13T07:00:00'
        },
        {
            title: 'Birthday Party',
            start: '2018-10-13T07:00:00'
          },
        {
          title: 'Click for Google',
          url: 'http://google.com/',
          start: '2018-03-28'
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
      if (title) {
          var eventData = {
              title: title,
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
  
  .fc-sun {color:#e31b23}
.fc-sat {color:#007dc3}

</style>
</head>
<body>

<div id='calendar'></div>
<div id='datepicker'></div>

<div class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Create new event</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-12">
                        <label class="col-xs-4" for="title">Event title</label>
                        <input type="text" name="title" id="title" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12">
                        <label class="col-xs-4" for="starts-at">Starts at</label>
                        <input type="text" name="starts_at" id="starts-at" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-12">
                        <label class="col-xs-4" for="ends-at">Ends at</label>
                        <input type="text" name="ends_at" id="ends-at" />
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="save-event">Save changes</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
</html>