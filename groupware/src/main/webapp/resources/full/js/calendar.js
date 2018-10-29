$(function() {
  loadEvents();
  showTodaysDate();
  initializeCalendar();
  getCalendars();
  initializeRightCalendar();
  initializeLeftCalendar();
  disableEnter();
});

/* --------------------------initialize calendar-------------------------- */
var initializeCalendar = function() {
  $('.calendar').fullCalendar({
      editable: true,
/*      defaultDate: '2016-10-12',*/
      eventLimit: true, // allow "more" link when too many events
      // create events
      events: events(),
      googleCalendarApiKey : "AIzaSyCDfUSkgM9JFdDtehs-JcJD9tVgPtzmUtQ",
      eventSources : [
          // 대한민국의 공휴일
      {
         googleCalendarId : "qansohiecib58ga9k1bmppvt5oi65b1q@import.calendar.google.com",
         className : "Holidays",
         color : "#FFFFFF",
         textColor : "#FF0000",
      }],
      defaultTimedEventDuration: '00:30:00',
      forceEventDuration: true,
      eventBackgroundColor: '#337ab7',
      editable: false,
      height: screen.height - 160
    });
}

/*--------------------------calendar 변수--------------------------*/
var getCalendars = function() {
  $cal = $('.calendar');
  $cal1 = $('#calendar1');
  $cal2 = $('#calendar2');
}

/* ------------------- cal2 (right pane)------------------- */
var initializeRightCalendar = function()  {
  $cal2.fullCalendar('changeView', 'agendaDay');
  $cal2.fullCalendar('option', {
    slotEventOverlap: false,
    allDaySlot: false,
    header: {
      right: 'prev,next today'
    },
    selectable: true,
    selectHelper: true,
    select: function(start, end) {
        newEvent(start);
    },
    eventClick: function(calEvent, jsEvent, view) {
        editEvent(calEvent);
    },
  });
}

/* ------------------- cal1 (left pane)------------------- */
var initializeLeftCalendar = function() {
  $cal1.fullCalendar('option', {
      header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek'
      },
      navLinks: false,
      dayClick: function(date) {
          cal2GoTo(date);
      },
      eventClick: function(calEvent) {
          cal2GoTo(calEvent.start);
      }
  });
}

/* -------------------moves right pane to date------------------- */
var cal2GoTo = function(date) {
  $cal2.fullCalendar('gotoDate', date);
}


var loadEvents = function() {
  $.getScript("/resources/full/js/events.js", function(){
  });
}


var newEvent = function(start) {
	/* $('input#title').val(""); */
	$('#newEvent').modal('show');
	$('#submit').unbind();
	$('#submit').on('click', function() {
		alert('펴라 ');
		var title = $('input#title');
		var content = $('#content');
		if (title) {
			var eventData = {
				title : title.val(),
				content : content.val(),
				start : start

			};
			$cal.fullCalendar('renderEvent', eventData, true);
			$('#newEvent').modal('hide');
		} else {
			alert("제목을 입력해주세요.")
		}
		title.val("");
		content.val("");
	});
}

var editEvent = function(calEvent) {
	alert('이벤트 수정');
  $('input#editTitle').val(calEvent.title);
  $('#content2').val(calEvent.content);
  $('#editEvent').modal('show');
  if(calEvent.content !== 'undefined'){
	  alert('없다');
  }else{
	  alert("있다");
  }
  $('#update').unbind();
  $('#update').on('click', function() {
    var title = $('input#editTitle').val();
    $('#editEvent').modal('hide');
    var eventData;
    if (title) {
      calEvent.title = title
      $cal.fullCalendar('updateEvent', calEvent);
    } else {
    alert("제목을 입력해주세요.")
    }
  });
  $('#delete').on('click', function() {
    $('#delete').unbind();
    if (calEvent._id.includes("_fc")){
      $cal1.fullCalendar('removeEvents', [getCal1Id(calEvent._id)]);
      $cal2.fullCalendar('removeEvents', [calEvent._id]);
    } else {
      $cal.fullCalendar('removeEvents', [calEvent._id]);
    }
    $('#editEvent').modal('hide');
  });
}

/* --------------------------load date in navbar-------------------------- */
var showTodaysDate = function() {
  n =  new Date();
  y = n.getFullYear();
  m = n.getMonth() + 1;
  d = n.getDate();
  $("#todaysDate").html("Today is " + y + "/" + m + "/" + d);
};


var getCal1Id = function(cal2Id) {
  var num = cal2Id.replace('_fc', '') - 1;
  var id = "_fc" + num;
  return id;
}

var disableEnter = function() {
  $('body').bind("keypress", function(e) {
      if (e.keyCode == 13) {
          e.preventDefault();
          return false;
      }
  });
}
