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
	
	
	
  $('#calendar2').fullCalendar({
      editable: true,
      eventLimit: true,      
      navLinks: true,
      navLinkDayClick: function() {
    	  newEvent();
    	  },
      events: events, //이벤트 생성
      timeFormat: 'HH:mm',
      googleCalendarApiKey : "AIzaSyCDfUSkgM9JFdDtehs-JcJD9tVgPtzmUtQ",
      eventSources : [
          // 대한민국Holidays
      {
         googleCalendarId : "qansohiecib58ga9k1bmppvt5oi65b1q@import.calendar.google.com",
         className : "Holidays",
         color : "#f8f8f8",
         textColor : "#FF0000",
      }
],
      defaultTimedEventDuration: '00:30:00',
      forceEventDuration: true,
      eventBackgroundColor: '#337ab7',
      editable: false,
      
    });
  
  
  $('#calendar1').fullCalendar({ 
	  /*eventLimit: true,*/
	  events: events,
	  eventAfterRender: function( event, element, view ){
		    // Enable for the 'month' view only.
		    if ( 'month' !== view.name ) {
		      return;
		    }

		    var a = moment( event.start, 'YYYY/MM/DD' ),
		      b = moment( event.end, 'YYYY/MM/DD' ),
		      duration = moment.duration( b.diff( a ) ),
		      row = element.closest( '.fc-row' ),
		      d = a.clone(), i, c;

		    var title = event.title;
		    if ( b.isValid() ) {
		      title += ' (' + $.fullCalendar.formatRange( a, b, 'MMM D YYYY' ) + ')';
		    }

		    // Add the event's "dot", styled with the appropriate background color.
		    for ( i = 0; i <= duration._data.days; i++ ) {
		      if ( 0 === 1 ) {
		        c = a;
		      } else {
		        d.add( 1, 'days' );
		        c = d;
		      }

		      row.find( '.fc-day[data-date="' + c.format( 'YYYY-MM-DD' ) + '"]' )
		        .append(
		          '<a href="#" class="fc-event-dot" onclick="return false;" ' +
		            'style="background-color: ' + event.backgroundColor + ';" ' +
		            'title="' + title + '"></a>'
		        );
		    }

		    // Here you can either completely remove the default element, or just
		    // hide it visually on screen.
		    element.remove();
		    //element.addClass( 'hidden' );
		  }
  });
  
  
/*	$("#index_submit").on('click', function(){
			 var radioVal = $('input[name="color"]:checked').val();
			 var nameVal = $('#shereTitle').val();
		$("#index_list").append (
				"<div class='.wrap-btn'><input type='checkbox'>"+nameVal+"</div>"			
				);
	});*/
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
    editable: true,
    allDaySlot: true,
    header: {
        left: 'today,myCustomButton',
        center: 'prev title next',
        right: 'month,agendaWeek'
    },
    customButtons: {
        myCustomButton: {
          text: '일정등록!',
          click: function() {
        	  newEvent();
          }
        }
      },
    selectable: false,
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
          left: 'prev',
          center: 'title',
          right: 'next'
      },
      navLinks: false,
      
      dayClick: function(date) {
          cal2GoTo(date);

      },
     /* eventClick: function(calEvent) {
          cal2GoTo(calEvent.start);
          cal2GoTo(calEvent.end);
      },*/
      height: screen.height - 740, //730
      
      
  });
}

/* -------------------moves right pane to date------------------- */
var cal2GoTo = function(date) {
  $cal2.fullCalendar('gotoDate', date);
}


var loadEvents = function(num, id, color, text) {
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
			scheduleChoice();
			
		}	
	});
  
  
  $('#category').on('click', function() {
	  $('#addcategory').modal('show');

  });
}

var scheduleChoice = function(num, id, color, text) {
	if($('.form-inputPop').eq(num).is(':checked')) {
		$('#calendar2').fullCalendar('addEventSource', { googleCalendarId : id,  color : color, textColor : text });

	  } else {
		  $('#calendar2').fullCalendar('removeEventSource', { googleCalendarId : id });
	  }


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
    $('#editEvent').modal('hide');
    var eventData;
    var event_no=calEvent.id ;
    alert(event_no);
    if (title) {
      calEvent.title = title,
      calEvent.color = color,
      calEvent.content = content,
      calEvent.start = start,
      calEvent.end = end,
      calEvent.id = event_no
      var editEventData = {};
      editEventData.id = calEvent.id;
      editEventData.title = calEvent.title;
      editEventData.color = calEvent.color;
      editEventData.content = calEvent.content;
      editEventData.start = calEvent.start;
      editEventData.end = calEvent.end;
      $cal.fullCalendar('updateEvent', calEvent);
      $.ajax({
    		method : "post",
    		data : JSON.stringify(editEventData),
    		dataType : "json",
    		contentType : 'application/json;charset=UTF-8',
    		url : "/groupware/editEvent",
    		error : function() {
    			alert('전송 실패:데이터 수정');
    		},
    		success : function(data){
    			alert('전송 성공:데이터 수정');
    			alert(data.result);
    		}	
    	});
      
    } else {
    alert("제목을 입력해주세요.")
    }
  });
  $('#delete').on('click', function() {
    $('#delete').unbind();
    alert(calEvent.id);
/*    if (calEvent.id){calEvent._id.includes("_fc")
      $cal2.fullCalendar('removeEvents', [calEvent.id]);
    } else {
      $cal.fullCalendar('removeEvents', [calEvent.id]);
    }*/
    var delEventData = {};
    delEventData.id = calEvent.id;
    $.ajax({
		method : "post",
		data : JSON.stringify(delEventData),
		dataType : "json",
		contentType : 'application/json;charset=UTF-8',
		url : "/groupware/deleteEvent",
		error : function() {
			alert('전송 실패:이벤트 삭제');
		},
		success : function(data){
			if(data>0){
				alert('삭제성공');
				$cal2.fullCalendar('removeEvents', [calEvent.id]);
			}else{
				alert('실패');
			}
						
		}	
	});
    
    $('#editEvent').modal('hide');
  });
}

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