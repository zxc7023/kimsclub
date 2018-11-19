<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html >
<html>
<head>
<!-- header 및 navigation을 불러오기 위해서 사용해야하는 자원들 아래 다 복사해서 붙여넣기 하세요. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap Core CSS -->

<link href="${pageContext.request.contextPath}/resources/css/board/board.css" rel="stylesheet">

<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Core CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="https://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/js/sb-admin-2.js"></script>
<style type="text/css">
.detailLink{
	display: inline-block; 
	width: 800px; 
	white-space: nowrap; 
	overflow: hidden; 
	text-overflow: ellipsis;
}

</style>
<script type="text/javascript">
	$(document).ready(function() {
		
	//검색 버튼 클릭시
		$("#searchBtn").click(function(){
			$("#search").submit();
			var keyWord = $("#keyword").val();
		});
		
	//ajax내 배열 사용하기위한 설정
		jQuery.ajaxSettings.traditional = true;
		
	//쪽지 쓰기 버튼 클릭시	
		$("#writeBtn").click(function(){
			location.href = "messageWrite";
		});
		
	//버튼(보관,삭제) 클릭시
		$(".btn-form").click(function(){
			var checkArr = [];
			
			$(".check:checked").each(function(){
				checkArr.push($(this).val());
			});
						
	//보관 버튼 클릭
			if($(this).val()=='keep'){
				//쪽지를 선택하고 보관 버튼을 클릭했을때
				if(checkArr.length>0){
					var result = confirm("쪽지를 보관했습니다.");
					if(result){
						$.ajax({
							method : "POST",
							url : "${pageContext.request.contextPath}/keepMessage",
							data : {"message_no" : checkArr
									,"box" : '${map.box}' },
							error : function() {
								alert("보관실패");
							},
							success : function(data) {
								location.href = "messageList?box=${map.box}"
								}
							});
						}
					}
				//쪽지를 선택하지 않고 보관 버튼을 클릭했을때
				else{
					alert("보관하실 쪽지를 선택하세요");
				}
			}//keep end
			
	//삭제 버튼을 클릭
			else{
				if(checkArr.length>0){
					var result = confirm("쪽지를 삭제하시겠습니까?");
					if(result){
						$.ajax({
							method : "POST",
							url : "${pageContext.request.contextPath}/deleteMessage",
							data : {"message_no" : checkArr,
									"box" : "${map.box}"
									},
							error : function() {
								alert("보관실패");
							},
							success : function(data) {
								location.href = "messageList?box=${map.box}"
								}
							});
						}
					}
				//쪽지를 선택하지 않고 보관 버튼을 클릭했을때
				else{
					alert("삭제하실 쪽지를 선택하세요");
				}
				
			}//delete end
			
		});
		
	//보낸 쪽지
		if('${map.box}' =='outBox'){
			$(".page-header").text('보낸쪽지');
			$("title").text('보낸쪽지');
			$("#senderAndreceiver").text('받는사람');
			$(".panel-heading").text('전체쪽지[${map.count}]');
		}
	//받은 쪽지
		else if('${map.box}' =='inBox'){
			$(".page-header").text('받은쪽지');
			$("title").text('받은쪽지');
			$("#senderAndreceiver").text('보낸사람');
			$(".panel-heading").text('전체쪽지[${map.unReadMsgCnt} / ${map.count}]');
		}
	//내게쓴 쪽지
		else if('${map.box}'=='myBox' ){
			$("#keepBtn").hide();
			$(".page-header").text('내게쓴쪽지');
			$("title").text('내게쓴쪽지');
			$("#senderAndreceiver").text('보낸사람');
			$(".panel-heading").text('전체쪽지[${map.count}]');
		}
	//보관 쪽지
		else{
			$("#keepBtn").hide();
			$(".page-header").text('쪽지보관');
			$("title").text('쪽지보관');
			$("#senderAndreceiver").text('보낸사람/받은사람');
			$(".panel-heading").text('전체쪽지[${map.count}]');
		}
		
	//쪽지 상세보기 링크 클릭
		$(".detailLink").click(function(){
			$(this).parents("td").find(".messageDetail").submit();
		});
		
	//모든 체크박스 선택 함수
		$('.checkAll').click(function() {
			$('.check').prop('checked', this.checked);
		});

		
	//쪽지 레코드 갯수 설정
		$(".selectPageScale").change(function(){
			location.href="messageList?box=${map.box}&page_scale="+$(this).val();
		});
		
		
	});
