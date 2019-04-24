<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>

<!-- 공통 JS, CSS를 모아서 불러오는 헤더-->
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>

<link href="${pageContext.request.contextPath}/resources/css/board/board.css" rel="stylesheet">

<script type="text/javascript">
	//검색 버튼 클릭시
	$(document).ready(function() {
	//boardType값 저장
		var boardType = '${map.board_type}';
		
	//검색 버튼 클릭시
		$("#searchBtn").click(function(){
			$("#search").submit();
		});
	//글쓰기 버튼 클릭시	
		$("#writeBtn").click(function(){
			location.href = "BoardWrite?board_type="+boardType;
		});
	
	//게시판 타입 heading
		if(boardType =='c'){
	  	  $(".panel-heading").text('커뮤니티');
	  	  $("title").text('커뮤니티');
		}
		else if(boardType=='n'){
		  $(".panel-heading").text('공지사항');
		  $("title").text('공지사항');
		  if(${map.board_writer_no != 0}){
			 $(".writeBtnDiv").hide();
		  }
		}
	//page scale
		$(".selectPageScale").change(function(){
			location.href="boardList?board_type="+boardType+"&page_scale="+$(this).val();
		});
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
                            
	        <!-- 게시글 행 갯수 선택 --> 
	                            <div class="row">
	                            	<div class="col-sm-6">
	                            		<div class="dataTables_length" id="dataTables-example_length">
		                            		<label>Show 
		                            			<select name="dataTables-example_length" aria-controls="dataTables-example" class="form-control input-sm selectPageScale">
			                            			<option value="10" 
			                            				<c:if test="${map.boardPager.page_scale==10}"> selected </c:if> >10</option>
			                            			<option value="15" 
			                            				<c:if test="${map.boardPager.page_scale==15}"> selected </c:if> >15</option>
			                            			<option value="20" 
			                            				<c:if test="${map.boardPager.page_scale==20}"> selected </c:if> >20</option>
			                            			<option value="25" 
			                            				<c:if test="${map.boardPager.page_scale==25}"> selected </c:if> >25</option>
		                            			</select> entries
		                            		</label>
	                            		</div>
	                            	</div>
	                            	
	         <!-- 게시글 검색  -->                   	
	                            	<div class="col-sm-6">
		                            	<div id="dataTables-example_filter" class="form-group input-group dataTables_filter">
		                            		<form action="boardList" method="get" id="search" >
		                            		<label>
			                            		<select name="searchOption" aria-controls="dataTables-example" class="form-control input-sm">
			                            			<option value="all"<c:out value="${map.searchOption=='all'?'selected':''}"/> >제목+내용</option>
													<option value="employee_name" <c:out value="${map.searchOption=='employee_name'?'selected':''}"/>>작성자</option>
													<option value="board_title" <c:out value="${map.searchOption=='board_title'?'selected':''}"/>>제목</option>
													<option value="board_contents" <c:out value="${map.searchOption=='board_contents'?'selected':''}"/>>내용</option>
			                            		</select>
		                            				<input type="search" name="keyword" class="form-control input-sm" value="${map.keyword}" placeholder="" aria-controls="dataTables-example"> 
													<input type="hidden" name="board_type" value="${map.board_type}">
													<input type="hidden" name="page_scale" value="${map.boardPager.page_scale }">
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
                            
	         <!-- 게시글 목록 테이블  -->
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
					                                    <td><a class="text-muted textBoard" href="detail?board_type=${map.board_type}&board_no=${list.board_no}&searchOption=${map.searchOption}&keyword=${map.keyword}&curPage=${map.boardPager.curPage}">${list.board_title}
					                                    		<c:if test="${list.reply_count>0}">
					                                    			<span style="color: orange;">
					                                    				[${list.reply_count}]
					                                    			</span>
					                                    		</c:if>	
					                                    	</a>
					                                    </td>
					                                    <td>${list.board_writer}</td>
					                                    <td class="center">${list.board_date}</td>
					                                    <td class="center">${list.board_viewcount}</td>
					                                </tr>
				                                </c:forEach>
			                                </tbody>
			                            </table>
		                            </div>
	                            </div>
                            
             <!-- 페이징 처리, 글쓰기 버튼 -->
	                            <div class="row">
	                       <!-- 페이징 처리 -->
			                            <div style="text-align: center;" class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
				                            <ul class="pagination">	      
				                                                  
				                            	<li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous">
													<a href="boardList?curPage=${map.boardPager.prevPage}&board_type=${map.board_type}&page_scale=${map.boardPager.page_scale}&searchOption=${map.searchOption}&keyword=${map.keyword}">Previous</a>
				                            	</li>
				                            	
						                       	<li class="paginate_button " aria-controls="dataTables-example" tabindex="0">
						                           	<c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd }"  >	
						                           		<c:choose>
						                           			<c:when test="${num == map.boardPager.curPage}">
						                           				<span style="color:orange">${num}</span>
						                           			</c:when>
						                           			<c:otherwise>
																<a href="boardList?curPage=${num}&board_type=${map.board_type}&page_scale=${map.boardPager.page_scale}&searchOption=${map.searchOption}&keyword=${map.keyword}">${num}</a>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</li>
				                            		                            
				                            	<li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
				                            		<c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
														<a href="boardList?curPage=${map.boardPager.nextPage}&board_type=${map.board_type}&page_scale=${map.boardPager.page_scale}&searchOption=${map.searchOption}&keyword=${map.keyword}">Next</a>
													</c:if>
				                            	</li>
				                            </ul>
			                            </div>
	                            </div>
                            </div>

                        </div>
                        
                        <div class="panel-footer writeBtnDiv">
                            <div class="dataTables_info" id="dataTables-example_info" role="status" aria-live="polite">
	                        		<button id="writeBtn" type="button" class="btn btn-primary"><i class="fa fa-edit"></i></button>
	                    	</div>
                        </div>
                        
                    </div>
                </div>
            </div>
	</div>
</div>

</body>
</html>