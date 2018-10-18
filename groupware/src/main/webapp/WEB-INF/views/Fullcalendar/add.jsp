<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="EUC-KR">
<title>일정</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css">
    <link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/toast/dist/tui-calendar.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/toast/css/default.css"></link>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/toast/css/icons.css"></link>
</head>
<body>
<div class="modal fade in" id="modal_calendar" tabindex="-1" role="dialog" aria-hidden="false" style="display: block;">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
     <h4 class="modal-title">Add Event </h4>
</div>
      <div class="modal-body">
         <form id="event_frm" class="form-horizontal">

<div class="form-group">
   <div class="form-group "><label class="control-label col-sm-3 " for="calendar_eventsubject">calendar_eventsubject</label><div class="col-sm-8"><input type="text" name="calendar_eventsubject" value="" id="calendar_eventsubject" placeholder="calendar_eventsubject" data-validation-required-message="Enter the calendar_eventsubject" class="form-control" required="">
</div></div>  </div>
  <div class="form-group">
  <div class="form-group "><label class="control-label col-sm-3 " for="calendar_eventbody">calendar_eventbody</label><div class="col-sm-8"><textarea name="calendar_eventbody" cols="40" rows="3" id="calendar_eventbody" placeholder="calendar_eventbody" data-validation-required-message="Enter the calendar_eventbody" class="form-control" required=""></textarea>
</div></div>
       </div>
      <div class="row">
      <div class="form-group "><label class="control-label col-sm-3 " for="lbl_disp_code">common_date</label><div class="col-sm-8"><input type="text" name="lbl_disp_code" value="" id="lbl_disp_code" placeholder="common_date" data-validation-required-message="Enter the common_date" class="mts_date form-control" data-format="DD-MM-YYYY" data-single-date-picker="true" data-show-dropdowns="true" required="">
</div></div>      <div class="control-label col-sm-3">
    <label for="start_date">Start Date</label>
    </div>
    <div class="col-sm-7">
    <input type="text" class="form-control hasDatepicker" id="event_start_date" placeholder="Start Date">
    </div>

  </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary" id="save_event">Save changes</button>
       </div>
      </div><!-- /.modal-content -->
   </div><!-- /.modal-dialog -->
 </div>

    <script>
    $(document).ready(function() {

        $('#calendar').fullCalendar({ 
            customButtons: {
                EventButton: {
                    text:'Add Event',
                    click:function(event, jsEvent, view){
                        $('#modal_calendar').modal('show');
                    }
                }
            },

            utc: true, 
            header: { 
                left: 'prev,next today EventButton', 
                center: 'title', 
                right: 'month,agendaWeek,agendaDay' 
            },   

            editable: true, 
            droppable: true, 
        });

        $('#event_start_date').datepicker();
        $('#save_event').click(function() {
            var subject =$('#calendar_eventsubject').val();
            var body =$('#calendar_eventbody').val();
            var start_date = $('#event_start_date').val();
            if($('#calendar_event_subject').val() =='') {
                alert('subject required'); return false;
            } else {
                $("#modal_calendar").modal('hide');
            }

            if($('#calendar_event_body').val() == '') {
                alert('Body required'); return false;
            } else {
                $("#modal_calendar").modal('hide');
            }

            if($('#event_start_date').val() == '') {
                alert('Start Date required'); return false;
            } else {
                $("#modal_calendar").modal('hide');
            }

            $.ajax({
                cache: false,
                type: "POST",
                url:"calendar/save_event",
                data :  {'subject' : subject,'body' : body,'start_date' : start_date},
                dataType: 'json',
                success: function(result){
                    if (result!=null){
                    }
                }
            });
        });
    });
    </script>
    <style>
    .datepicker
    {
        z-index:1151 !important;}

    </style>
</body>
</html>