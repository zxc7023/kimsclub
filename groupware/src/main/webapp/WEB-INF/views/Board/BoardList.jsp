<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<script type="text/javascript">
	//검색 버튼 클릭시
	$(document).ready(function() {
		//boardType값 저장
		var boardType = '${map.board_type}';
		
		$("#searchBtn").click(function(){
			$("#search").submit();
		});
	//글쓰기 버튼 클릭시	
		$("#writeBtn").click(function(){
			location.href = "BoardWrite?boardType="+boardType;
		});
	
	//게시판 타입 heading
		if(boardType =='c'){
	  	  $(".panel-heading").text('커뮤니티');
	  	  $("title").text('커뮤니티');
		}
		else if(boardType=='n'){
		  $(".panel-heading").text('공지사항');
		  $("title").text('공지사항');
		}
	});
	
</script>
<title>게시판</title>
</head>
<body>
<div id="wrapper">

		<!-- header,navigation div -->
		<jsp:include page="/WEB-INF/views/navigation.jsp"></jsp:include>

		<!-- content div -->
		<div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">게시판</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        <!-- 게시판 타입명  -->
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">

                            <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                            
	                       		<!-- 게시글 검색 div -->
	                            <div class="row">
	                            	<div class="col-sm-6">
	                            		<div class="dataTables_length" id="dataTables-example_length">
		                            		<label>Show 
		                            			<select name="dataTables-example_length" aria-controls="dataTables-example" class="form-control input-sm">
			                            			<option value="10">10</option>
			                            			<option value="25">25</option>
			                            			<option value="50">50</option>
			                            			<option value="100">100</option>
		                            			</select> entries
		                            		</label>
	                            		</div>
	                            	</div>
	                            	
	                            	
	                            	<div class="col-sm-6">
		                            		<div id="dataTables-example_filter" class="form-group input-group dataTables_filter">
		                            		<form action="boardList" method="get" id="search" >
		                            		<label>
			                            		<select name="searchOption" aria-controls="dataTables-example" class="form-control input-sm">
			                            			<option value="all">제목+내용</option>
													<option value="employee_name">작성자</option>
													<option value="board_title">제목</option>
													<option value="board_contents">내용</option>
			                            		</select>
		                            				<input type="search" name="keyword" class="form-control input-sm" placeholder="" aria-controls="dataTables-example"> 
													<input type="hidden" name="board_type" value="${map.board_type}">
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
                            
	                   			<!-- 게시글 목록 테이블 div -->
	                            <div class="row">
		                            <div class="col-sm-12">
										<table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
			                                <thead>
			                                    <tr>
			                                        <th>번호</th>
			                                        <th>제목</th>
			                                        <th>작성자</th>
			                                        <th>날짜</th>
			                                        <th>조회수</th>
			                                    </tr>
			                                </thead>
			                                
			                                <tbody>
				                                <c:forEach var="list" items="${map.list}" >
					                                <tr class="odd gradeA">
					                                    <td>${list.board_no}</td>
					                                    <td><a href="detail?board_type=${map.board_type}&board_no=${list.board_no}">${list.board_title}</a></td>
					                                    <td>${list.board_writer}</td>
					                                    <td class="center">${list.board_date}</td>
					                                    <td class="center">${list.board_viewcount}</td>
					                                </tr>
				                                </c:forEach>
			                                </tbody>
			                            </table>
		                            </div>
	                            </div>
                            
                      			 <!-- 페이징 처리, 글쓰기 버튼 div -->
	                            <div class="row">
	                            	<!-- 글쓰기 버튼  -->
	                            	<div class="col-sm-6">
	                            		 <div class="dataTables_info" id="dataTables-example_info" role="status" aria-live="polite">
	                            		 <button id="writeBtn" type="button" class="btn btn-outline btn-primary">글쓰기</button>
	                            		 </div>
	                            	</div>
	                            
	                            	<!-- 페이징 처리 -->
	                            	<div class="col-sm-6">
			                            <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
				                            <ul class="pagination">	      
				                                                  
				                            	<li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous">
													<a href="boardList?curPage=${map.boardPager.prevPage}&board_type=${map.board_type}&searchOption=${map.searchOption}&keyword=${map.keyword}">Previous</a>
				                            	</li>
				                            	
						                       	<li class="paginate_button " aria-controls="dataTables-example" tabindex="0">
						                           	<c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd }"  >	
						                           		<c:choose>
						                           			<c:when test="${num == map.boardPager.curPage}">
						                           				<span style="color:orange">${num}</span>&nbsp;
						                           			</c:when>
						                           			<c:otherwise>
																<a href="boardList?curPage=${num}&board_type=${map.board_type}&searchOption=${map.searchOption}&keyword=${map.keyword}">${num}</a>&nbsp;
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</li>
				                            		                            
				                            	<li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
				                            		<c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
														<a href="boardList?curPage=${map.boardPager.nextPage}&board_type=${map.board_type}&searchOption=${map.searchOption}&keyword=${map.keyword}">Next</a>
													</c:if>
				                            	</li>
				                            </ul>
			                            </div>
	                           		</div>
	                           		
	                            </div>
                            		    
                            </div>
                            
                            
                            <div class="well">
                                <h4>DataTables Usage Information</h4>
                                <p>DataTables is a very flexible, advanced tables plugin for jQuery. In SB Admin, we are using a specialized version of DataTables built for Bootstrap 3. We have also customized the table headings to use Font Awesome icons in place of images. For complete documentation on DataTables, visit their website at <a target="_blank" href="https://datatables.net/">https://datatables.net/</a>.</p>
                                <a class="btn btn-default btn-lg btn-block" target="_blank" href="https://datatables.net/">View DataTables Documentation</a>
                            </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
	</div>
