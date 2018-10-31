<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>일정</title>

    <link href='${pageContext.request.contextPath}/resources/full/css/vendor/bootstrap.min.css' rel='stylesheet' />
    <link href='${pageContext.request.contextPath}/resources/full/css/vendor/fullcalendar.css' rel='stylesheet' />
    <link href='${pageContext.request.contextPath}/resources/full/css/style.css' rel='stylesheet' />
    <script src='${pageContext.request.contextPath}/resources/full/js/vendor/jquery.min.js'></script>
    <script src='${pageContext.request.contextPath}/resources/full/js/vendor/moment.min.js'></script>
    <script src='${pageContext.request.contextPath}/resources/full/js/vendor/bootstrap.min.js'></script>
    
	<script src="${pageContext.request.contextPath}/resources/js/fullcalendar.js"></script>
	<%-- <script src='${pageContext.request.contextPath}/resources/full/js/vendor/fullcalendar.js'></script>  --%>
	
    <script src='${pageContext.request.contextPath}/resources/full/js/events.js'></script>
    <script src='${pageContext.request.contextPath}/resources/full/js/calendar.js'></script>
	<script src="${pageContext.request.contextPath}/resources/locale/ko.js"></script>

	<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/gcal.js'></script> 

	<!--  달력-->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" />
	<script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>
</head>
<script>
$(function() {
      $("#starts-at").datepicker({
          dateFormat:'yy-mm-dd', 
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
           dateFormat:'yy-mm-dd',
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
<body>
 <nav class="navbar navbar-default">
        <div class="container-fluid">
            <p class="navbar-brand" id="todaysDate"></p>
        </div>
    </nav>

    <div class="container-fluid row">
         <div id='calendar1' class='calendar col-md-2 -ms-overflow-style: none;'>
          <label class="form-control-label">공유 캘린더</label> <input type="button" value="만들기" style="position: absolute; right: 0;"> </div> 
        <div id='calendar2' class='calendar col-md-10'></div>
    </div>

    <div class="modal fade" id="newEvent" role="dialog" aria-labelledby="eventFormLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="newEvent">일정등록</h4>
                </div>
                <form>
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-control-label">제목</label>
                            <input type="text" class="form-control" id="title">
                            <!--t수정  -->
                            <label class="form-control-label">내용</label>
                            <textarea rows="5" cols="30" id="content"class="form-control"></textarea>
                            <label class="form-control-label">색상</label>                                                        
                            <select name="color" id="color" class="form-control">
								<option value="#f27d4a" style="background-color: #f27d4a">주황</option>
								<option value="#e0305a"style="background-color: #e0305a; ">빨강</option>
								<option value="#feeb5b" style="background-color: #feeb5b;">노랑</option>
								<option value="#008bca" style="background-color: #008bca;"selected="selected">파란</option>								
							</select> 
							<label class="form-control-label">시작날짜</label>
                       		<input type="text"class="form-control" id="starts-at">
                            <label class="form-control-label">종료날짜</label> 
                            <input type="text"class="form-control" id="ends-at">
                            <!--수정끝  -->
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-success" id="submit">저장</button>
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
                    <h4 class="modal-title" id="editEvent">일정 내용</h4>
                </div>
                <form>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="title" class="form-control-label">제목</label>
                            <input type="text" class="form-control" id="editTitle">
                            <!--t수정  -->
                            <label class="form-control-label">내용</label>
                            <textarea rows="5" cols="30" id="content2"class="form-control"></textarea>
 							<label class="form-control-label">색상</label>                                                        
                            <select name="color" id="color2" class="form-control">
								<option value="#f27d4a" style="background-color: #f27d4a">주황</option>
								<option value="#e0305a"style="background-color: #e0305a; ">빨강</option>
								<option value="#feeb5b" style="background-color: #feeb5b;">노랑</option>
								<option value="#008bca" style="background-color: #008bca;"selected="selected">파란</option>								
							</select> 
							<label class="form-control-label">시작날짜</label>
                       		<input type="text"class="form-control" id="starts-at2">
                            <label class="form-control-label">종료날짜</label> 
                            <input type="text"class="form-control" id="ends-at2">
                            <!--수정끝  -->
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger left" id="delete">삭제</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-success" id="update">수정</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
 
  
 
</body>
</html>