</script>
<title>Insert title here</title>
</head>
<body>


<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
             <!-- 쪽지 전체 갯수  -->
             
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">

                            <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                            
	        <!-- 쪽지 레코드 갯수 선택 --> 
	                            <div class="row">
	                            	<div class="col-sm-6">
	                            		<div class="dataTables_length" id="dataTables-example_length">
		                            		<label>Show 
		                            			<select name="dataTables-example_length" aria-controls="dataTables-example" class="form-control input-sm selectPageScale">
			                            			<option value="10" 
			                            				<c:if test="${map.messagePager.page_scale==10}"> selected </c:if> >10</option>
			                            			<option value="15" 
			                            				<c:if test="${map.messagePager.page_scale==15}"> selected </c:if> >15</option>
			                            			<option value="20" 
			                            				<c:if test="${map.messagePager.page_scale==20}"> selected </c:if> >20</option>
			                            			<option value="25" 
			                            				<c:if test="${map.messagePager.page_scale==25}"> selected </c:if> >25</option>
		                            			</select> entries
		                            		</label>
	                            		</div>
	                            	</div>
	         <!-- 쪽지 검색  -->                   	
	                            	<div class="col-sm-6">
		                            	<div id="dataTables-example_filter" class="form-group input-group dataTables_filter">
		                            		<form action="messageList" method="get" id="search" >
		                            		<label>
			                            		<select name="searchOption" aria-controls="dataTables-example" class="form-control input-sm">
			                            			<option value="all" <c:out value="${map.searchOption=='all'?'selected':''}"/>>내용+이름</option>
													<option value="message_contents" <c:out value="${map.searchOption=='message_contents'?'selected':''}"/> >내용</option>
													<option value="employee_name" <c:out value="${map.searchOption=='employee_name'?'selected':''}"/> >이름</option>
			                            		</select>
		                            				<input id="keyword" type="search" name="keyword" class="form-control input-sm" value="${map.keyword}" aria-controls="dataTables-example"> 
													<input type="hidden" name="box" value="${map.box}">
													<input type="hidden" name="page_scale" value="${map.messagePager.page_scale }">
														<span class="input-group-btn" >
															<button id="searchBtn" class="btn btn-primary btn-sm" type="button" >
																<i class="fa fa-search"></i>
															</button>
														</span>
											</label>
											</form>
		                            	</div>
	                            	</div>
	                            </div>
                            
	         <!-- 쪽지 목록 테이블  -->
	                            <div class="row">
		                            <div class="col-sm-12">
		                            	<div class="table-responsive table-bordered">
										<table class="table table-hover" id="dataTables-example">
			                                <thead>
			                                    <tr>
			                                        <th><input type="checkbox" class="checkAll"></th>
			                                        <th id="senderAndreceiver"></th>
			                                        <th>내용</th>
			                                        <th>날짜</th>
			                                    </tr>
			                                </thead>
			                                
			                                <tbody>
				                                <c:forEach var="list" items="${map.list}" >
					                                <tr class="odd gradeA">
					                                    <td><input type="checkbox" class="check" value="${list.message_no}"></td>
						                                    <c:choose>
						                                    	<c:when test="${map.box != 'keepBox'}">
						                                    		<td>${list.message_receiver_name}</td>
						                                    	</c:when>
						                                    	<c:otherwise>
						                                    	<c:choose>
						                                    		<c:when test="${map.employee_no == list.message_sender_no}">
						                                    			<td>${list.message_receiver_name} [보낸쪽지]</td>
						                                    		</c:when>
						                                    		<c:otherwise>
						                                    			<td>${list.message_receiver_name} [받은쪽지]</td>
						                                    		</c:otherwise>
						                                    	</c:choose>
						                                    	</c:otherwise>
						                                    	
						                                    </c:choose>
					                                    <td>
					                                    <c:choose>
					                                    	<c:when test="${map.box == 'inBox'}">
																<c:choose>
							                                    	<c:when test="${list.message_read_state =='N'}">
									                            		<a href="#" class="detailLink" >${list.message_contents} </a>
									                            	</c:when>
									                            	<c:otherwise>
									                            		<a href="#" class="detailLink text-muted" >${list.message_contents} </a>
									                            	</c:otherwise>
								                            	</c:choose>
					                                    	</c:when>
					                                    	<c:otherwise>
					                                    			<a href="#" class="detailLink text-muted" >${list.message_contents} </a>
							                            	</c:otherwise>	
														</c:choose>
					                                    		<form action="messageDetail" method="post" class="messageDetail" >
								                                    <input type="hidden" name="message_no" value="${list.message_no}">
								                                    <input type="hidden" name="searchOption" value="${map.searchOption}">
								                                    <input type="hidden" name="keyword" value="${map.keyword}">
								                                    <input type="hidden" name="curPage" value="${map.messagePager.curPage}">
								                                    <input type="hidden" name="page_scale" value="${map.messagePager.page_scale}">
								                                    <input type="hidden" name="box" value="${map.box}">
							                                  	</form>
					                                    </td>
					                                    <td>
					                                    ${list.message_date}
					                                    </td>
					                                </tr>
				                                </c:forEach>
			                                </tbody>
			                            </table>
			                            </div>
		                            </div>
	                            </div>
                            </div>
                            
              <!-- 페이징 처리 -->
                            <div style="text-align: center;" class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
				                            <ul class="pagination">	      
				                                                  
				                            	<li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous">
													<a href="messageList?box=${map.box}&curPage=${map.messagePager.prevPage}&page_scale=${map.messagePager.page_scale}&searchOption=${map.searchOption}&keyword=${map.keyword}">Previous</a>
				                            	</li>
				                            	
						                       	<li class="paginate_button " aria-controls="dataTables-example" tabindex="0">
						                           	<c:forEach var="num" begin="${map.messagePager.blockBegin}" end="${map.messagePager.blockEnd }"  >	
						                           		<c:choose>
						                           			<c:when test="${num == map.messagePager.curPage}">
						                           				<span style="color:orange">${num}</span>
						                           			</c:when>
						                           			<c:otherwise>
																<a href="messageList?box=${map.box}&curPage=${num}&page_scale=${map.messagePager.page_scale}&searchOption=${map.searchOption}&keyword=${map.keyword}">${num}</a>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</li>
				                            		                            
				                            	<li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
				                            		<c:if test="${map.messagePager.curBlock <= map.messagePager.totBlock}">
														<a href="messageList?box=${map.box}&curPage=${map.messagePager.nextPage}&page_scale=${map.messagePager.page_scale}&searchOption=${map.searchOption}&keyword=${map.keyword}">Next</a>
													</c:if>
				                            	</li>
				                            </ul>
			                        </div>	 
              <!-- 버튼(쪽지쓰기, 보관, 삭제) -->              	
                            </div>
                            <div class="panel-footer">
	                            <div class="row">
	                            	<div class="col-sm-12">
	                            		<label id="dataTables-example_filter">
						                	<button id="writeBtn" type="button" class="btn btn-primary"><i class="fa fa-envelope fa-fw"></i></button>
							            	<button id="keepBtn" type="button" class="btn btn-success btn-form" value="keep">보관</button>
							            	<button type="button" class="btn btn-danger btn-form" data-toggle="modal" data-target="#myModal" value="del">삭제</button>	
						            	</label>
					            	</div>
	                           </div>
                        	</div>
                        </div>
                    </div>
                </div>
            </div>
	</div>
</div>
</body>
</html>