</div>

<%-- <form action="boardList" method="get">
	<select name="searchOption">
		<option value="all">제목+내용</option>
		<option value="employee_name">작성자</option>
		<option value="board_title">제목</option>
		<option value="board_contents">내용</option>
	</select>
	<input type="text" name="keyword">
	<input type="hidden" name="board_type" value="${map.board_type}">
	<input type="submit" value="검색" >
</form>

<table border="2">
	<tr>
		<td>번호</td>
		<td>제목</td>
		<td>작성자</td>
		<td>작성일시</td
		><td>조회</td>
	</tr>
	<c:forEach var="list" items="${map.list}" >
	<tr>
		<td>${list.board_no}</td>
		<td><a href="detail?board_type=${map.board_type}&board_no=${list.board_no}">${list.board_title}</a></td>
		<td>${list.board_writer}</td>
		<td>${list.board_date}</td>
		<td>${list.board_viewcount}</td>
	</tr>
	</c:forEach>
</table>

<table>
	<tr>
		<td><a href="BoardWrite?boardType=${map.board_type}">글쓰기</a> </td>
	</tr>
	<tr>
		<c:if test="${map.boardPager.curBlock>1}">
			<a href="boardList?curPage=1&board_type=${map.board_type}">[처음]</a>
		</c:if>
		
		<c:if test="${map.boardPager.curBlock>1}">
			<a href="boardList?curPage=${map.boardPager.prevPage}&board_type=${map.board_type}">[이전]</a>
		</c:if>
		
		<c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd }"  >
			<c:choose>
				<c:when test="${num == map.boardPager.curPage}">
					<span style="color:red">${num}</span>&nbsp;
				</c:when>
				<c:otherwise>
					<a href="boardList?curPage=${num}&board_type=${map.board_type}">${num}</a>&nbsp;
				</c:otherwise>
			</c:choose>		
		</c:forEach>
				
		<c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
			<a href="boardList?curPage=${map.boardPager.nextPage}&board_type=${map.board_type}">[다음]</a>
		</c:if>
		
		<c:if test="${map.boardPager.curPage <= map.boardPager.totPage}">
			<a href="boardList?curPage=${map.boardPager.totPage}&board_type=${map.board_type}">[끝]</a>
		</c:if>
		
    </tr>
    
</table> --%>

</body>
</html>