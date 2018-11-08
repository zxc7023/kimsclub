$(function() {
  loadEvents();
  showTodaysDate();
  initializeCalendar();
  getCalendars();
  initializeRightCalendar();
  initializeLeftCalendar();
  disableEnter();
});

/* --------------------------공통적인 캘린더-------------------------- */
var initializeCalendar = function() {
  $('.calendar').fullCalendar({
      editable: true,
      eventLimit: true, 
      events: events, //이벤트 생성
      timeFormat: 'HH:mm',
      googleCalendarApiKey : "AIzaSyCDfUSkgM9JFdDtehs-JcJD9tVgPtzmUtQ",
      eventSources : [
          // 대한민국Holidays
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
    });
}

/*--------------------------calendar 이름--------------------------*/
var getCalendars = function() {
  $cal = $('.calendar');
  $cal1 = $('#calendar1');
  $cal2 = $('#calendar2');
}

/* -------------------(right pane)------------------- */
var initializeRightCalendar = function()  {
  $cal2.fullCalendar('changeView', 'month');
  $cal2.fullCalendar('option', {
    slotEventOverlap: false,
    allDaySlot: true,
    header: {
        left: 'today',
        center: 'prev title next',
        right: 'month,agendaWeek'
    },
    
    selectable: true,
    selectHelper: true,
    select: function() {
        newEvent();
    },
    eventClick: function(calEvent, jsEvent, view) {
        editEvent(calEvent);
    },
    height: screen.height - 300,
  });
}


/* -------------------manage cal1 (left pane)------------------- */
var initializeLeftCalendar = function() {

  $cal1.fullCalendar('option', {
      header: {
          left: '',
          center: 'prevYear,prev,today,next,nextYear',
          right: ''
      },
      navLinks: false,
      dayClick: function(date) {
          cal2GoTo(date);

      },
     /* eventClick: function(calEvent) {
          cal2GoTo(calEvent.start);
          cal2GoTo(calEvent.end);
      },*/
      height: screen.height - 730,
  });
}

/* -------------------moves right pane to date------------------- */
var cal2GoTo = function(date) {
  $cal2.fullCalendar('gotoDate', date);
}


var loadEvents = function() {
/*  $.getScript("/resources/full/js/events.js", function(){
  });*/
  
  $.ajax({
		method : "get",
		contentType : 'application/json;charset=UTF-8',
		url : "/groupware/selectEvent",
		async:false,
		error : function() {
			alert('캘린더조회실패');
		},
		success : function(data){
			events = data;
		}	
	});
  
}


var newEvent = function() {

  $('input#title').val("");
  $('#content').val("");
  $('#starts_at').val("");
  $('#ends_at').val("");
  $('#newEvent').modal('show');
  $('#submit').unbind();
  $('#submit').on('click', function() {
  var title = $('input#title').val();
	var content = $('#content').val();
	var color = $('#color').val();
	var start= $('#starts_at').val();
	var end= $('#ends_at').val();		
	var event_no;
	
		$.ajax({ /*이벤트아이디 받기*/
    	method : "get",
		url : "/groupware/selectCalSeq",
		async:false,
		error : function() {
			alert('전송 실패');
		},
		success : function(data){
			event_no = data.event_no;
			/*alert(data.event_no);*/
			alert("시퀀스번호 받기 성공");
		}	
    });	
		   
  if (title) {
    var eventData = {
        title: title,
		content : content,
		color: color,
		start: start,
		end: end,
		id: event_no

    };    
    /*$cal2.fullCalendar('renderEvent', eventData, true);*/
    
    $.ajax({
	method : "post",
	data : JSON.stringify(eventData),
	dataType : "json",
	contentType : 'application/json;charset=UTF-8',
	url : "/groupware/addCalendar",
	error : function() {
		alert('전송 실패:데이터 저장');
	},
	success : function(data){
		alert(data.result);
		$cal2.fullCalendar('renderEvent', eventData, true);
	}	
});
    $('#newEvent').modal('hide'); 
    }
  else {
    alert("제목을 입력해주세요.")
  }
  });
}

var editEvent = function(calEvent) {
  $('input#editTitle').val(calEvent.title);
  $('#content2').val(calEvent.content);
  $('#starts_at2').val(moment(calEvent.start).format('YYYY/MM/DD HH:mm '));
  $('#ends_at2').val(moment(calEvent.end).format('YYYY/MM/DD HH:mm '));
  
  $('#editEvent').modal('show');
  $('#update').unbind();
  $('#update').on('click', function() {
    var title = $('input#editTitle').val();
    var content = $('#content2').val();
    var color = $('#color2').val();
    var start = $('#starts_at2').val();
    var end = $('#ends_at2').val();
    var event_no
    $('#editEvent').modal('hide');
    var eventData;
    if (title) {
      calEvent.title = title,
      calEvent.color = color,
      calEvent.content = content,
      calEvent.start = start,
      calEvent.end = end
      $cal.fullCalendar('updateEvent', calEvent);
    } else {
    alert("제목을 입력해주세요.")
    }
  });
  $('#delete').on('click', function() {
    $('#delete').unbind();
    if (calEvent._id.includes("_fc")){
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
  $("#todaysDate").html("Today is " + y + "/" + m + "/" + d+"   킵스클럽");
};


var disableEnter = function() {
  $('body').bind("keypress", function(e) {
      if (e.keyCode == 13) {
          e.preventDefault();
          return false;
      }
  });
}